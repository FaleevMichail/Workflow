//Контракт, содержащий данные об администраторе

pragma solidity ^0.4.18;

contract AdminContract {
    address Admin;
    bool adminFlag = false;

    function AdminContract() public {

    }

    function SetAdmin() returns (bool flag){
        Admin = msg.sender;
        adminFlag = true;
        return true;
    }

    modifier onlyAdmin {
        if(msg.sender != Admin) throw;
        _;
    }

    function GetAdmin() onlyAdmin returns(address admin)
    {
        return(Admin);
    }

    function GetAdminFlag() returns(bool){
        return(adminFlag);
    }

    function AssertAdmin() returns (bool){
        if (Admin == msg.sender){
            return true;
        }else{
            return false;
        }
    }
}