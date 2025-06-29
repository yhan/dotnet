REM Hex literals like F, F0, F00, and F000 are 
REM interpreted as decimal numbers by cmd.exe unless explicitly prefixed with 0x — and start /AFFINITY expects a decimal bitmask.

REM App1: cores 0–3
cmd /C "set DOTNET_GCHeapAffinitizeMask=F && set DOTNET_GCHeapCount=3 && start ""App1"" /NODE 0 /AFFINITY 0xF .\ConsoleApp1.exe"

REM App2: cores 4–7
cmd /C "set DOTNET_GCHeapAffinitizeMask=F0 && set DOTNET_GCHeapCount=3 && start ""App2"" /NODE 0 /AFFINITY 0xF0 .\ConsoleApp1.exe"

REM App3: cores 8–11
cmd /C "set DOTNET_GCHeapAffinitizeMask=F00 && set DOTNET_GCHeapCount=3 && start ""App3"" /NODE 0 /AFFINITY 0xF00 .\ConsoleApp1.exe"

REM App4: cores 12–15
cmd /C "set DOTNET_GCHeapAffinitizeMask=F000 && set DOTNET_GCHeapCount=3 && start ""App4"" /NODE 0 /AFFINITY 0xF000 .\ConsoleApp1.exe"
