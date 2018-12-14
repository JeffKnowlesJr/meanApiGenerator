echo ' * Writing Project>Server>Config> * routes.js File..'
cat >| routes.js <<EOL
console.log("inside of routes.js");

const $2s = require("../controllers/$3s");

module.exports = function(app){
  app.get("/$3s", $2s.getAll);
  app.post("/$3s", $2s.create);
  app.put("/$3s/:id", $2s.update);
  app.delete("/$3s/:id", $2s.delete);
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
echo ' * Creating Project>Server>Controllers Folder..'
mkdir controllers
echo ' * Navigating into Project>Server>Controllers Folder..'
cd controllers
echo ' * Writing Project>Server>Controllers> * MODELNAMEs.js File..'
cat >| $3s.js <<EOL
console.log("inside of $3s.js");

const mongoose = require("mongoose");
const $2 = mongoose.model("$2");

class $2s {
  create(req, res){
    let $3 = new $2(req.body);
    $3.save(function(err){
      if(err){
        res.json({"status": "not ok", "errors": err});
      }else{
        res.json({"status": "ok", "data": $3});
      }
    });
  }
  getAll(req, res){
    $2.find({}, function(err, $3s){
      if(err){
        res.json({"status": "not ok", "errors": err});
      }else{
        res.json({"status": "ok", "$3s": $3s});
      }
    });
  }
  update(req, res) {
    $2.findOneAndUpdate({_id: req.params.id}, {\$set: {name: req.body.name}}, function(err, data){
      if(err){
        res.json({"status": "not ok", "errors": err});
      }else{
        res.json({"status": "ok", "data": data});
      }
    });
  }
  delete(req, res) {
    $2.findByIdAndRemove({_id: req.params.id}, function(err, data){
      if(err){
        res.json({"status": "not ok", "errors": err});
      }else{
        res.json({"status": "ok", "data": data});
      }
    });
  }
}
module.exports = new $2s();
EOL
echo ' * Writing Project>Server>Controllers> * MODELNAMEs.js File..'
cat >| $5s.js <<EOL
console.log("inside of $5s.js");

EOL
echo ' * Navigating into Project>Server Folder from Project>Server>Controllers..'
cd ..
echo ' * Creating Project>Server>Models Folder..'
mkdir models
echo ' * Navigating into Project>Server>Models Folder..'
cd models
echo ' * Writing Project>Server>Models> * MODELNAME.js File..'
cat >| $3.js <<EOL
console.log("inside of $3.js");

const mongoose = require("mongoose");

const $2Schema = new mongoose.Schema({
  name: {type: String, required: [true, "$2 must have a name"]},
});

mongoose.model('$2', $2Schema);

module.exports = $2Schema;
EOL
echo ' * Navigating into Project>Server Folder from Project>Server>Models..'
cd ..
echo ' * Navigating into Project Folder from Project>Server..'
cd ..
echo ' * Calling ../meanpackage/mean-express.sh..'
. ../meanpackage/mean-express.sh
