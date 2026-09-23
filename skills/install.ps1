<#
.SYNOPSIS
  Symlinks versioned skills from skills/*/ to ~/.cursor/skills/
#>
$ErrorActionPreference = 'Stop'
$Root = $PSScriptRoot
$Target = if ($env:CURSOR_SKILLS_DIR) { $env:CURSOR_SKILLS_DIR } else {
    Join-Path $env:USERPROFILE '.cursor\skills'
}

New-Item -ItemType Directory -Force -Path $Target | Out-Null

Get-ChildItem -Path $Root -Directory | ForEach-Object {
    $skillMd = Join-Path $_.FullName 'SKILL.md'
    if (-not (Test-Path $skillMd)) { return }
    $name = $_.Name
    $dest = Join-Path $Target $name
    if (Test-Path $dest) {
        $item = Get-Item $dest -Force
        # Match install.sh: never delete a real directory/file that is not a link.
        if (-not $item.LinkType) {
            Write-Warning "skip $name - $dest exists and is not a symlink"
            return
        }
        Remove-Item $dest -Force
    }
    New-Item -ItemType SymbolicLink -Path $dest -Target $_.FullName -Force | Out-Null
    Write-Host "linked $name -> $dest" -ForegroundColor Green
}

Write-Host "Done. Skills in: $Target"
