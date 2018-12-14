echo ' * Initializing NPM..'
npm init -y
echo ' * Installing Express, Body-Parser, and Mongoose..'
npm i express body-parser mongoose
echo ' * Writing Project * server.js File..'
cat >| server.js <<EOL
const express = require("express"),
           bp = require("body-parser"),
          app = express(),
      db_name = "$3shop",
         port = 8888;

app.use(bp.json());
app.use(express.static( __dirname + '/client/dist/client' ));

require("./server/config/mongoose")(db_name);
require("./server/config/routes")(app);

app.listen(port, function() {
    console.log(`listening on port \${port}`);
});
EOL
echo ' * Writing Project * package.json File..'
cat >| package.json <<EOL
{
  "name": "Angular",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "nodemon server.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "body-parser": "^1.18.3",
    "express": "^4.16.4",
    "mongoose": "^5.3.15"
  }
}
EOL
echo ' * Writing Project> * .gitignore File..'
cat >| .gitignore << EOL
# See http://help.github.com/ignore-files/ for more about ignoring files.

# compiled output
/dist
/tmp
/out-tsc

# dependencies
/node_modules

# profiling files
chrome-profiler-events.json
speed-measure-plugin.json

# IDEs and editors
/.idea
.project
.classpath
.c9/
*.launch
.settings/
*.sublime-workspace

# IDE - VSCode
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json

# misc
/.sass-cache
/connect.lock
/coverage
/libpeerconnection.log
npm-debug.log
yarn-error.log
testem.log
/typings

# System Files
.DS_Store
Thumbs.db
EOL
echo ' * Calling ../meanpackage/mean-angular.sh..'
. ../meanpackage/mean-angular.sh
