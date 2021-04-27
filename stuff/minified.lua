local a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p=component,computer,unicode,math,{"/init.lua","/OS.lua"},{},{}local function q(r)local s={b.pullSignal(r)}s[1]=s[1]or""if cyan and(s[1]:match("ey")and not cyan:match(s[5])or s[1]:match("cl")and not cyan:match(s[4]))then return""end;g[s[4]or""]=s[1]:match"do"and 1;if g[29]and(g[46]or g[32])and s[1]:match"do"then return"F"end;return table.unpack(s)end;local function t(u,v,w,x,y)y=y or xpcall;local z,A=load("return "..u,v,F,w)if not z then z,A=load(u,v,F,w)end;if z then w=a.invoke;a.invoke=x and function(B,C,...)if l and B==l.address and C=="set"then l.setPaletteColor(9,0x969696)l.setPaletteColor(11,0xb4b4b4)a.invoke=w end;return w(B,C,...)end or w;return y(z,debug.traceback)end;return F,A end;local function D(E)return a.list(E)()and a.proxy(a.list(E)())end;local function G(H,I)o={}for J in H:gmatch"[^\r\n]+"do o[#o+1]=J:gsub("\t",I and"    "or"")end end;local function K(r,L,M)local N,O,u,P=b.uptime()+(r or d.huge)::Q::O,P,P,u=q(N-b.uptime())if O=="F"or O:match"do"and(u==L or L==0)then return 1,M and M()elseif b.uptime()<N then goto Q end end;local function R(S,T,U,V,W)l.setBackground(V or 0x002b36)l.setForeground(W or 0x8cb9c5)l.set(S,T,U)end;local function X(S,T,Y,Z,V,W)l.setBackground(V or 0x002b36)l.setForeground(W or 0x8cb9c5)l.fill(S,T,Y,Z," ")end;local function _()X(1,1,j,k)end;local function a0(a1)return d.floor(j/2-a1/2)end;local function a2(T,H,V,W)R(a0(c.len(H)),T,H,V,W)end;local function a3()l,m=D"gp",D"sc"if l and m then if l.getScreen()~=m.address then l.bind(m.address)end;local a4,a5,a6=m.getAspectRatio()j,k=l.maxResolution()a6=2*(16*a4-4.5)/(16*a5-4.5)if a6>j/k then k=d.floor(j/a6)else j=d.floor(k*a6)end;l.set(1,1,"")l.setResolution(j,k)l.setPaletteColor(9,0x002b36)l.setPaletteColor(11,0x8cb9c5)end end;local function a7(H,a8,a9,L,M)if l and m then _()G(H)local T=d.ceil(k/2-#o/2)if a8 then a2(T-1,a8,0x002b36,0xffffff)T=T+1 end;for aa=1,#o do a2(T,o[aa])T=T+1 end;K(a9 or 0,L or 0,M)end end;local function ab(H,ac)return c.len(H)>ac and c.sub(H,1,ac).."…"or H end;local function ad(ae,T,af,ag,W,w)local H,ah,ai,aj,ak,S,O,al,u,P="",c.len(ae),1,1;W=W or 0x8cb9c5::Q::S=af and a0(c.len(H)+ah)or 1;ak=S+ah+ai-1;X(1,T,j,1)R(S,T,ae..H,F,W)if ak<=j then R(ak,T,l.get(ak,T),aj and W or 0x002b36,aj and 0x002b36 or W)end;O,P,al,u=q(.5)if O:match"do"then if u==203 and ai>1 then ai=ai-1 elseif u==205 and ai<=c.len(H)then ai=ai+1 elseif u==200 and ag then H=ag;ai=c.len(ag)+1 elseif u==208 and ag then H=""ai=1 elseif u==14 and#H>0 and ai>1 then H=g[29]and""or c.sub(c.sub(H,1,ai-1),1,-2)..c.sub(H,ai,-1)ai=g[29]and 1 or ai-1 elseif u==28 then return H elseif al>=32 and c.len(ah..H)<j-ah then H=c.sub(H,1,ai-1)..c.char(al)..c.sub(H,ai,-1)ai=ai+1 end;aj=1 elseif O:match"cl"then H=c.sub(H,1,ai-1)..al..c.sub(H,ai,-1)ai=ai+c.len(al)elseif O:match"mp"or O=="F"then n=O:match"mp"and 1;return elseif not O:match"up"then aj=not aj end;goto Q end;local function am(B)local D,an,ao,aa=a.proxy(B),{s=1}if D and B~=b.tmpAddress()then aa=#f+1;f[aa]={r=D,l=an,d=D,p=function(ap,T)ap=ap and _()or ap;a2(T or k/2,ap and("Booting %s from %s (%s)"):format(ao,D.getLabel()or"N/A",ab(B,j>80 and 36 or 6))or ao and("Boot%s %s (%s)"):format((#an==1 and" "..ao or"").." from",ab(D.getLabel()or"N/A",6),ab(B,6))or("Boot from %s (%s) isn't available"):format(D.getLabel()or"N/A",ab(B,6)),F,not ap and 0xffffff)ap=ap and not h and cyan:match("$")and(a7("Hold ENTER to boot")or K(F,28))end}f[aa].b=function()if ao then local aq,ar,z,as,A=D.open(ao,"r"),""::Q::z=D.read(aq,d.huge)if z then ar=ar..z;goto Q end;D.close(aq)pcall(f[aa].p,1)z=i~=B and b.setBootAddress(B)as,A=t(ar,"="..ao,F,1)as=as and b.shutdown()a3()a7(A,"¯\\_(ツ)_/¯",d.huge,0,b.shutdown)error(A)end end;for at=1,#e do if D.exists(e[at])then ao=ao or e[at]an[#an+1]={e[at],function()ao=e[at]f[aa].b()end}end end end end;local function au()f={}am(i)for B in next,a.list"file"do am(B~=i and B or"")end end;local function av()h=1::aw::local ax,ay,az,aA,aB,aC,O,u,aD,ar,aE,T,aF,w,H,aG,P={s=1},function(aH,T,aI,aJ,aK,aL)local aM,S=0;for aa=1,#aH do aM=aM+c.len(aH[aa][1])+aI end;aM=aM-aI;S=a0(aM)if aL then aL()end;for aa=1,#aH do if aH.s==aa and aK then X(S-aI/2,T-d.floor(aJ/2),c.len(aH[aa][1])+aI,aJ,0x8cb9c5)R(S,T,aH[aa][1],0x8cb9c5,0x002b36)else R(S,T,aH[aa][1],0x002b36,0x8cb9c5)end;S=S+c.len(aH[aa][1])+aI end end;function aB()_()if p then a2(k/2-2,"Select boot entry",F,0xffffff)ay(aC,k/2+2,6,3,1)else T=k/2-(#f>0 and-1 or 1)ay(ax,T-4,8,3,not aC.p and 1,function()if#f>0 then aF=f[ax.s].r;f[ax.s].p(F,T+3)a2(T+5,("Storage %s%% / %s / %s"):format(d.floor(aF.spaceUsed()/(aF.spaceTotal()/100)),aF.isReadOnly()and"Read only"or"Read & Write",aF.spaceTotal()<2^20 and"FDD"or aF.spaceTotal()<2^20*12 and"HDD"or"RAID"))for aa=az,#aA do aA[aa]=F end;if not aF.isReadOnly()then aA[az]={"Rename",function()_()a2(k/2-1,"Rename",F,0xffffff)aD=ad("Enter new name: ",k/2+1,1,F,0x8cb9c5)if aD and#aD>0 then aF.setLabel(aD)au()end end}aA[az+1]={"Format",function()aF.remove("/")aF.setLabel(F)au()end}end else a2(T+3,"No drives available",F,0xffffff)end end)ay(aA,T,6,1,aC.p and 1 or F)end end;aA={s=1,p=1,{"Halt",b.shutdown},{"Shell",function()_()w=setmetatable({print=function(...)H=table.pack(...)for aa=1,H.n do if type(H[aa])=="table"then aG=''for aN,aO in pairs(H[aa])do aG=aG..tostring(aN).."    "..tostring(aO).."\n"end;H[aa]=aG else H[aa]=tostring(H[aa])end end;G(table.concat(H,"    "),1)for aa=1,#o do l.copy(1,1,j,k-1,0,-1)X(1,k-1,j,1)R(1,k-1,o[aa])end end,proxy=D,sleep=function(r)K(r,32,error)end},{__index=_G})::Q::ar=ad("> ",k,F,ar,0xffffff,w)if ar then w.print("> "..ar)X(1,k,j,1)R(1,k,">")w.print(select(2,t(ar,"=shell",w)))goto Q end end},D"net"and{"Netboot",function()_()a2(k/2-1,"Netboot",F,0xffffff)aE=ad("URL: ",k/2+1,1,F,0x8cb9c5)if aE and#aE>0 then local aq,ar,z=D"net".request(aE,F,F,{["user-agent"]="Netboot"}),""if aq then a7("Downloading script...","Netboot")::Q::z=aq.read()if z then ar=ar..z;goto Q end;ar=select(2,t(ar,"=stdin",F,1,pcall))or""a3()a7(ar,"Netboot",#ar==0 and 0 or d.huge)else a7("Invalid URL","Netboot",d.huge)end end end}}az=#aA+1;n=F;p=F;au()for aa=1,#f do ax[aa]={ab(f[aa].d.getLabel()or"N/A",6),function()if#aC>0 and aC==1 then p=aa;aC=f[p].l;aC[1][2]()end end}end;aC=#f>0 and ax or aA::Q::pcall(aB)O,P,P,u=q()if O=="F"then b.shutdown()else if O:match"do"then aC=not p and(u==200 or u==208)and(#f>0 and(aC.p and ax or aA)or aC)or aC;aC.s=u==203 and(aC.s==1 and#aC or aC.s-1)or u==205 and(aC.s==#aC and 1 or aC.s+1)or aC.s;if u==28 then pcall(aC[aC.s][2])end end;if O:match"mp"or n then pcall(a3)goto aw end end;goto Q end;b.getBootAddress=function(...)return D"pro".getData(...)end;b.setBootAddress=function(...)D"pro".setData(...)end;i=b.getBootAddress()au()a3()a7("Hold ALT to stay in bootloader",F,1,56,av)for aa=1,#f do f[aa].b()end;l=l and m and av()or error("No drives available")