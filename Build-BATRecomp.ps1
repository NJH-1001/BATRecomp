$ErrorActionPreference = 'Stop'
$env:Path = 'C:\msys64\mingw64\bin;' + $env:Path
Push-Location $PSScriptRoot
try {
    cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo '-DPSX_GAME_VERSION=0.1.0' -DPSXRECOMP_BIOS_STEMS=OpenBIOS -DPSXRECOMP_BIOS_STEM=OpenBIOS -DPSX_RECOMP_UI=OFF -DPSX_SETUP_WIZARD=OFF -DPSX_REWIND=OFF
    if ($LASTEXITCODE -ne 0) { throw 'CMake configuration failed.' }
    cmake --build build --target psx-runtime -j8
    if ($LASTEXITCODE -ne 0) { throw 'Game build failed.' }
    & 'C:\Program Files\Git\usr\bin\bash.exe' -c 'export PATH=/c/msys64/mingw64/bin:/usr/bin:/mingw64/bin:$PATH; bash psxrecomp/tools/bundle_mingw_dlls.sh --runtime-bin /c/msys64/mingw64/bin --exe build/Battle_Arena_Toshinden_Recompiled.exe'
    if ($LASTEXITCODE -ne 0) { throw 'DLL staging failed.' }
} finally { Pop-Location }
