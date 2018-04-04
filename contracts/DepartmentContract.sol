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
        departmentArray.push(DepartmentStruct(0, "Отдел Режима", true));
        departmentArray.push(DepartmentStruct(1, "Информационно-библиотченый отдел", true));
        departmentArray.push(DepartmentStruct(2, "Финансовый отдел", true));
        departmentArray.push(DepartmentStruct(3, "Отдел материально-технического обеспечения", true));
        departmentArray.push(DepartmentStruct(4, "Кафедра 732 ИКСИ", true));
        uint departmentID = 5;
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

    function GetDepartmentArraySize() returns(uint[]){
        uint[] res;
        for (uint i = 0; i < departmentArray.length; i++){
            res.push(1);
        }
        return(res);
    }

    function GetDepartmentFromDepartmentNum(uint _num) returns(
        uint num,
        string title,
        bool status){
            return (
                departmentArray[_num].departmentId,
                departmentArray[_num].departmentTitle,
                departmentArray[_num].departmentStatus);
    }

    function UpdateStatusDepartment(uint _num, bool _newStatus) returns (bool updateStatus) {
        departmentArray[_num].departmentStatus = _newStatus;
        return true;
    }
}