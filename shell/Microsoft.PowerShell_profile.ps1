# Microsoft.PowerShell_profile.ps1
# Template for PowerShell profile.
# Place this in $PROFILE (e.g., ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1)

# Aliases
Set-Alias ll Get-ChildItem
Set-Alias -Name gs -Value git-status-alias
function git-status-alias { git status }

# Variables
$env:EDITOR = "code"

# Set up prompt (Starship or Oh-My-Posh)
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
# Uncomment for Oh-My-Posh instead
# if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
#     oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
# }
