## My powershell config

To use it, you need to:

1. [Install windows terminal](https://apps.microsoft.com/detail/9n0dx20hk701)
2. [Install PowerShell 7](https://github.com/PowerShell/PowerShell/releases)
3. [Install WinGet](https://github.com/microsoft/winget-cli/releases) (probably already installed)
4. Install the following in your terminal:
```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget  # to use the theme
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi  # to use aws commands
bun i -g serverless  # to use serverless commands
wsl --install  # to use wsl commands
```
