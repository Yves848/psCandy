oh-my-posh init pwsh --config ~/.config/themes/catppuccin_mocha.omp.json | Invoke-Expression

Import-Module terminal-icons

Set-Alias -Name "ll" -Value "Get-ChildItem" -Option AllScope
Set-Alias -Name "la" -Value "Get-ChildItem -Force -Option AllScope"

$User = "yves"
$PWord = ConvertTo-SecureString -String "daeGh@id379@@" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($User, $PWord)

New-PSDrive -Name "N" -PSProvider FileSystem -Root "\\192.168.50.133\NAS" -Credential $Credential -Persist -ErrorAction SilentlyContinue | Out-Null
New-PSDrive -Name "O" -PSProvider FileSystem -Root "\\192.168.50.133\Yves" -Credential $Credential -Persist -ErrorAction SilentlyContinue | Out-Null
New-PSDrive -Name "P" -PSProvider FileSystem -Root "\\192.168.50.133\Scans" -Credential $Credential -Persist -ErrorAction SilentlyContinue | Out-Null
New-PSDrive -Name "Git" -PSProvider FileSystem -Root "c:\Users\yves\git" -Scope Global -ErrorAction SilentlyContinue  | Out-Null

<#
    FZF Section
#>

# --- fzf par défaut (bordures visibles en plein écran grâce à la marge)
$env:FZF_DEFAULT_OPTS = @"
--border=rounded
--margin=1
--ansi
--height=40%
"@ -replace "`r?`n", ' '  # compacter sur une ligne
# --preview-window=right,60%,wrap

# --- Résoudre le bon binaire fzf.exe (scoop, ou PATH)
function Get-FzfPath {
    $candidates = @(
        "$env:USERPROFILE\scoop\apps\fzf\current\fzf.exe",
        "$env:USERPROFILE\scoop\shims\fzf.exe",
        (Get-Command fzf.exe -ErrorAction SilentlyContinue).Source
    ) | Where-Object { $_ -and (Test-Path $_) }
    if (-not $candidates) { throw "fzf.exe introuvable" }
    return $candidates[0]
}

function Invoke-Fzf {
    param(
        [string]$Prompt,
        [string]$PreviewCmd,   # ex: 'bat --style=numbers --color=always --line-range=:300 {}'
        [string[]]$Input_
    )
    $fzf = Get-FzfPath

    # Preview par défaut : bat si dispo, sinon PowerShell
    if (-not $PreviewCmd) {
        if (Get-Command bat -ErrorAction SilentlyContinue) {
            $PreviewCmd = 'bat --style=numbers --color=always --line-range=:300 {}'
        }
        else {
            # Affiche les 300 premières lignes, en “safe”
            $PreviewCmd = 'powershell -NoProfile -Command "Get-Content -Path ''{}'' -TotalCount 300 | Out-String"'
        }
    }

    $args_ = @()
    if ($Prompt) { $args_ += @('--prompt', "$Prompt> ") }
    $args_ += @('--preview', $PreviewCmd)

    if ($Input_) {
        $Input_ | & $fzf @args_
    }
    else {
        & $fzf @args_
    }
}

function fzf-file {
    param([string]$Root = ".")
    $files = Get-ChildItem -Path $Root -File -Recurse -ErrorAction SilentlyContinue |
    Select-Object -Expand FullName
    $sel = Invoke-Fzf -Prompt 'file' -Input $files
    if ($sel) { code -- "$sel" }
}

function fzf-cd {
    param([string]$Root = ".")
    $dirs = Get-ChildItem -Path $Root -Directory -Recurse -ErrorAction SilentlyContinue |
    Select-Object -Expand FullName
    $sel = Invoke-Fzf -Prompt 'cd' -Input $dirs
    if ($sel) { 
        Set-Location -Path $sel
    }
}

function fzf-rg {
    param(
        [Parameter(Mandatory)]
        [string]$Query
    )
    if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
        throw "Installe ripgrep (rg) pour fzf-rg"
    }
    $rg = "rg --vimgrep --no-heading --line-number --color=always " + ('"{0}"' -f $Query)
    $lines = Invoke-Expression $rg
    if (-not $lines) { return }

    # Preview : montre le fichier sur la ligne trouvée
    $sel = Invoke-Fzf -Prompt "rg:$Query" -PreviewCmd 'bat --color=always --style=numbers --highlight-line {2} {1}' -Input $lines
    if (-not $sel) { return }

    # rg --vimgrep → format: path:line:col:text
    $parts = $sel -split ":", 4
    $path, $line, $col, $text = $parts
    if ($path) { code -g "$path" }
}

if (Get-Module -ListAvailable PSReadLine) {
    Import-Module PSReadLine

    # Ctrl+T : insérer un chemin choisi par fzf-file dans la ligne courante
    Set-PSReadLineKeyHandler -Key Ctrl+t -ScriptBlock {
        $tmp = New-TemporaryFile
        try {
            $sel = & {
                $files = Get-ChildItem -File -Recurse -ErrorAction SilentlyContinue | Select-Object -Expand FullName
                Invoke-Fzf -Prompt 'insert-file' -Input $files
            }
            if ($sel) {
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert($sel)
            }
        }
        finally { Remove-Item $tmp -ErrorAction SilentlyContinue }
    }

    # Ctrl+R : historique avec fzf
    Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock {
        $hist = Get-History | Sort-Object Id | ForEach-Object { "{0,5}  {1}" -f $_.Id, $_.CommandLine }
        if ($hist) {
            $sel = Invoke-Fzf -Prompt 'history' -Input $hist
            if ($sel -match '^\s*(\d+)\s{2,}(.*)$') {
                $cmd = $Matches[2]
                # [Microsoft.PowerShell.PSConsoleReadLine]::ReprintLine()
                # [Microsoft.PowerShell.PSConsoleReadLine]::ClearLine()
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert($cmd)
            }
        }
    }

    
    Set-PSReadLineKeyHandler -Key Ctrl+g -ScriptBlock {
        fzf-cd -Root git:

    }
}