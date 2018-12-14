echo ' * Writing Project>Server>Config> * routes.js File..'
cat >| routes.js <<EOL
console.log("inside of routes.js");

const $2s = require("../controllers/$3s");
const $4s = require("../controllers/$5s");

module.exports = function(app){
  app.get("/$3s", $2s.getAll);
  app.post("/$3s", $2s.create);
  app.put("/$3s/:id", $2s.update);
  app.delete("/$3s/:id", $2s.delete);
  app.post("/$5s/:id", $4s.create);
  app.put("/$5s/:$3id", $4s.update);
  app.delete("/$5s/:id", $4s.delete);
}
EOL
echo ' * Writing Project>Server>Config> * mongoose.js File..'
cat >| mongoose.js <<EOL
console.log("inside of mongoose.js");

module.exports = function (db_name){
  const mongoose = require("mongoose");
  const fs = require("fs");
  const path = require("path");
  mongoose.connect('mongodb://localhost/' + db_name, { useNewUrlParser: true });

  for(let file of fs.readdirSync(path.join(__dirname, "../models"))){
    if(file.endsWith(".js")){
      require(path.join(__dirname, "../models", file));
    }
  }
}
EOL
echo ' * Navigating into Project>Server Folder from Project>Server>Config..'
cd ..
echo ' * Calling ../../meanpackage/mean-models.sh..'
. ../../meanpackage/mean-models.sh
