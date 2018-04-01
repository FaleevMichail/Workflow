var AdminContract = artifacts.require("./AdminContract.sol");
var PostContract = artifacts.require("./PostContract.sol");
var DepartmentContract = artifacts.require("./DepartmentContract.sol");
var EmployerContract = artifacts.require("./EmployerContract.sol");

module.exports = function(deployer) {
  deployer.deploy(AdminContract);
  deployer.deploy(PostContract);
  deployer.deploy(DepartmentContract);
  deployer.deploy(EmployerContract);
};
