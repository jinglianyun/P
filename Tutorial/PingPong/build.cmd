set THISDIR=%~dp0
pushd %THISDIR%
set pc=..\..\bld\drops\Release\x64\Binaries\pc.exe
if not exist "%pc%" goto :noP

set pt=..\..\bld\drops\Release\x64\Binaries\pt.exe

msbuild /p:Platform=x64 /p:Configuration=Release PingPong.vcxproj

%pc% /generate:C# /shared ..\Timer\Timer.p /t:Timer.4ml /outputDir:..\Timer

%pc% /generate:C# /shared Main.p PingPong.p Safety.p Liveness.p /t:PingPong.4ml /r:..\Timer\timer.4ml

%pc% /link /shared TestScript.p /r:PingPong.4ml /r:..\Timer\timer.4ml

%pt% /psharp Test0.dll

%pt% /psharp Test1.dll

goto :eof
:noP
echo please run ..\..\bld\build release x64
exit 1
