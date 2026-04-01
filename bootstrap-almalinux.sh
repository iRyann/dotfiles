#!/usr/bin/env bash
# Bootstrap dotfiles — AlmaLinux OS 10.x
set -euo pipefail

echo "==> [1/7] EPEL + outils de base"
sudo dnf install -y epel-release
sudo dnf install -y \
  git curl wget unzip tar gzip \
  gcc gcc-c++ make cmake \
  python3 python3-pip python3-venv \
  ripgrep fd-find \
  xauth xorg-x11-apps \
  zathura zathura-pdf-mupdf \
  tmux stow

echo "==> [2/7] Neovim (AppStream EL10 ou dernière release GitHub)"
if dnf list available neovim &>/dev/null; then
  sudo dnf install -y neovim
else
  # Fallback : binaire pré-compilé depuis GitHub
  NVIM_VER="v0.10.4"
  curl -LO "https://github.com/neovim/neovim/releases/download/${NVIM_VER}/nvim-linux-x86_64.tar.gz"
  sudo tar -C /usr/local --strip-components=1 -xzf nvim-linux-x86_64.tar.gz
  rm nvim-linux-x86_64.tar.gz
fi

echo "==> [3/7] Node.js (LTS via NodeSource — requis par ts_ls, prettier…)"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
sudo dnf install -y nodejs

echo "==> [4/7] Outils Python (formatters none-ls)"
pip3 install --user black isort mypy

echo "==> [5/7] Stylua (formatter Lua)"
cargo install stylua 2>/dev/null || {
  # Fallback binaire
  curl -LO https://github.com/JohnnyMorganz/StyLua/releases/latest/download/stylua-linux-x86_64.zip
  unzip stylua-linux-x86_64.zip -d ~/.local/bin/
  chmod +x ~/.local/bin/stylua
  rm stylua-linux-x86_64.zip
}

echo "==> [6/7] Déploiement GNU Stow"
cd "$(dirname "$0")/.."
stow nvim tmux gdb -t ~/.

echo ""
echo "Bootstrap terminé."
echo " -> Lance nvim, :Lazy sync, puis :Mason pour installer les LSPs."
echo ""
echo " RAPPEL MobaXterm : installe une Nerd Font (ex. 'Hack Nerd Font')"
echo " dans Settings > Configuration > Terminal > Font pour les icônes."
