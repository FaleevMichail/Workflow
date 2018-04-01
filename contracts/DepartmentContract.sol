//Контракт, содержащий данные о должности сотрудников и функции для добавления и удаления должностей

pragma solidity ^0.4.18;

import "./AdminContract.sol";

contract DepartmentContract is AdminContract{

    mapping (uint => bool) departmentNum_isDepartmentActive;

    struct DepartmentStruct{
        uint departmentId;
        string departmentTitle;
        bool departmentStatus;
    }

    DepartmentStruct[] departmentArray;
    uint[] departmentNumArray;
    uint departmentID;

    function DepartmentContract() public{

    }

    function CreateDepartment(string _title) returns (bool){
        DepartmentStruct memory newDepartment = DepartmentStruct({departmentId:departmentID, departmentTitle:_title, departmentStatus: true});
        departmentArray.push(newDepartment);
        departmentNumArray.push(departmentID);
        departmentNum_isDepartmentActive[departmentID] = true;
        departmentID = departmentID + 1;
        return true;
    }

    function UpdateDepartment(uint _departmentId, string _newTitle) returns (bool){
        departmentArray[_departmentId].departmentTitle = _newTitle;
        return true;
    }

    function GetDepartmentNum() returns (uint[] departmentNumArray){
        return (departmentNumArray);
    }

    function GetActiveDepartmentNum() returns (uint[] departmentNumArray){
        uint[] activeDepartmentNumArray;
        for(uint i = 0; i < departmentArray.length; i++){
            if(departmentArray[i].departmentStatus == true){
                activeDepartmentNumArray.push(i);
            }
        }
        return (activeDepartmentNumArray);
    }

    function ViewDepartmentDetails(uint _departmentId) returns (string ret_title, bool ret_status){
        ret_title = departmentArray[_departmentId].departmentTitle;
        ret_status = departmentArray[_departmentId].departmentStatus;
        return (ret_title, ret_status);
    }
}