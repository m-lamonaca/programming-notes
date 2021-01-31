# Node.js

Asyncronous JavaScript Engine

## Syllabus

Moduli:

- nvm, npm cli
- tutti moduli standard
- alcuni da npm (express?, cors?, nodemon?)

## NVM

### Windows

```ps1
nvm list  # show installed node versions
nvm list available  # list installable versions of node

nvm install <version>  # install a version of node
nvm install latest  # install the latest version of node

nvm use <version>  # set <version> as default one

nvm uninstall <version>  # uninstall a version of node
```

### Linux

```bash
nvm ls  # show installed node versions
nvm ls-remote  # list installable versions of node

nvm install <version>  # install a version of node
nvm install node  # install the latest version of node
nvm install --lts  # install the latest LTS version of node

nvm use <version>  # set <version> as default one

nvm uninstall <version>  # uninstall a version of node
```

## NPM

```ps1
npm init  # init a project
npm install <module>  # install a module as global
npm install <module>  -P|--save-prod # install a module as local (aka --save)
npm install <module>  -D|--save-dev # install a module as local dev dependency
```

## Imports

```js
const pkg = require("module");  // load the file as JS object with an alias
const { component } = require("module");  // load only a component of the module (can lead to name collision)
const alias = require("module").component  // set alias for component
```

## Exports

```js
// definitions

module.exports = <variable/method/class/expression>;  // dafoult export
module.exports.exported_name = <variable/method/class/expression>;
```
