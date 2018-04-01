var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var router = express.Router();
var path = __dirname + '/app/';
var url = require('url');
var fs = require("fs");

router.use(function(req,res,next){
  console.log("/" + req.method);
  console.log("Path: " + path);
  next();
});

router.get("/",function(req,res){
  res.sendFile(path + "index.html");
});

router.get("/AddEmployer.html",function(req,res){
  res.sendFile(path + "/website/Workflow/AddEmployer.html");
});

router.get("/EmployerDashboard.html", function(req,res){
  res.sendFile(path + "/website/Workwlow/EmployerDashboard.html");
});

router.get("/h.html", function(req,res){
  res.sendFile(path + "/website/trash/h.html");
});


app.use(express.static('.'));
app.use(express.static('app'));
app.use(express.static('lib'));
app.use(express.static('js'));
app.use(express.static('website'));
app.use(express.static('Workflow'));

app.use(bodyParser.urlencoded({
  extended: true
}));

app.use(bodyParser.json());

app.post("/parseMyUrl", function(req,res){
  console.log(req.body.url);
  var url_parts = url.parse(req.body.url, true);
  var query = url_parts.query;
  console.log(query.jobID);
  res.send(query.jobID);
})

/*app.post("/website/employer/addnewjob.html", function(req,res){
  console.log(req.body);
});*/


app.use("/", router);

app.listen(3000, function(){
  console.log("Live at 3000!");
});


app.get('/initializeWeb3',function(req,res){
  Web3 = require('web3');
  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
});

Web3 = require('web3');
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

var TruffleContract = require('truffle-contract');

var fileAdmin = 'build/contracts/AdminContract.json';
var contentsAdmin = fs.readFileSync("build/contracts/AdminContract.json");

var filePost = 'build/contracts/PostContract.json';
var contentsPost = fs.readFileSync("build/contracts/PostContract.json");

var fileDepartment = 'build/contracts/DepartmentContract.json';
var contentsDepartment = fs.readFileSync("build/contracts/DepartmentContract.json");

var fileEmployer = 'build/contracts/EmployerContract.json';
var contentsEmployer = fs.readFileSync("build/contracts/EmployerContract.json");

var AdminContractArtifact = JSON.parse(contentsAdmin);
var PostContractArtifact = JSON.parse(contentsPost);
var DepartmentContractArtifact = JSON.parse(contentsDepartment);
var EmployerContractArtifact = JSON.parse(contentsEmployer);

const AdminContract = TruffleContract(AdminContractArtifact);
AdminContract.setProvider(web3.currentProvider);

const PostContract = TruffleContract(PostContractArtifact);
PostContract.setProvider(web3.currentProvider);

const DepartmentContract = TruffleContract(DepartmentContractArtifact);
DepartmentContract.setProvider(web3.currentProvider);

const EmployerContract = TruffleContract(EmployerContractArtifact);
EmployerContract.setProvider(web3.currentProvider);

/*app.post('/createJob',function(req,res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[1];
    HrmContract.deployed().then(function(instance) {
      return instance.createJob(req.body.jobID, req.body.jobTitle, req.body.jobJDLink, {from: account, gas:599999});
    }).then(function(result) {
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
});*/

/*app.post('/getJobs', function(req,res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[1];
    HrmContract.deployed().then(function(instance) {
      return instance.getJobs.call({from: account});
    }).then(function(result) {
      console.log(result);
      res.send(result);
    }).catch(function(err) {
      console.log(err.message);
    });
  });
});*/

/*app.post('/getJobsFromJobNo', function(req,res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[1];
    HrmContract.deployed().then(function(instance) {
      return instance.getJobsFromJobNo.call(req.body.jobNo, {from: account});
    }).then(function(result) {
      console.log(result);
      res.send(result);
    }).catch(function(err) {
      console.log(err.message);
    });
  });
});*/

/*app.post('/getApplicants', function(req,res){
  _jobID = req.body.jobID;
  console.log("_jobID: "+ _jobID);  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[1];
    HrmContract.deployed().then(function(instance) {
      return instance.getApplicants.call(req.body.jobID, {from: account});
    }).then(function(result) {
      console.log(result);
      res.send(result);
    }).catch(function(err) {
      console.log(err.message);
    });
  });
});*/

/*app.post('/getActiveJobs',function(req,res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[2];
    HrmContract.deployed().then(function(instance) {
      return instance.getActiveJobs.call({from: account});
    }).then(function(result) {
      console.log(result);
      res.send(result);
    }).catch(function(err) {
      console.log(err.message);
    });
  });
});*/


/*app.post('/setJobStatus',function(req,res){
  console.log(req.body);
  if(req.body.newStatus == 'true'){
    newStatus=true;
  }else{
    newStatus=false;
  }
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[1];
    HrmContract.deployed().then(function(instance) {
      return instance.setJobStatus(req.body.jobID, newStatus, {from: account, gas:59999999});
    }).then(function(result) {
      console.log(result.receipt);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });});*/
/*app.post('/getApplFromApplNo', function(req,res){
  console.log(req.body.applicantNo);
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[1];
    HrmContract.deployed().then(function(instance) {
      return instance.getApplFromApplNo.call(req.body.applicantNo, {from: account});
    }).then(function(result) {
      console.log(result);
      res.send(result);
    }).catch(function(err) {
      console.log(err.message);
    });
  });
});*/

/*app.post('/viewJobDetails',function(req,res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[2];
    HrmContract.deployed().then(function(instance) {
      return instance.viewJobDetails.call(req.body.jobID, {from: account});
    }).then(function(result) {
      console.log(result);
      res.send(result);
    }).catch(function(err) {
      console.log(err.message);
    });
  });});/*

/*app.post('/applyJob',function(req,res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[2];
    HrmContract.deployed().then(function(instance) {
      return instance.applyJob(req.body.jobID, {from: account});
    }).then(function(result) {
      if(result.receipt.status == 1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
});*/

//new

app.post('/IsAdmin', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = accounts[0];
    AdminContract.deployed().then(function(instance){
      return instance.GetAdminFlag.call({from: account});
    }).then(function(result){
      console.log(result);
      if(result == 1){
        console.log("Admin live");
        res.send(true);
      }else{
        console.log("Admin not live");
        res.send(false);
      }
    }).catch(function(err){
      console.log(err.message);
    });
  });
});

app.post('/SetAdmin', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = accounts[0];
    AdminContract.deployed().then(function(instance){
      return instance.SetAdmin({from: account, gas: 100000});
    }).then(function(result){
      if(result.receipt.status == 1){
        console.log("SetAdmin");
        res.send(true);
      }
    }).catch(function(err){
      console.log(err.message);
    });
  });
});

app.post('/AsrtAdmin', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = accounts[0];
    AdminContract.deployed().then(function(instance){
      return instance.AssertAdmin.call({from: account});
    }).then(function(result){
      if(result == 1){
        console.log("YouAdmin");
        res.send(true);
      }
    }).catch(function(err){
      console.log(err.message);
    });
  });
});

app.post('/CreateEmployer', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = accounts[0];
    EmployerContract.deployed().then(function(instance){
      return instance.CreateEmployer(req.body.fName,req.body.mName, req.body.lName, req.body.rank, {from: account, gas:190000});
    }).then(function(result){
      if(result.receipt.status == 1){
        res.send(true);
      }
    }).catch(function(err){
      console.log(err.message);
      res.send(false);
    });
  });
});

app.post('/GetEmployerArraySize', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    } 
    var account = accounts[0];
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerArraySize.call({from: account});
    }).then(function(result){
      console.log(result);
      res.send(result)
    }).catch(function(err){
      console.log(err.message);
      console.log("DEBIL");
    });
  });
});

app.post('/GetEmployerFromAddr', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = accounts[0];
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerFromEmployerAddr.call({from: account});
    }).then(function(result){
      console.log(result.toNumber());
      res.send('4');
    }).catch(function(err){
      console.log(err.message);
    });
  });
});

app.post('/GetEmployerFromNum', function(req, res){
  console.log("NUMBER ", req.body.empNum);
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = accounts[0];
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerFromEmployerNum.call(req.body.empNum, {from: account});
    }).then(function(result){
      console.log(result);
      res.send(result)
    }).catch(function(err){
      console.log(err.message);
      console.log("DEBIL");
    });
  });
});

/*app.post('/updateJob',function(req,res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = accounts[1];
    HrmContract.deployed().then(function(instance) {
      return instance.updateJob(req.body.jobID, req.body.newJobID, req.body.newJobTitle, req.body.newJobJDLink, {from: account, gas:5999999});
    }).then(function(result) {
      console.log(result);
      res.send(result);
    }).catch(function(err) {
      console.log(err.message);
    });
  });
});*/