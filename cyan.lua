local COMPONENT, COMPUTER, UNICODE, MATH, bootFiles, bootCandidates, keys, userChecked, width, height, gpu, screen, redraw, lines = component, computer, unicode, math, {"/init.lua", "/OS.lua"}, {}, {}, {}

local function pullSignal(timeout)
    local signal = {COMPUTER.pullSignal(timeout)}
    signal[1] = signal[1] or ""

    if cyan and ( signal[1]:match("ey") and not cyan:match(signal[5]) or signal[1]:match("cl") and not cyan:match(signal[4]) ) then
        return ""
    end

    keys[signal[4] or ""] = signal[1]:match"do" and 1

    if keys[29] and (keys[46] or keys[32]) and signal[1]:match"do" then
        return "F"
    end

    return table.unpack(signal)
end

local function proxy(componentType)
    return COMPONENT.list(componentType)() and COMPONENT.proxy(COMPONENT.list(componentType)())
end

local function split(text, tabulate)
    lines = {}

    for line in text:gmatch"[^\r\n]+" do
        lines[#lines + 1] = line:gsub("\t", tabulate and "    " or "")
    end
end

local function sleep(timeout, breakCode, onBreak, deadline, signalType, code, _)
    deadline = COMPUTER.uptime() + (timeout or MATH.huge)

    ::LOOP::
    signalType, _, _, code = pullSignal(deadline - COMPUTER.uptime())

    if signalType == "F" or signalType:match"do" and (code == breakCode or breakCode == 0) then
        return 1, onBreak and onBreak()
    elseif COMPUTER.uptime() < deadline then
        goto LOOP
    end
end

local function set(x, y, string, background, foreground)
    gpu.setBackground(background or 0x002b36)
    gpu.setForeground(foreground or 0x8cb9c5)
    gpu.set(x, y, string)
end

local function fill(x, y, w, h, background, foreground)
    gpu.setBackground(background or 0x002b36)
    gpu.setForeground(foreground or 0x8cb9c5)
    gpu.fill(x, y, w, h, " ")
end

local function clear()
    fill(1, 1, width, height)
end

local function centrize(len)
    return MATH.floor(width / 2 - len / 2)
end

local function centrizedSet(y, text, background, foreground)
    set(centrize(UNICODE.len(text)), y, text, background, foreground)
end

local function rebindGPU()
    gpu, screen = proxy"gp", proxy"sc"

    if gpu and screen then
        if gpu.getScreen() ~= screen.address then
            gpu.bind((screen.address))
        end

        local aspectWidth, aspectHeight, proportion = screen.getAspectRatio()
        width, height = gpu.maxResolution()

        proportion = 2*(16*aspectWidth-4.5)/(16*aspectHeight-4.5)
        if proportion > width / height then
            height = MATH.floor(width / proportion)
        else
            width = MATH.floor(height * proportion)
        end
        gpu.setResolution(width, height)
        gpu.setPaletteColor(9, 0x002b36)
        gpu.setPaletteColor(11, 0x8cb9c5)
    end
end

local function status(text, title, wait, breakCode, onBreak, y)
    if gpu and screen then
        clear()
        split(text)
        y = MATH.ceil(height / 2 - #lines / 2)

        if title then
            centrizedSet(y - 1, title, 0x002b36, 0xffffff)
            y = y + 1
        end
        for i = 1, #lines do
            centrizedSet(y, lines[i])
            y = y + 1
        end
        sleep(wait or 0, breakCode or 0, onBreak)
    end
end

local function cutText(text, maxLength)
    return UNICODE.len(text) > maxLength and UNICODE.sub(text, 1, maxLength) .. "…" or text
end

local function input(prefix, y, centrized, historyText, foreground)
    local text, prefixLen, cursorPos, cursorState, cursorX, x, signalType, char, code, _ = "", UNICODE.len(prefix), 1, 1
    foreground = foreground or 0x8cb9c5

    ::LOOP::
        x = centrized and centrize(UNICODE.len(text) + prefixLen) or 1
        cursorX = x + prefixLen + cursorPos - 1

        fill(1, y, width, 1)
        set(x, y, prefix .. text, F, foreground)
        if cursorX <= width then
            set(cursorX, y, gpu.get(cursorX, y), cursorState and foreground or 0x002b36, cursorState and 0x002b36 or foreground)
        end

        signalType, _, char, code = pullSignal(.5)  

        if signalType:match"do" then
            if code == 203 and cursorPos > 1 then
                cursorPos = cursorPos - 1
            elseif code == 205 and cursorPos <= UNICODE.len(text) then
                cursorPos = cursorPos + 1
            elseif code == 200 and historyText then
                text = historyText
                cursorPos = UNICODE.len(historyText) + 1
            elseif code == 208 and historyText then
                text = ""
                cursorPos = 1
            elseif code == 14 and #text > 0 and cursorPos > 1 then
                text = keys[29] and "" or UNICODE.sub(UNICODE.sub(text, 1, cursorPos - 1), 1, -2) .. UNICODE.sub(text, cursorPos, -1)
                cursorPos = keys[29] and 1 or cursorPos - 1
            elseif code == 28 then
                return text
            elseif char >= 32 and UNICODE.len(prefixLen .. text) < width - prefixLen then
                text = UNICODE.sub(text, 1, cursorPos - 1) .. UNICODE.char(char) .. UNICODE.sub(text, cursorPos, -1)
                cursorPos = cursorPos + 1
            end
            
            cursorState = 1
        elseif signalType:match"cl" then
            text = UNICODE.sub(text, 1, cursorPos - 1) .. char .. UNICODE.sub(text, cursorPos, -1)
            cursorPos = cursorPos + UNICODE.len(char)
        elseif signalType:match"mp" or signalType == "F" then
            redraw = signalType:match"mp" and 1
            return
        elseif not signalType:match"up" then
            cursorState = not cursorState
        end
    goto LOOP
end

local function execute(code, stdin, env, palette, call)
    call = call or xpcall
    local chunk, err = load("return " .. code, stdin, F, env)

    if not chunk then
        chunk, err = load(code, stdin, F, env)
    end

    if chunk then
        if palette and gpu then
            sleep(.3)
            fill(1, 1, width or 0, height or 0, 0)
            gpu.setPaletteColor(9, 0x969696)
            gpu.setPaletteColor(11, 0xb4b4b4)
        end

        return call(chunk, debug.traceback)
    end
        
    return F, err
end

local function addCandidate(address)
    local proxy, allBootFiles, bootFile, i = COMPONENT.proxy(address), {s = 1, z = 1}

    if proxy and address ~= COMPUTER.tmpAddress() then
        i = #bootCandidates + 1

        bootCandidates[i] = {
            r = proxy,
            l = allBootFiles,
            d = proxy,
            p = function(booting, y)
                booting = booting and clear() or booting

                centrizedSet(y or height / 2,
                    booting and ("Booting %s from %s (%s)"):format(
                        bootFile,
                        proxy.getLabel() or "N/A",
                        cutText(address, width > 80 and 36 or 6)
                    ) or bootFile and ("Boot%s %s (%s)"):format(
                        (#allBootFiles == 1 and " " .. bootFile or "") .. " from",
                        cutText(proxy.getLabel() or "N/A", 6),
                        cutText(address, 6)
                    ) or ("Boot from %s (%s) isn't available"):format(
                        proxy.getLabel() or "N/A",
                        cutText(address, 6)
                    )
                , F, not booting and 0xffffff)

                booting = booting and not userChecked and cyan:match("$") and (status("Hold ENTER to boot") or sleep(F, 28))
            end
        }

        bootCandidates[i].b = function()
            if bootFile then
                local handle, data, chunk, success, err = proxy.open(bootFile, "r"), ""

                ::LOOP::
                chunk = proxy.read(handle, MATH.huge)
        
                if chunk then
                    data = data .. chunk
                    goto LOOP
                end
        
                proxy.close(handle)
                pcall(bootCandidates[i].p, 1)
                chunk = COMPUTER.getBootAddress() ~= address and COMPUTER.setBootAddress(address)
                success, err = execute(data, "=" .. bootFile, F, 1)
                success = success and pcall(COMPUTER.shutdown)
                pcall(rebindGPU)
                pcall(status, err, "¯\\_(ツ)_/¯", MATH.huge, 0, COMPUTER.shutdown)
                error(err)
            end
        end

        for j = 1, #bootFiles do
            if proxy.exists(bootFiles[j]) then
                bootFile = bootFile or bootFiles[j]
                allBootFiles[#allBootFiles + 1] = {
                    bootFiles[j],
                    function()
                        bootFile = bootFiles[j]
                        bootCandidates[i].b()
                    end
                }
            end
        end
    end
end

local function updateCandidates()
    bootCandidates = {}
    addCandidate(COMPUTER.getBootAddress() or "")

    for address in next, COMPONENT.list"file" do
        addCandidate(address ~= COMPUTER.getBootAddress() and address or "")
    end
end

local function drawElements(elements, y, spaces, borderHeight, drawSelected, onDraw)
    local elementsLineLength, x = 0

    for i = 1, #elements do
        elementsLineLength = elementsLineLength + UNICODE.len(elements[i][1]) + spaces
    end

    elementsLineLength = elementsLineLength - spaces
    x = centrize(elementsLineLength)

    if onDraw then
        onDraw()
    end

    for i = 1, #elements do
        if elements.s == i and drawSelected then
            fill(x - spaces / 2, y - MATH.floor(borderHeight / 2), UNICODE.len(elements[i][1]) + spaces, borderHeight, 0x8cb9c5)
            set(x, y, elements[i][1], 0x8cb9c5, 0x002b36)
        else
            set(x, y, elements[i][1], 0x002b36, 0x8cb9c5)
        end

        x = x + UNICODE.len(elements[i][1]) + spaces
    end
end

local function shell(env, data, str, text)
    clear()
    env = setmetatable({
        print = function(...)
            text = table.pack(...)
            for i = 1, text.n do
                if type(text[i]) == "table" then
                    str = ''
        
                    for k, v in pairs(text[i]) do
                        str = str .. tostring(k) .. "    " .. tostring(v) .. "\n"
                    end
        
                    text[i] = str
                else
                    text[i] = tostring(text[i])
                end
            end
            split(table.concat(text, "    "), 1)
        
            for i = 1, #lines do
                gpu.copy(1, 1, width, height - 1, 0, -1)
                fill(1, height - 1, width, 1)
                set(1, height - 1, lines[i])
            end
        end,
        proxy = proxy,
        sleep = function(timeout)
            sleep(timeout, 32, error)
        end
    }, {__index = _G})

    ::LOOP::
    data = input("> ", height, F, data, 0xffffff, env)

    if data then
        env.print("> " .. data)
        fill(1, height, width, 1)
        set(1, height, ">")
        env.print(select(2, execute(data, "=shell", env)))
        goto LOOP
    end
end

local function bootloader()
    userChecked = 1, not gpu and error("No drives available")
    ::UPDATE::
    local elementsBootables, correction, elementsPrimary, selectedElements, signalType, code, newLabel, url, y, drive, bootingEntry, _ = {s = 1}

    elementsPrimary = {
        s = 1,
        p = 1,
        {"Halt", COMPUTER.shutdown},
        {"Shell", shell},
        proxy"net" and {"Netboot", function()
            clear()
            centrizedSet(height / 2 - 1, "Netboot", F, 0xffffff)
            url = input("URL: ", height / 2 + 1, 1, F, 0x8cb9c5)

            if url and #url > 0 then
                local handle, data, chunk = proxy"net".request(url, F, F, {["user-agent"]="Netboot"}), ""

                if handle then
                    status("Downloading script...", "Netboot")
                    ::LOOP::    
                    chunk = handle.read()

                    if chunk then
                        data = data .. chunk
                        goto LOOP
                    end

                    data = select(2, execute(data, "=stdin", F, 1, pcall)) or ""
                    rebindGPU()
                    status(data, "Netboot", #data == 0 and 0 or MATH.huge)
                else
                    status("Invalid URL", "Netboot", MATH.huge)
                end
            end
        end}
    }

    correction = #elementsPrimary + 1
    redraw = F
    bootingEntry = F
    updateCandidates()
    for i = 1, #bootCandidates do
        elementsBootables[i] = {
            cutText(bootCandidates[i].d.getLabel() or "N/A", 6),
            function()
                if #bootCandidates[i].l > 0 then
                    bootingEntry = i
                    selectedElements = bootCandidates[bootingEntry].l

                    if #selectedElements == 1 then
                        selectedElements[1][2]()
                    end
                end
            end
        }
    end
    selectedElements = #bootCandidates > 0 and elementsBootables or elementsPrimary

    ::LOOP::
        pcall(function()
            clear()

            if selectedElements.z then
                centrizedSet(height / 2 - 2, "Select boot entry", F, 0xffffff)
                drawElements(selectedElements, height / 2 + 2, 6, 3, 1)
            else
                y = height / 2 - (#bootCandidates > 0 and -1 or 1)
            
                drawElements(elementsBootables, y - 4, 8, 3, not selectedElements.p and 1, function()
                    if #bootCandidates > 0 then
                        drive = bootCandidates[elementsBootables.s].r
            
                        bootCandidates[elementsBootables.s].p(F, y + 3)
            
                        centrizedSet(y + 5, ("Storage %s%% / %s / %s"):format(
                            MATH.floor(drive.spaceUsed() / (drive.spaceTotal() / 100)),
                            drive.isReadOnly() and "Read only" or "Read & Write",
                            drive.spaceTotal() < 2 ^ 20 and "FDD" or drive.spaceTotal() < 2 ^ 20 * 12 and "HDD" or "RAID")
                        )
            
                        for i = correction, #elementsPrimary do
                            elementsPrimary[i] = F
                        end
            
                        elementsPrimary[correction] = {"Rename", function()
                            clear()
                            centrizedSet(height / 2 - 1, "Rename", F, 0xffffff)
                            newLabel = input("Enter new name: ", height / 2 + 1, 1, F, 0x8cb9c5)
                
                            if newLabel and #newLabel > 0 then
                                drive.setLabel(newLabel)
                                elementsBootables[elementsBootables.s][1] = cutText(drive.getLabel() or "N/A", 6)
                            end
                        end}

                        if not drive.isReadOnly() then
                            elementsPrimary[correction + 1] = {"Format", function()
                                drive.remove("/")
                                drive.setLabel(F)
                                elementsBootables[elementsBootables.s][1] = cutText(drive.getLabel() or "N/A", 6)
                            end}
                        end
                    else
                        centrizedSet(y + 3, "No drives available", F, 0xffffff)
                    end
                end)
    
                drawElements(elementsPrimary, y, 6, 1, selectedElements.p and 1 or F)
            end
        end)
        signalType, _, _, code = pullSignal()
        _ = signalType == "F" and COMPUTER.shutdown()
        
        if signalType:match"mp" or redraw then
            pcall(rebindGPU)
            goto UPDATE
        end

        if signalType:match"do" and gpu and screen then -- if you read this message please help they they forced me to do this
            selectedElements = (code == 200 or code == 208) and (
                selectedElements.z and elementsBootables or #bootCandidates > 0 and ( -- Up
                    selectedElements.p and elementsBootables or elementsPrimary
                )
            ) or selectedElements

            selectedElements.s = 
            code == 203 and ( -- Left
                selectedElements.s == 1 and #selectedElements or selectedElements.s - 1
            ) or code == 205 and (
                selectedElements.s == #selectedElements and 1 or selectedElements.s + 1 -- Right
            ) or selectedElements.s
            
            if code == 28 then -- Enter
                selectedElements[selectedElements.s][2]()
            end
        end
    goto LOOP
end

COMPUTER.getBootAddress = function() return proxy"pro" and proxy"pro".getData() end
COMPUTER.setBootAddress = function(d) return proxy"pro" and proxy"pro".setData(d) end
updateCandidates()
rebindGPU()
status("Hold ALT to stay in bootloader", F, 1, 56, bootloader)
for i = 1, #bootCandidates do
    bootCandidates[i].b()
end
bootloader()