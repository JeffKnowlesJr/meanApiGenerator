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
  app.get("/users", Users.getAll);
  app.get("/$3s", $2s.getAll);
  app.post("/users", Users.create);
  app.post("/$3s/:id", $2s.create);
  app.put("/$3s/:id", $2s.update);
  app.delete("/$3s/:id", $2s.delete);
}
EOL
cat >> mongoose.js <<EOL
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
const User = mongoose.model("User");

class $2s {
  create(req, res){
    let $3 = new $2(req.body);
    $3.save(function(err){
      if(err){
        res.json({"status": "not ok", "errors": err});
      }else{
        User.findOneAndUpdate({_id: req.params.id}, {\$push: {$3s: $3}}, function(err, data){
          if(err){
            res.json({"status": "not ok", "errors": err});
          }else{
            res.json({"status": "ok", "data": data});
          }
        });
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
cat >> .gitignore << EOL
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
npm init -y
npm i express mongoose
cat >> server.js <<EOL
console.log("inside of server.js");

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
ng new client
git init
git add .
git commit -m "First Commit"
cd client
cd src
cd app

cat >| app.component.ts << EOL
import { Component } from '@angular/core';
import { $2Service } from './$3.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'MEAN';
  users = [];

  constructor(private _$3Service:$2Service){}

  ngOnInit(){
    this._$3Service.getUsers().subscribe((data) => {
      console.log(data);
      this.users = data['users'];
    });
  }
}
EOL
cat >| app.module.ts << EOL
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { $2Service } from './$3.service';
import { HttpClientModule } from '@angular/common/http';

import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule
  ],
  providers: [$2Service],
  bootstrap: [AppComponent]
})
export class AppModule { }
EOL
cat >| $3.service.ts << EOL
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class $2Service {

  constructor(private _http: HttpClient) { }

  getUsers(){
    return this._http.get("/user");
  }
}
EOL
cd ..
cd ..
rm .gitignore
ng build --watch
