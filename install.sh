#!/usr/bin/env bash
set -e

main() {
    BIN_DIR=${BIN_DIR-"$HOME/.local/bin"}
    mkdir -p "$BIN_DIR"

    case $SHELL in
    */zsh)
        PROFILE=$HOME/.zshrc
        ;;
    */bash)
        PROFILE=$HOME/.bash_profile
        [ -f "$HOME/.bashrc" ] && PROFILE="$HOME/.bashrc"
        ;;
    */fish)
        PROFILE=$HOME/.config/fish/config.fish
        ;;
    *)
        echo "could not detect shell, manually add ${BIN_DIR} to your PATH."
        exit 1
    esac

    if [[ ":$PATH:" != *":${BIN_DIR}:"* ]]; then
        echo "Adding ${BIN_DIR} to your PATH in ${PROFILE}"
        echo >> "$PROFILE" && echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$PROFILE"
        echo "Please restart your shell or source ${PROFILE} to apply PATH changes."
    fi

    PLATFORM="$(uname -s)"
    case $PLATFORM in
    Linux) PLATFORM="linux" ;;
    Darwin) PLATFORM="darwin" ;;
    *) echo "Unsupported platform: $PLATFORM"; exit 1 ;;
    esac

    ARCHITECTURE="$(uname -m)"
    case $ARCHITECTURE in
    x86_64|amd64) ARCHITECTURE="amd64" ;;
    arm64|aarch64) ARCHITECTURE="arm64" ;;
    *) echo "Unsupported architecture: $ARCHITECTURE"; exit 1 ;;
    esac

    BINARY_URL="https://github.com/mohramadan911/gptcli/releases/latest/download/gptcli-${PLATFORM}-${ARCHITECTURE}"
    echo "Downloading gptcli from $BINARY_URL"

    curl -L "$BINARY_URL" -o "$BIN_DIR/gptcli"
    chmod +x "$BIN_DIR/gptcli"

    echo "gptcli installed successfully to $BIN_DIR/gptcli"
    echo "Version: $(gptcli --version)"
}

main "$@" || exit 1
