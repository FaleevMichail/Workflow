var AdminContract = artifacts.require("./AdminContract.sol");
var PostContract = artifacts.require("./PostContract.sol");
var DepartmentContract = artifacts.require("./DepartmentContract.sol");
var EmployerContract = artifacts.require("./EmployerContract.sol");
var ReportContract = artifacts.require("./ReportContract.sol")

module.exports = function(deployer) {
  deployer.deploy(AdminContract);
  deployer.deploy(PostContract);
  deployer.deploy(DepartmentContract);
  deployer.deploy(EmployerContract);
  deployer.deploy(ReportContract, {gas:10000000});
};
