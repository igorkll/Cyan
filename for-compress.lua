local a,b,c,d,e,f,g,h,i=component,computer,math,table,unicode,select,0x002b36,0x8cb9c5,0xffffff;local j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,_,a0,a1,a2="%pass%",%passOnBoot%,{"/OS.lua","/init.lua"},{},{},a.list,a.proxy,c.ceil,b.uptime,b.shutdown,e.len,e.sub,c.huge,d.concat,d.unpack,"key_down","key_up","interrupted"B=function(a3,a4)local a5={b.pullSignal(a3)}if a5[1]==y then n[a5[4]]=1 elseif a5[1]==z then n[a5[4]]=F end;if n[29]and n[56]and n[46]then if a4 then a4()end;return A elseif n[29]and n[32]then return A else return x(a5)end end;K,L,M,N=function(a6)C=o(a6)()return C and p(C)end,function(a7,a8,a9)local aa,ab=load("return "..a7,a8,F,a9)if not aa then aa,ab=load(a7,a8,F,a9)end;if aa then return xpcall(aa,debug.traceback)else return F,ab end end,function(ac,ad)local ae={}for af in ac:gmatch"[^\r\n]+"do ae[#ae+1]=af:gsub("\t",ad and"    "or"")end;return ae end,function(a3,ag,ah)local ai,aj,a7,ak=r()+(a3 or v)repeat aj,ak,ak,a7=B(ai-r())if aj==A or aj==y and(a7==ag or ag==0)then if ah then ah()end;return 1 end until r()>=ai end;local al,am,an=K"gp"or{},K"pr",o"re"()local ao,ap,aq,ar,as,at=al.set,al.setBackground,al.setForeground,al.setPaletteColor,am.setData,am.getData;b.setBootAddress=as;b.getBootAddress=at;if ao and an then D,H,I=al.bind(an),al.maxResolution()G=I/2;ar(9,g)ar(11,h)end;O,P,Q,R,S,T,U,V,Z,W,X,Y,_,a0,a1,a2=function(au,av,aw,ax,ay)ap(ax or g)aq(ay or h)al.set(au,av,aw)end,function(au,av,az,aA,aB,ax,ay)ap(ax or g)aq(ay or h)al.fill(au,av,az,aA,aB)end,function()P(1,1,H,I," ")end,function(aC)return q(H/2-aC/2)end,function(av,ac,ax,ay)O(R(t(ac)),av,ac,ax,ay)end,function(ac,aD,aE,ag,ah,aF)if D then local ae,av=M(ac),r()+(aE or 0)av=q(G-#ae/2)ar(9,g)ar(11,h)Q()if aD then S(av-1,aD,g,i)av=av+1 end;for aG=1,#ae do S(av,ae[aG])av=av+1 end;if aF and D then al.set=function(...)ar(9,0x969696)ar(11,0xb4b4b4)ao(...)al.set=ao end end;return N(aE or 0,ag,ah)end end,function(ab)return D and T(ab,"¯\\_(ツ)_/¯",v,0,s)or error(ab)end,function(C)local K=p(C)if K and K.spaceTotal then m[#m+1]={K,K.getLabel()or"N/A",C}for aG=1,#l do if K.exists(l[aG])then m[#m][4]=l[aG]end end end end,function()m={}V(at())for aH in pairs(o("le"))do V(at()~=aH and b.tmpAddress()~=aH and aH or"")end end,function(ac,aI)return t(ac)>aI and u(ac,1,aI).."…"or ac end,function(aJ,aK,av,aL,aM,aN)local X,aO,aP,aQ,au,aR,aj,aS,a7,ak="",t(aJ),1,1;while 1 do aj,ak,aS,a7=B(.5)if aj==A then X=F;break elseif aj==y then if aS>=32 and t(aO..X)<H-aO-1 then X=u(X,1,aP-1)..e.char(aS)..u(X,aP,-1)aP=aP+1 elseif aS==8 and#X>0 then X=u(u(X,1,aP-1),1,-2)..u(X,aP,-1)aP=aP-1 elseif aS==13 then break elseif a7==203 and aP>1 then aP=aP-1 elseif a7==205 and aP<=t(X)then aP=aP+1 elseif a7==200 and aN then X=aN;aP=t(aN)+1 elseif a7==208 and aN then X=""aP=1 end;aQ=1 elseif aj=="clipboard"then X=u(X,1,aP-1)..aS..u(X,aP,-1)aP=aP+t(aS)elseif aj~=z then aQ=not aQ end;au=aM and R(t(X)+aO)or aK;aR=au+aO+aP-1;P(1,av,H,1," ")O(au,av,aJ..(aL and("*"):rep(t(X))or X),g,i)if aR<=H then O(aR,av,al.get(aR,av),aQ and i or g,aQ and g or i)end end;P(1,av,H,1," ")return X end,function(...)local ac,ae=d.pack(...)for aG=1,ac.n do ac[aG]=tostring(ac[aG])end;ae=M(w(ac,"    "),1)for aG=1,#ae do al.copy(1,1,H,I-1,0,-1)P(1,I-1,H,1," ")O(1,I-1,ae[aG])end end,function(aT,aF)C=W(aT[3],aF and 36 or 6)return aT[4]and("Boot%s %s from %s (%s)"):format(aF and"ing"or"",aT[4],aT[2],C)or("Boot from %s (%s) is not available"):format(aT[2],C)end,function(aT)if aT[4]then local aU,aV,aa,aW,ab=aT[1].open(aT[4],"r"),""::aX::aa=aT[1].read(aU,v)if aa then aV=aV..aa;goto aX end;aT[1].close(aU)if k then a2()end;T(_(aT,1),F,.5,F,F,1)if at()~=aT[3]then as(aT[3])end;aW,ab=L(aV,"="..aT[4])if not aW then U(ab)end;return 1 end end,function(aY,av,aZ,a_,b0)return{e=aY,s=1,y=av,k=a_,b=aZ,d=function(b1,b2,b3)av=b1.y;aZ=b1.b;P(1,av-1,H,3," ",g)E=b3 and E or b1;local b4,b5,b6,au,b7,b8=0,aZ==1 and 6 or 8;if b0 then b0(b1)end;for aG=1,#b1.e do b4=b4+t(b1.e[aG].t)+b5 end;b4=b4-b5;au=R(b4)for aG=1,#b1.e do b7,b8=b1.s==aG and 1,b1.e[aG]b6=t(b8.t)if b7 and not b2 then P(au-b5/2,av-(aZ==1 and 0 or 1),b6+b5,aZ==1 and 1 or 3," ",h)O(au,av,b8.t,h,g)else O(au,av,b8.t,g,h)end;au=au+b6+b5 end end}end,function()if#j>0 and not J then local b9=X("Password: ",F,G,1,1)if b9==F then s()elseif b9~=j then U("Access denied")end;J=1 end end;T("Press ALT to stay in bootloader",F,.5,56,function()a2()::ba::internet=K"in"Z()local a9,aj,a7,aV,bb,bc,bd,aT,K,be,bf,bg,aU,aa,bh,bi,ak=setmetatable({print=Y,proxy=K,os={sleep=function(a3)N(a3,F,function()error("interrupted")end)end}},{__index=_G})bb=a1({{t="Power off",a=function()s()end},{t="Lua 5.3",a=function()Q()::aX::aV=X("> ",1,I,F,F,aV)if aV then Y("> "..aV)O(1,I,">")Y(f(2,L(aV,"=stdin",a9)))goto aX end;bd(F,F,1,1)end}},G+2,1,function()E=bc;bd(1,1,F,F)end)bb.e[#bb.e+1]=internet and{t="Internet boot",a=function()bg,aV=X("URL: ",F,G+7,F,1),""if bg and bg~=""then aU,aa=internet.request(bg),""if aU then T("Downloading...")::aX::aa=aU.read()if aa then aV=aV..aa;goto aX end;aU.close()T(f(2,L(aV,"=internet boot"))or"is empty","Internet boot result",v,0)else T("Malformed URL","Internet boot result",v,0)end end;bd(F,F,1,1)end}if#m>0 then bh=#bb.e+1;bc=a1({},G-2,2,function()E=bb;bd(F,F,1,1)end,function(b1)aT=m[b1.s]K=aT[1]bi=K.spaceTotal()be=K.isReadOnly()P(1,G+5,H,3," ")S(G+5,_(aT),F,i)S(G+7,("Disk usage %s%% / %s / %s"):format(c.floor(K.spaceUsed()/(bi/100)),be and"Read only"or"Read & Write",bi<2^20 and"FDD"or"HDD"))for aG=bh,#bb.e do bb.e[aG]=F end;if be then bb.s=#bb.e else bb.e[bh]={t="Rename",a=function()bf=X("New label: ",F,G+7,F,1)if bf and bf~=""then pcall(K.setLabel,bf)aT[2]=W(bf,16)bc.e[b1.s].t=W(bf,6)end;bc:d(1,1)bb:d()end}bb.e[#bb.e+1]={t="Format",a=function()aT[4]=F;K.remove("/")bc:d(1,1)bb:d()end}end;bb:d(1,1)end)for aG=1,#m do bc.e[aG]={t=W(m[aG][2],6),a=function(b1)a0(m[b1.s])end}end else bb.y=G;bb.b=2 end;bd=function(bj,bk,bl,bm)Q()if bc then bc:d(bl,bm)bb:d(bj,bk)else S(G+4,"No drives available",g,i)bb:d()end;S(I,"Use ← ↑ → to move cursor; Enter to do something; F5 to refresh")end;bd(1,1)::aX::aj,ak,ak,a7=B(v,s)if aj==y then if a7==200 then E.k()elseif a7==208 then E.k()elseif a7==203 and E.s>1 then E.s=E.s-1;E:d()elseif a7==205 and E.s<#E.e then E.s=E.s+1;E:d()elseif a7==28 then E.e[E.s].a(E)elseif a7==63 then goto ba end elseif aj=="component_added"or aj=="component_removed"then goto ba end;goto aX end)Z()for aG=1,#m do if a0(m[aG])then s()end end;U("No bootable medium found!")