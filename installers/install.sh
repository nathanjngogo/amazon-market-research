#!/usr/bin/env bash
# Amazon Market Research Skill — macOS/Linux 安装脚本
# 用法: bash install.sh [all|claude|codex|trae|cursor|dsh|hermes]

set -e
PLATFORM="${1:-all}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$(dirname "$SCRIPT_DIR")"  # amazon-market-research 根目录

install_claude() {
    local dest="$HOME/.claude/skills/amazon-market-research"
    echo "[Claude Code] Installing to $dest"
    mkdir -p "$dest"
    cp -r "$SRC_DIR"/* "$dest/"
    rm -f "$dest/CLAUDE.md" "$dest/CODEX.md" "$dest/.cursorrules"
    echo "[Claude Code] Done. Restart Claude Code and use /amazon-market-research"
}

install_codex() {
    cp "$SRC_DIR/AGENTS.md" ./AGENTS.md
    cp "$SRC_DIR/templates/research-config.yaml" ./research-config.yaml
    echo "[Codex] AGENTS.md + config copied to current directory."
}

install_trae() {
    local dest="$HOME/.trae/skills/amazon-market-research"
    echo "[Trae] Installing to $dest"
    mkdir -p "$dest"
    cp -r "$SRC_DIR"/* "$dest/"
    rm -f "$dest/CLAUDE.md" "$dest/CODEX.md" "$dest/.cursorrules"
    echo "[Trae] Done. Restart Trae and use @amazon-market-research"
}

install_cursor() {
    cp "$SRC_DIR/.cursorrules" ./.cursorrules
    cp "$SRC_DIR/AGENTS.md" ./AGENTS.md
    echo "[Cursor] .cursorrules + AGENTS.md copied to current directory."
}

install_dsh() {
    local dest="$HOME/.agents/skills/amazon-market-research"
    echo "[DeepSeek Harness] Installing to $dest"
    mkdir -p "$dest"
    cp -r "$SRC_DIR"/* "$dest/"
    rm -f "$dest/CLAUDE.md" "$dest/CODEX.md" "$dest/.cursorrules"
    echo "[DeepSeek Harness] Done. Restart dsh and use /amazon-market-research"
}

install_hermes() {
    local dest="$HOME/.hermes/skills/productivity/amazon-market-research"
    echo "[Hermes Agent] Installing to $dest"
    mkdir -p "$dest"
    cp -r "$SRC_DIR"/* "$dest/"
    rm -f "$dest/CLAUDE.md" "$dest/CODEX.md" "$dest/.cursorrules"
    echo "[Hermes Agent] Done. Restart Hermes."
}

case "$PLATFORM" in
    all)
        install_claude; install_codex; install_trae; install_cursor; install_dsh; install_hermes
        ;;
    claude) install_claude ;;
    codex)  install_codex ;;
    trae)   install_trae ;;
    cursor) install_cursor ;;
    dsh)    install_dsh ;;
    hermes) install_hermes ;;
    *)      echo "Unknown platform: $PLATFORM. Use: all, claude, codex, trae, cursor, dsh, hermes" ;;
esac

echo ""
echo "=== Next steps ==="
echo "1. Copy templates/research-config.yaml to your working directory and fill in"
echo "2. Ensure Sorftime exports (5 per market) are ready"
echo "3. Start your agent and describe the category + site to research"
