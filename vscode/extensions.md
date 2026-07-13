# VSCode Extensions

Install all at once (PowerShell):

```powershell
$extensions = @(
  # Themes / UI
  "Terpsikhore.terpsikhore-theme"
  "PKief.material-icon-theme"

  # AI
  "GitHub.copilot"
  "GitHub.copilot-chat"

  # Formatting / Linting
  "esbenp.prettier-vscode"
  "dbaeumer.vscode-eslint"
  "ms-python.python"
  "ms-python.black-formatter"
  "charliermarsh.ruff"

  # Git
  "eamodio.gitlens"
  "mhutchie.git-graph"

  # Languages
  "bradlc.vscode-tailwindcss"
  "ms-vscode.vscode-typescript-next"
  "ms-dotnettools.csharp"
  "rust-lang.rust-analyzer"

  # Utilities
  "christian-kohler.path-intellisense"
  "usernamehw.errorlens"
  "streetsidesoftware.code-spell-checker"
  "ms-vscode-remote.remote-ssh"
  "ms-vscode.remote-explorer"
)
foreach ($ext in $extensions) { code --install-extension $ext }
```
