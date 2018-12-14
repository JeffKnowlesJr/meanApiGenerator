echo ' * Creating Project>Server>Controllers Folder..'
mkdir controllers
echo ' * Navigating into Project>Server>Controllers Folder..'
cd controllers
echo ' * Writing Project>Server>Controllers> * MODELNAMEs.js File..'
cat >| $3s.js <<EOL
console.log("inside of $3s.js");

const mongoose = require("mongoose");
const $2 = mongoose.model("$2");

let options = {
  new:true,
  runValidators:true
}

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
    $2.findOneAndUpdate({_id: req.params.id}, {\$set: {name: req.body.name, style: req.body.style, description: req.body.description}}, options, function(err, data){
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

const mongoose = require("mongoose");
const $4 = mongoose.model("$4");
const $2 = mongoose.model("$2");

let options = {
  new:true,
  runValidators:true
}

class $4s {
  create(req, res){
    let $5 = new $4(req.body);
    $5.save(function(err){
      if(err){
        res.json({"status": "not ok", "errors": err});
      }else{
        $2.findOneAndUpdate({_id: req.params.id}, {\$push: {$5s: $5}}, options, function(err, data){
          if(err){
            res.json({"status": "not ok", "errors": err});
          }else{
            res.json({"status": "ok", "data": data});
          }
        });
      }
    });
  }
  update(req, res) {
    $4.findOne({_id: req.params.id}, function(err, data){
      if(err){
        res.json({"status": "not ok", "errors": err});
      }else{
        let $5Id = req.params.id;
        $4.findOneAndUpdate({_id: req.params.id}, {\$set: {name: req.body.name, rating: req.body.rating, $5: req.body.$5}}, options, function(err, data){
          if(err){
            res.json({"status": "not ok", "errors": err});
          }else{
            let updated$4 = data;
            $2.findOne({_id: req.params.$3id}, function(err, data){
              if(err){
                res.json({"status": "not ok", "errors": err});
              }else{
                console.log("options ", options);
                console.log("data ", data);
                let $5Array = data.$5s;
                console.log("$5Array ", $5Array);
                console.log("updated$4", updated$4);
                let $5Index = $5Array.findIndex(i => i._id == $5Id);
                console.log("indexof", $5Index);
                $5Array[$5Index] = updated$4;
                console.log("$5Array", $5Array);
                $2.findOneAndUpdate({_id: req.params.$3id}, {\$set: {$5s: $5Array}}, options, function(err, data){
                  if(err){
                    res.json({"status": "not ok", "errors": err});
                  }else{
                    res.json({"status": "ok", "data": data});
                  }
                });
              }
            });
          }
        });
      }
    });
  }
  delete(req, res) {
    $4.findByIdAndRemove({_id: req.params.id}, function(err, data){
      if(err){
        res.json({"status": "not ok", "errors": err});
      }else{
        res.json({"status": "ok", "data": data});
      }
    });
  }
}

module.exports = new $4s();
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
const $4Schema = require("./$5");

const $2Schema = new mongoose.Schema({
    name: {
      type: String,
      required: [true, "$2 must have a name"],
      maxlength: [255, "$4s must be maxX 255 characters"]
    },
    style: {
      type: String,
      required: [true, "Food style is required"],
      minlength:2,
      maxlength: [255, "style must be maxX 255 characters"]
    },
    // note in depth validations for min length
    description: {
      type: String,
      required: [true, "Food description is required"],
      minlength:[10, "$4s must be at least 10 characters"],
      maxlength: [255, "description must be maxX 255 characters"]
    },
    avgRating: {
      type: Number
    },
    $5s: [$4Schema]
    // timestamps createdAt updatedAt
}, {timestamps: true});

// Setting the name of our $3 here
mongoose.model('$2', $2Schema);

// One to many between Trucks and $4s
// Food Truck
//   Name (string)
//   Style (string)
//   Description (string)
//   $4s [] ($4 Objects)
//   Avg Rating (Number)
EOL
echo ' * Writing Project>Server>Models> * MODELNAME.js File..'
cat >| $5.js <<EOL
console.log("inside of $5.js");

const mongoose = require("mongoose");

const $4Schema = new mongoose.Schema({
    name: {type: String, required: [true, "$4er must have a name"], maxlength:255},
    rating: {type: Number, required: [true, "$4er must enter a rating"], min:0, max:5},
    $5: {type: String, required: [true, "$4er must enter a $5"], minlength:10, maxlength:255},
}, {timestamps: true});

mongoose.model('$4', $4Schema);

// required for $5 to be accessable from $3.js
module.exports = $4Schema;

// $4
//   $5er Name
//   Rating
//   $4
EOL
echo ' * Navigating into Project>Server Folder from Project>Server>Models..'
cd ..
echo ' * Navigating into Project Folder from Project>Server..'
cd ..
echo ' * Calling ../meanpackage/mean-express.sh..'
. ../meanpackage/mean-express.sh
