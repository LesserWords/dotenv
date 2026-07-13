<#
.SYNOPSIS
    Symlinks Windows configurations to their appropriate locations.
.PARAMETER Force
    Replace existing non-symlink targets after backing them up. Without -Force,
    existing real files are skipped (symlinks are still replaced).
#>
param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$RepoRoot = $PSScriptRoot

function Backup-Target {
    param([string]$Path)
    if (-not (Test-Path $Path)) { return }
    $stamp = Get-Date -Format 'yyyyMMddHHmmss'
    $bak = "$Path.bak.$stamp"
    Copy-Item -LiteralPath $Path -Destination $bak -Force -Recurse
    Write-Host "Backup: $bak" -ForegroundColor DarkGray
}

function Set-ConfigLink {
    param(
        [string]$Source,
        [string]$Target,
        [string]$Label
    )
    if (-not (Test-Path $Source)) { return }

    if (Test-Path $Target) {
        $item = Get-Item $Target -Force
        if ($item.LinkType) {
            Remove-Item $Target -Force
        } elseif ($Force) {
            Backup-Target $Target
            Remove-Item $Target -Force -Recurse
        } else {
            Write-Warning "skip $Label — $Target exists (use -Force to backup and replace)"
            return
        }
    }

    $parent = Split-Path -Parent $Target
    if ($parent -and -not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force | Out-Null
    Write-Host "Linked $Label → $Target" -ForegroundColor Green
}

Write-Host "Setting up Windows Configurations..." -ForegroundColor Cyan
if (-not $Force) {
    Write-Host "Tip: pass -Force to backup and replace existing non-symlink configs." -ForegroundColor DarkGray
}

Set-ConfigLink `
    -Source (Join-Path $RepoRoot "shell\Microsoft.PowerShell_profile.ps1") `
    -Target $PROFILE `
    -Label "PowerShell Profile"

$WTSettingsDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
Set-ConfigLink `
    -Source (Join-Path $RepoRoot "terminal\windows-terminal-settings.json") `
    -Target (Join-Path $WTSettingsDir "settings.json") `
    -Label "Windows Terminal Settings"

Set-ConfigLink `
    -Source (Join-Path $RepoRoot "tools\.npmrc") `
    -Target (Join-Path $env:USERPROFILE ".npmrc") `
    -Label ".npmrc"

if (Test-Path (Join-Path $RepoRoot "sync.ps1")) {
    Write-Host "Next: .\skills\install.ps1 then .\sync.ps1" -ForegroundColor Yellow
}

Write-Host "Setup Complete!" -ForegroundColor Cyan
