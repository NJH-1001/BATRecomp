param(
    [ValidateSet('Off','JVC','Trinitron')][string]$Crt = 'Off',
    [ValidateSet('4:3','16:9')][string]$Aspect = '4:3'
)
$ErrorActionPreference = 'Stop'
$batState = Join-Path $PSScriptRoot 'build\mods\state.toml'
$batExisting = if (Test-Path -LiteralPath $batState) { Get-Content -LiteralPath $batState -Raw } else { "format_version = 2`n" }
# Preserve other packages and features, including their option/resource tables.
$batBlocks = [regex]::Split($batExisting, '(?m)(?=^\[\[(?:package|feature)\]\]\s*$)')
$batRetained = @($batBlocks | Where-Object {
    $_ -notmatch '(?m)^\s*(?:id|package_id)\s*=\s*"bat\.presentation"\s*$'
}) -join ''
$batEnabled = ($Crt -ne 'Off').ToString().ToLowerInvariant()
$batWideEnabled = ($Aspect -eq '16:9').ToString().ToLowerInvariant()
$batPreset = if ($Crt -eq 'Trinitron') { 'trinitron' } else { 'jvc' }
$batOwn = @"

[[package]]
id = "bat.presentation"
version = "1.0.0"

[[feature]]
package_id = "bat.presentation"
id = "crt"
enabled = $batEnabled
[feature.values]
preset = "$batPreset"

[[feature]]
package_id = "bat.presentation"
id = "wide"
enabled = $batWideEnabled

"@
New-Item -ItemType Directory -Force (Split-Path $batState) | Out-Null
if (Test-Path -LiteralPath $batState) { Copy-Item -LiteralPath $batState -Destination ($batState + '.bak') -Force }
[System.IO.File]::WriteAllText($batState, $batRetained.TrimEnd() + "`n" + $batOwn + "`n", [System.Text.UTF8Encoding]::new($false))
Write-Output "Display options saved: CRT=$Crt, aspect=$Aspect. Restart the game to apply."
