
# Doc
https://learn.microsoft.com/en-us/dotnet/core/runtime-config/garbage-collector


# Nb of heaps control & gcMode=Server

```
    <PropertyGroup>
        <ServerGarbageCollection>true</ServerGarbageCollection>
        <ConcurrentGarbageCollection>true</ConcurrentGarbageCollection>
    </PropertyGroup>

    <ItemGroup>
        <!-- injects "System.GC.HeapCount": 10 into runtimeconfig.json -->
        <RuntimeHostConfigurationOption Include="System.GC.HeapCount" Value="2" />
        <!-- if you want to be explicit instead of using ServerGarbageCollection -->
        <RuntimeHostConfigurationOption Include="System.GC.Server" Value="true" />
    </ItemGroup>
```



*.runtimeconfig.json

```
{
  "runtimeOptions": {
    "tfm": "net8.0",
    "framework": {
      "name": "Microsoft.NETCore.App",
      "version": "8.0.0"
    },
    "configProperties": {
      "System.GC.HeapCount": 2,   // can be set by env var DOTNET_GCHeapCount
      "System.GC.Server": true,
      "System.GC.Concurrent": true,
      "System.Runtime.Serialization.EnableUnsafeBinaryFormatterSerialization": false
    }
  }
}

```

// bind to 4 first cores 1111 1111
start "console" /NODE 0 /AFFINITY F .\ConsoleApp1.exe

// start with windbg simple
windbg -g -o .\ConsoleApp1.exe

// start with windbg with cpu AFFINITY cores: 0-3
start "debugConsole" /NODE 0 /AFFINITY F windbg -g -o .\ConsoleApp1.exe

- Once you hit your first breakpoint, load the SOS debugging extension

.loadby sos clr            // for .NET 4.x
// or
.loadby sos coreclr        // for .NET Core apps under WinDbgPreview


- Run the SOS command to dump GC heap info:

!EEHeap -gc
Number of GC Heaps: 10



!EEVersion
8.0.1725.26602 free
8,0,1725,26602 @Commit: 77545d6fd5ca79bc08198fd6d8037c14843f14ad
Server mode with 2 gc heaps
SOS Version: 8.0.10.5301 retail build



Install windbg
https://developer.microsoft.com/en-us/windows/downloads/sdk-archive/
Install sdk link
Install only "Debugging Tools for Windows"
This is the component that installs:

* windbg.exe
* cdb.exe, ntsd.exe, kdbgctrl.exe, etc.

After installation, you'll find WinDbg here:
C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\windbg.exe
You can also find the x86 version under Debuggers\x86\.