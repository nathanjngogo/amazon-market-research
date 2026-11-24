# Amazon Market Research Skill — Windows 安装脚本
# 用法: powershell -ExecutionPolicy Bypass -File install.ps1 [-Platform all|claude|codex|trae|cursor|dsh|hermes]

param([string]$Platform = "all")

$SrcDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SrcDir = Split-Path -Parent $SrcDir  # 回到 amazon-market-research 根目录

function Install-ClaudeCode {
    $dest = "$env:USERPROFILE\.claude\skills\amazon-market-research"
    Write-Host "[Claude Code] Installing to $dest"
    Copy-Item -Recurse -Force "$SrcDir\*" $dest -Exclude "CLAUDE.md","CODEX.md",".cursorrules","installers"
    Write-Host "[Claude Code] Done. Restart Claude Code and use /amazon-market-research"
}

function Install-Codex {
    $dest = "$PWD\AGENTS.md"
    Copy-Item -Force "$SrcDir\AGENTS.md" $dest
    Copy-Item -Force "$SrcDir\templates\research-config.yaml" "$PWD\research-config.yaml"
    Write-Host "[Codex] AGENTS.md + config copied to current directory. Codex auto-discovers AGENTS.md."
}

function Install-Trae {
    $dest = "$env:USERPROFILE\.trae\skills\amazon-market-research"
    Write-Host "[Trae] Installing to $dest"
    Copy-Item -Recurse -Force "$SrcDir\*" $dest -Exclude "CLAUDE.md","CODEX.md",".cursorrules","installers"
    Write-Host "[Trae] Done. Restart Trae and use @amazon-market-research"
}

function Install-Cursor {
    Copy-Item -Force "$SrcDir\.cursorrules" "$PWD\.cursorrules"
    Copy-Item -Force "$SrcDir\AGENTS.md" "$PWD\AGENTS.md"
    Write-Host "[Cursor] .cursorrules + AGENTS.md copied to current directory."
}

function Install-DSH {
    $dest = "$env:USERPROFILE\.agents\skills\amazon-market-research"
    Write-Host "[DeepSeek Harness] Installing to $dest"
    Copy-Item -Recurse -Force "$SrcDir\*" $dest -Exclude "CLAUDE.md","CODEX.md",".cursorrules","installers"
    Write-Host "[DeepSeek Harness] Done. Restart dsh and use /amazon-market-research"
}

function Install-Hermes {
    $dest = "$env:LOCALAPPDATA\hermes\skills\productivity\amazon-market-research"
    Write-Host "[Hermes Agent] Installing to $dest"
    Copy-Item -Recurse -Force "$SrcDir\*" $dest -Exclude "CLAUDE.md","CODEX.md",".cursorrules","installers"
    Write-Host "[Hermes Agent] Done. Restart Hermes."
}

switch ($Platform) {
    "all" {
        Install-ClaudeCode; Install-Codex; Install-Trae; Install-Cursor; Install-DSH; Install-Hermes
    }
    "claude" { Install-ClaudeCode }
    "codex" { Install-Codex }
    "trae" { Install-Trae }
    "cursor" { Install-Cursor }
    "dsh" { Install-DSH }
    "hermes" { Install-Hermes }
    default { Write-Host "Unknown platform. Use: all, claude, codex, trae, cursor, dsh, hermes" }
}

Write-Host ""
Write-Host "=== Next steps ==="
Write-Host "1. Copy templates/research-config.yaml to your working directory and fill in"
Write-Host "2. Ensure Sorftime exports (5 per market) are ready"
Write-Host "3. Start your agent and describe the category + site to research"
