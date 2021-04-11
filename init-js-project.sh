#!/bin/bash

npm init -y
npm install eslint --save-dev
./node_modules/eslint/bin/eslint.js --init


npm install prettier --save-dev


npm install eslint-config-prettier eslint-plugin-prettier --save-dev

npm i -D eslint eslint-config-prettier eslint-plugin-prettier prettier

tmp=$(mktemp)

jq '.extends[.extends|length] |= . + "prettier" | .plugins[.plugins|length] |= . + "prettier" | .rules += {"prettier/prettier":"error"}' .eslintrc.json > "$tmp" && mv "$tmp" .eslintrc.json

tmp=$(mktemp)
jq '.scripts += {"eslint": "eslint . --fix"}' package.json > "$tmp" && mv "$tmp" package.json


touch .prettierrc.json
cat <<EOT >> .prettierrc.json
{
  "semi": false
}
EOT

mkdir css && touch ./css/style.css
touch index.html
touch app.js

cat <<EOT >> index.html
<!DOCTYPE html>
<html lang="en">
<link href="css/style.css" rel="stylesheet">
<script src='app.js'></script>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
</body>
</html>
EOT

mkdir .vscode && touch settings.json
cat <<EOT >> .vscode/settings.json
{
  "editor.formatOnSave": true,
  "[javascript]": {
    "editor.formatOnSave": false
  },
  "editor.codeActionsOnSave": {
    "source.fixAll": true
 }
}
EOT

code .
