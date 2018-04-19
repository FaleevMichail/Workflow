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
  res.sendFile(path + "/website/Workflow/EmployerDashboard.html");
});

router.get("/UpdateEmployer.html", function(req,res){
  res.sendFile(path + "/website/Workflow/UpdateEmployer.html");
});

router.get("/DepartmentDashboard.html", function(req,res){
  res.sendFile(path + "/website/Workflow/DepartmentDashboard.html");
});

router.get("/DepartmentsEmployers.html", function(req,res){
  res.sendFile(path + "/website/Workflow/DepartmentsEmployers.html");
});

router.get("/PostDashboard.html", function(req,res){
  res.sendFile(path + "/website/Workflow/PostDashboard.html");
});

router.get("/PostsEmployers.html", function(req,res){
  res.sendFile(path + "/website/Workflow/PostsEmployers.html");
});

router.get("/ReportDashboard.html", function(req,res){
  res.sendFile(path + "/website/Workflow/ReportDashboard.html");
});

router.get("/ReportsInfo.html", function(req,res){
  res.sendFile(path + "/website/Workflow/ReportsInfo.html");
});

router.get("/ReportsForEmployerId.html", function(req,res){
  res.sendFile(path + "/website/Workflow/ReportsForEmployerId.html");
});

router.get("/ReportFromEmployer.html", function(req,res){
  res.sendFile(path + "/website/Workflow/ReportFromEmployer.html");
});

router.get("/EmployerData.html", function(req,res){
  res.sendFile(path + "/website/Workflow/EmployerData.html");
});

router.get("/ReportCreate.html", function(req,res){
  res.sendFile(path + "/website/Workflow/ReportCreate.html");
});

router.get("/ReportAccept.html", function(req,res){
  res.sendFile(path + "/website/Workflow/ReportAccept.html");
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

app.post("/ParseMyUrlEmpId", function(req,res){
  console.log(req.body.url);
  var url_parts = url.parse(req.body.url, true);
  var query = url_parts.query;
  console.log(query.emplyerID);
  res.send(query.employerID);
})

app.post("/ParseMyUrlDepId", function(req,res){
  console.log(req.body.url);
  var url_parts = url.parse(req.body.url, true);
  var query = url_parts.query;
  console.log(query.departmentID);
  res.send(query.departmentID);
})

app.post("/ParseMyUrlPostId", function(req,res){
  console.log(req.body.url);
  var url_parts = url.parse(req.body.url, true);
  var query = url_parts.query;
  console.log(query.postID);
  res.send(query.postID);
})

app.post("/ParseMyUrlRepId", function(req,res){
  console.log(req.body.url);
  var url_parts = url.parse(req.body.url, true);
  var query = url_parts.query;
  console.log(query.repID);
  res.send(query.repID);
})

app.use("/", router);

app.listen(3000, function(){
  console.log("Live at 3000!");
});


app.get("/initializeWeb3",function(req,res){
  Web3 = require('web3');
  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
});

Web3 = require('web3');
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
//console.log("----------", web3.eth.accounts[0]);
var TruffleContract = require('truffle-contract');

var fileAdmin = 'build/contracts/AdminContract.json';
var contentsAdmin = fs.readFileSync("build/contracts/AdminContract.json");
var AdminContractArtifact = JSON.parse(contentsAdmin);
const AdminContract = TruffleContract(AdminContractArtifact);
AdminContract.setProvider(web3.currentProvider);

var filePost = 'build/contracts/PostContract.json';
var contentsPost = fs.readFileSync("build/contracts/PostContract.json");
var PostContractArtifact = JSON.parse(contentsPost);
const PostContract = TruffleContract(PostContractArtifact);
PostContract.setProvider(web3.currentProvider);

var fileDepartment = 'build/contracts/DepartmentContract.json';
var contentsDepartment = fs.readFileSync("build/contracts/DepartmentContract.json");
var DepartmentContractArtifact = JSON.parse(contentsDepartment);
const DepartmentContract = TruffleContract(DepartmentContractArtifact);
DepartmentContract.setProvider(web3.currentProvider);

var fileEmployer = 'build/contracts/EmployerContract.json';
var contentsEmployer = fs.readFileSync("build/contracts/EmployerContract.json");
var EmployerContractArtifact = JSON.parse(contentsEmployer);
const EmployerContract = TruffleContract(EmployerContractArtifact);
EmployerContract.setProvider(web3.currentProvider);

var fileReport = 'build/contracts/ReportContract.json';
var contentsReport = fs.readFileSync("build/contracts/ReportContract.json");
var ReportContractArtifact = JSON.parse(contentsReport);
const ReportContract = TruffleContract(ReportContractArtifact);
ReportContract.setProvider(web3.currentProvider);

var use_account;
app.post('/GetUseAccount', function(req, res){
  console.log("---------",req.body.account);
  use_account = req.body.account;
  res.send("true");
})

app.post('/IsAdmin', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = use_account;
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
    console.log(use_account);
    var account = use_account;
    //account = accounts[0];
    AdminContract.deployed().then(function(instance){
      return instance.AssertAdmin.call({from: use_account});
    }).then(function(result){
      if(result == 1){
        console.log("YouAdmin");
        res.send(true);
      }else{
        res.send(false);
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
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.CreateEmployer(req.body.fName,req.body.mName, req.body.lName, req.body.rank, {from: account, gas:1900000});
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

app.post('/UpdateEmployerFromNum', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.UpdateEmployerFromNum(req.body.num, req.body.rank, {from: account, gas:190000});
    }).then(function(result){
      if(result.receipt.status == 1){
        res.send(true);
      }
    }).catch(function(err){
      console.log(err.message);
      res.send(false);
    });
  });
})

app.post('/UpdateEmployerWorkplaceFromNum', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    console.log("UpdateEmployerWorkplaceFromNum", req.body.confirmFlag);
    //var account = accounts[0];
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.UpdateEmployerWorkplaceFromNum(req.body.num, req.body.post, req.body.department, req.body.confirmFlag, {from: account, gas:190000});
    }).then(function(result){
      if(result.receipt.status == 1){
        res.send(true);
      }
    }).catch(function(err){
      console.log(err.message);
      res.send(false);
    });
  });
})

app.post('/GetEmployerArraySize', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    } 
    //var account = accounts[0];
    var account = use_account;
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
    //var account = accounts[0];
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerFromEmployerAddr.call({from: account});
    }).then(function(result){
      console.log(result);
      res.send('4');
    }).catch(function(err){
      console.log(err.message);
    });
  });
});

app.post('/GetEmployerNumFromEmployerAddr', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerNumFromEmployerAddr.call({from: account});
    }).then(function(result){
      console.log("GetEmployerNumFromEmployerAddr", result);
      res.send(result);
    }).catch(function(err){
      console.log(err.message);
    })
  })
})

app.post('/GetEmployerFromNum', function(req, res){
  var employerData = new Array;
  console.log("NUMBER ", req.body.empNum);
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerFromEmployerNum.call(req.body.empNum, {from: account});
    }).then(function(result){
      employerData.push(result);
      console.log(result);
    }).catch(function(err){
      console.log(err.message);
      console.log("DEBIL");
    });
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerWorkplaceFromNum.call(req.body.empNum, {from: account});
    }).then(function(result){
      employerData.push(result);
      console.log(result);
      res.send(employerData);
    }).catch(function(err){
      console.log(err.message);
      console.log("DEBIL");
    });
  });
});

app.post('/GetEmployerDataFromAddr', function(req, res){
  var employerData = new Array;
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerFromEmployerAddr.call({from: account});
    }).then(function(result){
      employerData.push(result);
      console.log("GetEmployerFromEmployerAddr",result);
    }).catch(function(err){
      console.log(err.message);
      console.log("DEBIL");
    });
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployerWorkplaceFromAddr.call({from: account});
    }).then(function(result){
      employerData.push(result);
      console.log("GetEmployerWorkplaceFromAddr",result);
      res.send(employerData);
    }).catch(function(err){
      console.log(err.message);
      console.log("DEBIL");
    });
  });
});

app.post('/GetEmployersFromDepartmentId', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployersFromDepartmentId.call(req.body.department);
    }).then(function(result){
          console.log(result);
          res.send(result);
        }).catch(function(err){
          console.log("GetEmployersFromDepartmentId: ", err.message);
        });
  });
})

app.post('/GetEmployersFromPostId', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    EmployerContract.deployed().then(function(instance){
      return instance.GetEmployersFromPostId.call(req.body.post);
    }).then(function(result){
          console.log(result);
          res.send(result);
        }).catch(function(err){
          console.log("GetEmployersFromPostId: ", err.message);
        });
  });
})

app.post('/GetRanks', function(req, res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    EmployerContract.deployed().then(function(instance) {
      return instance.GetRanks.call();
    }).then(function(result) {
      console.log(result);
      res.send(result)
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
})

app.post('/GetRankFromNum', function(req, res){
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    console.log(req.body.rankNum);
    EmployerContract.deployed().then(function(instance) {
      return instance.GetRankFromNum.call(req.body.rankNum);
    }).then(function(result) {
      console.log(result);
      res.send(result);
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
})

app.post('/UpdateStatusEmployer',function(req,res){
  console.log("Update for ", req.body);
  if(req.body.newStatus == 'true'){
    newStatus=true;
  }else{
    newStatus=false;
  }
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    var account = use_account;
    EmployerContract.deployed().then(function(instance) {
      return instance.UpdateStatusEmployer(req.body.empNum, newStatus, {from: account, gas:50000});
    }).then(function(result) {
      console.log(result.receipt);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
});

app.post('/GetDepartmentArraySize', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    } 
    //var account = accounts[0];
    var account = use_account;
    DepartmentContract.deployed().then(function(instance){
      return instance.GetDepartmentArraySize.call({from: account});
    }).then(function(result){
      console.log(result);
      res.send(result)
    }).catch(function(err){
      console.log(err.message);
      console.log("DEBIL");
    });
  });
});

app.post('/GetDepartmentFromDepartmentNum', function(req, res){
  console.log("NUMBER ", req.body.depNum);
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = use_account;
    DepartmentContract.deployed().then(function(instance){
      return instance.GetDepartmentFromDepartmentNum.call(req.body.depNum, {from: account});
    }).then(function(result){
      console.log("GetEmployersFromDepartmentId: ", result);
      res.send(result)
    }).catch(function(err){
      console.log("GetDepartmentFromDepartmentNum: ", err.message);
      console.log("DEBIL");
    });
  });
});

app.post('/GetPostArraySize', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    } 
    //var account = accounts[0];
    var account = use_account;
    PostContract.deployed().then(function(instance){
      return instance.GetPostArraySize.call({from: account});
    }).then(function(result){
      console.log("GetPostArraySize: ", result);
      res.send(result)
    }).catch(function(err){
      console.log(err.message);
    });
  });
});

app.post('/GetPostFromPostNum', function(req, res){
  console.log("NUMBER ", req.body.postNum);
  web3.eth.getAccounts(function(error, accounts){
    if (error){
      console.log(error);
    }
    var account = use_account;
    PostContract.deployed().then(function(instance){
      return instance.GetPostFromPostNum.call(req.body.postNum, {from: account});
    }).then(function(result){
      console.log(result);
      res.send(result)
    }).catch(function(err){
      console.log("GetPostFromPostNum: ", err.message);
    });
  });
});

app.post('/UpdateStatusDepartment',function(req,res){
  console.log("Update for ", req.body);
  if(req.body.newStatus == 'true'){
    newStatus=true;
  }else{
    newStatus=false;
  }
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    DepartmentContract.deployed().then(function(instance) {
      return instance.UpdateStatusDepartment(req.body.depNum, newStatus, {from: account, gas:50000});
    }).then(function(result) {
      console.log(result.receipt);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
});

app.post('/UpdateStatusPost',function(req,res){
  console.log("Update for ", req.body);
  if(req.body.newStatus == 'true'){
    newStatus=true;
  }else{
    newStatus=false;
  }
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    PostContract.deployed().then(function(instance) {
      return instance.UpdateStatusPost(req.body.postNum, newStatus, {from: account, gas:50000});
    }).then(function(result) {
      console.log(result.receipt);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
});

app.post('/CreateDepartment', function(req, res){
  console.log("Create department: ", req.body.depTitle);
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    DepartmentContract.deployed().then(function(instance) {
      return instance.CreateDepartment(req.body.depTitle, {from: account, gas:3000000});
    }).then(function(result) {
      console.log(result.receipt);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
});

app.post('/CreatePost', function(req, res){
  console.log("Create post: ", req.body.postTitle);
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    PostContract.deployed().then(function(instance) {
      return instance.CreatePost(req.body.postTitle, {from: account, gas:3000000});
    }).then(function(result) {
      console.log(result.receipt);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
});

app.post('/GetEmployerReportSize', function(req, res){
  console.log('GetEmployerReportSize');
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance){
      return instance.GetEmployerReportSize.call();
    }).then(function(result){
      console.log(result);
      res.send(result);
    }).catch(function(err){
      console.log("GetEmployerReportSize: ", err.message);
    });
  });
});

app.post('/GetEmployersReportFromNum', function(req, res){
  console.log('GetEmployersReportFromNum', req.body.emplNum);
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance){
      return instance.GetEmployersReportFromNum.call(req.body.emplNum);
    }).then(function(result){
      console.log(result);
      res.send(result);
    }).catch(function(err){
      console.log("GetEmployersReportFromNum: ", err.message);
    });
  })
})

app.post('/GetEmployersReportListFromNum', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance){
      return instance.GetEmployersReportListFromNum.call(req.body.emplNum);
    }).then(function(result){
      console.log(result);
      res.send(result);
    }).catch(function(err){
      console.log("GetEmployersReportListFromNum: ", err.message);
    });
  })
})

app.post('/UpdateStatusReprot',function(req,res){
  console.log("Update for ", req.body);
  if(req.body.newStatus == 'true'){
    newStatus=true;
  }else{
    newStatus=false;
  }
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance) {
      return instance.UpdateStatusReprot(req.body.empNum, newStatus, {from: account, gas:50000});
    }).then(function(result) {
      console.log(result.receipt);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err) {
      console.log(err.message);
      res.send(false);
    });
  });
});

app.post('/GetTemplateReportArraySize', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance){
      return instance.GetTemplateReportArraySize.call();
    }).then(function(result){
      console.log("GetTemplateReportArraySize ", result);
      res.send(result);
    }).catch(function(err){
      console.log(err.message);
    })
  })
})

app.post('/GetTemplateReportFromNum', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance){
      return instance.GetTemplateReportFromNum.call(req.body.tempRep);
    }).then(function(result){
      console.log("GetTemplateReportFromNum ", result);
      res.send(result);
    }).catch(function(err){
      console.log(err.message);
    })
  })
})

app.post('/CreateReport', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance){
      return instance.CreateReport(req.body.tempRepNum, req.body.empNum, {from:account, gas:1000000});
    }).then(function(result){
      console.log("GetTemplateReportFromNum ", result);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err){
      console.log(err.message);
      res.send(false);
    })
  })
})

app.post('/CreateTemplateReport', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    console.log("depArray ", req.body.depArray)
    ReportContract.deployed().then(function(instance){
      return instance.CreateTemplateReport(req.body.title, req.body.depArray, {from:account, gas:500000});
    }).then(function(result){
      console.log("CreateTemplateReport ", result.receipt.status);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err){
      console.log(err.message);
      res.send(false);
    })
  })
})

app.post('/GetReportForDepartment', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    //var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance){
      return instance.GetReportForDepartment.call(req.body.depNum);
    }).then(function(result){
      console.log("GetReportForDepartment ", result);
      res.send(result);
    }).catch(function(err){
      console.log(err.message);
      res.send(false);
    })
  })
})

app.post('/UpdateStatusReportSuccess', function(req, res){
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    var account = accounts[0];
    var account = use_account;
    ReportContract.deployed().then(function(instance){
      return instance.UpdateStatusReportSuccess(req.body.repNum, req.body.depNum, req.body.empNum, {from: account, gas:100000});
    }).then(function(result){
      console.log("UpdateStatusReportSuccess ", result.receipt.status);
      if(result.receipt.status ==1){
        res.send(true);
      }
    }).catch(function(err){
      console.log(err.message);
      res.send(false);
    })
  })
})

app.post('/GetReportFieldNameList', function(req, res){
  var reportFieldSize;
  var reportFieldList = new Array;
  web3.eth.getAccounts(function(error, accounts){
    if (error) {
      console.log(error);
    }
    var account = accounts[0];
    ReportContract.deployed().then(function(instance){
      return instance.GetReportFieldSize.call(req.body.templateRepNum);
    }).then(function(result){
      console.log("GetReportFieldSize ", result);
      reportFieldSize = result;
    }).catch(function(err){
      console.log(err.message);
      res.send(false);
    })
    for(var i = 0; i < reportFieldSize; i++){
      ReportContract.deployed().then(function(instance){
        return instance.GetReportFieldNameFromFieldNum.call(req.body.templateRepNum, i);
      }).then(function(result){
        console.log("GetReportFieldNameFromFieldNum ", result);
        reportFieldList.push(result);
      }).catch(function(err){
        console.log(err.message);
        res.send(false);
      })
    }
  })
})