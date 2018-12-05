mkdir $1
cd $1
mkdir client
cd client
mkdir static
mkdir views
cd ..
mkdir server
cd server
mkdir config
cd config
cat >> routes.js <<EOL
console.log("inside of routes.js");

const $2s = require("../controllers/$3s");
const Users = require("../controllers/users");

module.exports = function(app){
    app.get("/user", Users.getAll);
    app.post("/user", Users.create);
    app.post("/$3/:_id", $2s.create);
}
EOL
cat >> mongoose.js <<EOL
console.log("inside of mongoose.js");

module.exports = function (db_name){
    const mongoose = require("mongoose");
    const fs = require("fs");
    const path = require("path");
    mongoose.connect('mongodb://localhost/' + db_name);

    for(let file of fs.readdirSync(path.join(__dirname, "../models"))){
        if(file.endsWith(".js")){
            require(path.join(__dirname, "../models", file));
        }
    }
}
EOL
cd ..
mkdir controllers
cd controllers
cat >> users.js <<EOL
console.log("inside of users.js");

const mongoose = require("mongoose");
const User = mongoose.model("User");

class Users {
    getAll(req, res){
        User.find({}, function(err, users){
            if(err){
                res.json({"status": "not ok", "errors": err});
            }else{
                res.json({"status": "ok", "users": users});
            }
        });
    }
    create(req, res){
        let user = new User(req.body);
        user.save(function(err){
            if(err){
                res.json({"status": "not ok", "errors": err});
            }else{
                res.json({"status": "ok"});
            }
        });
    }
}

module.exports = new Users();
EOL
cat >> $3s.js <<EOL
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
                User.findOneAndUpdate({_id: req.params._id}, {\$push: {$3s: $3}}, function(err, data){
                    if(err){
                        res.json({"status": "not ok", "errors": err});
                    }else{
                        res.json({"status": "ok", "data": data});
                    }
                });
            }
        });
    }
}

module.exports = new $2s();
EOL
cd ..
mkdir models
cd models
cat >> user.js <<EOL
console.log("inside of user.js");

const mongoose = require("mongoose");
const $2Schema = require("./$3.js");

const UserSchema = new mongoose.Schema({
    name: {type: String, required: [true, "User must have a name"]},
    $3s: [$2Schema]
});

mongoose.model('User', UserSchema);
EOL
cat >> $3.js <<EOL
console.log("inside of $3.js");

const mongoose = require("mongoose");

const $2Schema = new mongoose.Schema({
    name: {type: String, required: [true, "$2 must have a name"]},
});

mongoose.model('$2', $2Schema);

module.exports = $2Schema;
EOL
cd ..
cd ..
echo 'node_modules/' > .gitignore
npm init -y
npm i express ejs body-parser mongoose
cat >> server.js <<EOL
const express = require("express"),
           bp = require("body-parser"),
          app = express(),
      db_name = "$3shop",
         port = 8888;

app.use(bp.json());

require("./server/config/mongoose")(db_name);
require("./server/config/routes")(app);

app.listen(port, function() {
    console.log(`listening on port ${port}`);
});
EOL
