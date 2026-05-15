#!/bin/bash

set -e

echo "=================================================="
echo " REMOVENDO AMBIENTES ANTIGOS"
echo "=================================================="

# ==================================================
# REMOVER VERSÕES ANTIGAS
# ==================================================

sudo apt purge -y \
    nodejs \
    npm \
    code \
    git \
    yarn \
    eslint \
    snapd || true

sudo apt autoremove -y
sudo apt autoclean -y

# ==================================================
# REMOVER CONFIGURAÇÕES ANTIGAS
# ==================================================

rm -rf ~/.nvm
rm -rf ~/.npm
rm -rf ~/.vscode
rm -rf ~/.config/Code
rm -rf ~/.cache/Code

# ==================================================
# ATUALIZAÇÃO DO SISTEMA
# ==================================================

echo "=================================================="
echo " ATUALIZANDO SISTEMA"
echo "=================================================="

sudo apt update && sudo apt upgrade -y

# ==================================================
# INSTALAR DEPENDÊNCIAS BÁSICAS
# ==================================================

echo "=================================================="
echo " INSTALANDO DEPENDÊNCIAS"
echo "=================================================="

sudo apt install -y \
    curl \
    wget \
    git \
    unzip \
    build-essential \
    ca-certificates \
    gnupg \
    software-properties-common

# ==================================================
# CONFIGURAR GIT
# ==================================================

echo "=================================================="
echo " CONFIGURANDO GIT"
echo "=================================================="

git config --global user.name "trilhas"
git config --global user.email "trilhas@email.com"

git --version

echo ""
echo "Configuração Git:"
git config --list

# ==================================================
# INSTALAR NVM
# ==================================================

echo "=================================================="
echo " INSTALANDO NVM"
echo "=================================================="

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# ==================================================
# CARREGAR NVM
# ==================================================

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ==================================================
# INSTALAR NODE LTS
# ==================================================

echo "=================================================="
echo " INSTALANDO NODE.JS LTS"
echo "=================================================="

nvm install --lts

nvm use --lts

nvm alias default node

# ==================================================
# TESTAR NODE E NPM
# ==================================================

echo ""
echo "Node:"
node -v

echo ""
echo "NPM:"
npm -v

# ==================================================
# INSTALAR VISUAL STUDIO CODE
# ==================================================

echo "=================================================="
echo " INSTALANDO VISUAL STUDIO CODE"
echo "=================================================="

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

sudo install -D -o root -g root -m 644 packages.microsoft.gpg \
/etc/apt/keyrings/packages.microsoft.gpg

echo \
"deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" \
| sudo tee /etc/apt/sources.list.d/vscode.list

rm -f packages.microsoft.gpg

sudo apt update

sudo apt install -y code

# ==================================================
# AGUARDAR CRIAÇÃO DAS PASTAS DO VS CODE
# ==================================================

mkdir -p ~/.config/Code/User

# ==================================================
# CONFIGURAÇÕES DO VS CODE
# ==================================================

echo "=================================================="
echo " CONFIGURANDO VS CODE"
echo "=================================================="

cat > ~/.config/Code/User/settings.json <<EOF
{
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "workbench.colorTheme": "Default Dark+",
    "editor.tabSize": 2,
    "files.autoSave": "afterDelay",
    "terminal.integrated.defaultProfile.linux": "bash"
}
EOF

# ==================================================
# INSTALAR EXTENSÕES VS CODE
# ==================================================

echo "=================================================="
echo " INSTALANDO EXTENSÕES"
echo "=================================================="

extensions=(
    "MS-CEINTL.vscode-language-pack-pt-BR"
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"
    "christian-kohler.path-intellisense"
    "EditorConfig.EditorConfig"
    "mikestead.dotenv"
    "ritwickdey.LiveServer"
    "ecmel.vscode-html-css"
    "formulahendry.auto-rename-tag"
    "pranaygp.vscode-css-peek"
    "xabikos.JavaScriptSnippets"
    "humao.rest-client"
    "rangav.vscode-thunder-client"
)

for extension in "${extensions[@]}"
do
    echo "Instalando: $extension"
    code --install-extension $extension --force
done

# ==================================================
# CRIAR TEMPLATE NODE.JS
# ==================================================

echo "=================================================="
echo " CRIANDO TEMPLATE NODE.JS"
echo "=================================================="

mkdir -p ~/Projetos/WebTemplate

cd ~/Projetos/WebTemplate

npm init -y

npm install express cors dotenv

npm install -D nodemon

# ==================================================
# CRIAR APP.JS
# ==================================================

cat > app.js <<EOF
const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
    res.json({
        mensagem: 'Servidor Node.js funcionando!'
    });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(\`Servidor rodando na porta \${PORT}\`);
});
EOF

# ==================================================
# CRIAR .ENV
# ==================================================

cat > .env <<EOF
PORT=3000
EOF

# ==================================================
# CONFIGURAR PACKAGE.JSON
# ==================================================

node <<EOF
const fs = require('fs');

const pkg = JSON.parse(fs.readFileSync('package.json'));

pkg.scripts = {
    "start": "node app.js",
    "dev": "nodemon app.js"
};

fs.writeFileSync(
    'package.json',
    JSON.stringify(pkg, null, 2)
);
EOF

# ==================================================
# INSTALAR ESLINT GLOBAL
# ==================================================

echo "=================================================="
echo " INSTALANDO ESLINT"
echo "=================================================="

npm install -g eslint

# ==================================================
# INSTALAR PRETTIER GLOBAL
# ==================================================

echo "=================================================="
echo " INSTALANDO PRETTIER"
echo "=================================================="

npm install -g prettier

# ==================================================
# FINALIZAÇÃO
# ==================================================

echo ""
echo "=================================================="
echo " INSTALAÇÃO FINALIZADA!"
echo "=================================================="

echo ""
echo "Ferramentas instaladas:"
echo ""
echo "✔ Git"
echo "✔ Node.js LTS"
echo "✔ npm"
echo "✔ NVM"
echo "✔ VS Code"
echo "✔ ESLint"
echo "✔ Prettier"
echo "✔ Extensões VS Code"
echo "✔ Template Node.js + Express"
echo ""

echo "Projeto criado em:"
echo ""
echo "   ~/Projetos/WebTemplate"
echo ""

echo "Para executar o projeto:"
echo ""
echo "   cd ~/Projetos/WebTemplate"
echo "   npm run dev"
echo ""

echo "Acesse:"
echo ""
echo "   http://localhost:3000"
echo ""