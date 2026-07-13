<#
.SYNOPSIS
  Merges preferences + process phases into Claude global CLAUDE.md. Linux/macOS: sync.sh
.PARAMETER Yes
  Write without confirmation.
.PARAMETER Cursor
  Also write ~/.cursor/rules/global-standards.mdc
#>
param(
    [switch]$Yes,
    [switch]$Cursor
)
$ErrorActionPreference = 'Stop'
$Root = $PSScriptRoot

$banner = @"
# Claude Code — synced from dotenv
# Source: preferences/universal.md + process/* + languages.md + models
# Re-run: sync.ps1 — edit preferences/ and process/ instead of this file.

"@

$universal = Get-Content (Join-Path $Root 'preferences\universal.md') -Raw
$languages = Get-Content (Join-Path $Root 'preferences\languages.md') -Raw
$claudeTail = Get-Content (Join-Path $Root 'claude\CLAUDE.md') -Raw
$processFiles = Get-ChildItem (Join-Path $Root 'process') -Filter '*.md' -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -match '^[0-9]' } | Sort-Object Name

$models = if ($claudeTail -match '(?s)(## Models.*)$') { $Matches[1] } else { '' }

function Build-Body {
    $body = $banner + "`n" + $universal
    foreach ($f in $processFiles) {
        $body += "`n`n---`n`n" + (Get-Content $f.FullName -Raw)
    }
    $body += "`n`n---`n`n" + $languages + "`n`n---`n`n" + $models
    return $body
}

function Build-CursorMdc {
    $front = @"
---
description: Global standards — planning, design, coding, testing (dotenv)
alwaysApply: true
---

"@
    $body = $front + $universal
    foreach ($f in $processFiles) {
        $body += "`n`n" + (Get-Content $f.FullName -Raw)
    }
    return $body + "`n`n" + $languages
}

$out = Build-Body
$claudeTarget = Join-Path $env:USERPROFILE '.claude\CLAUDE.md'
$cursorRule = Join-Path $env:USERPROFILE '.cursor\rules\global-standards.mdc'

Write-Host "Preview first 40 lines:" -ForegroundColor Cyan
($out -split "`n" | Select-Object -First 40) -join "`n"
Write-Host "`nClaude target: $claudeTarget" -ForegroundColor Yellow

$writeClaude = $Yes
if (-not $writeClaude) {
    $confirm = Read-Host 'Write to ~/.claude/CLAUDE.md? (y/N)'
    $writeClaude = ($confirm -eq 'y')
}
if ($writeClaude) {
    New-Item -ItemType Directory -Force -Path (Split-Path $claudeTarget) | Out-Null
    if (Test-Path $claudeTarget) {
        $bak = "$claudeTarget.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Copy-Item $claudeTarget $bak -Force
        Write-Host "Backup: $bak" -ForegroundColor DarkGray
    }
    Set-Content -Path $claudeTarget -Value $out -Encoding utf8
    Write-Host "Wrote $claudeTarget" -ForegroundColor Green
} else {
    Write-Host 'Skipped Claude write.' -ForegroundColor DarkYellow
}

if ($Cursor -or $Yes) {
    New-Item -ItemType Directory -Force -Path (Split-Path $cursorRule) | Out-Null
    if (Test-Path $cursorRule) {
        $bak = "$cursorRule.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Copy-Item $cursorRule $bak -Force
        Write-Host "Backup: $bak" -ForegroundColor DarkGray
    }
    Set-Content -Path $cursorRule -Value (Build-CursorMdc) -Encoding utf8
    Write-Host "Wrote $cursorRule" -ForegroundColor Green
} else {
    Write-Host 'Re-run with -Cursor for ~/.cursor/rules/global-standards.mdc' -ForegroundColor Cyan
}
Write-Host 'Skills: .\skills\install.ps1' -ForegroundColor Cyan
Write-Host 'Linux/macOS: ./sync.sh --yes --cursor' -ForegroundColor DarkGray
