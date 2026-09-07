param(
    [ValidateSet('Off','JVC','Trinitron')][string]$Crt = 'Off',
    [ValidateSet('4:3','16:9')][string]$Aspect = '4:3'
)
$ErrorActionPreference = 'Stop'
$batRoot = $PSScriptRoot
$batExe = Join-Path $batRoot 'build\Battle_Arena_Toshinden_Recompiled.exe'
if (-not (Test-Path -LiteralPath $batExe)) { throw 'Build the game first with Build-BATRecomp.ps1.' }
if ($PSBoundParameters.ContainsKey('Crt') -or $PSBoundParameters.ContainsKey('Aspect')) {
    & (Join-Path $batRoot 'Set-BATDisplayOptions.ps1') -Crt $Crt -Aspect $Aspect
}
$env:PSX_BIOS_HLE = '0'
$env:SDL_GAMECONTROLLERCONFIG_FILE = Join-Path $batRoot 'input\gamecontrollerdb.txt'
$batKeys = Join-Path $batRoot 'build\keybinds.ini'
if (-not (Test-Path -LiteralPath $batKeys)) {
    Copy-Item -LiteralPath (Join-Path $batRoot 'input\keybinds.ini') -Destination $batKeys
}
Push-Location $batRoot
try {
    & $batExe --game (Join-Path $batRoot 'game.toml') --bios (Join-Path $batRoot 'psxrecomp\bios\openbios.bin') --no-launcher
    if ($LASTEXITCODE -ne 0) { throw "Game exited with code $LASTEXITCODE" }
} finally { Pop-Location }
