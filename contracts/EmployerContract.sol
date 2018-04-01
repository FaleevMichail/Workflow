// Контракт, содержащий данные о сотрудниках и функции для взаимодействия с ними

pragma solidity ^0.4.18;

//import "./PostContract.sol";
//import "./DepartmentContract.sol";
//import "./AdminContract.sol";

contract EmployerContract{

    mapping (address => uint) employerAddr_employerNum;
    mapping (uint => uint[]) postNum_employerNum;
    mapping (uint => uint[]) departmentNum_employerNum;

    struct EmployerStruct{
        uint employerNum;
        string employerName;
        string employerFamily;
        string employerPatronymic;
        uint employerPostID;
        uint employerDepartmentID;
        string employerRank;
        bool employerStatus;
    }

    EmployerStruct[] employerArray;
    uint employerNumber;

    function EmployerContract() public {
    }

    function CreateEmployer(
        string _name,
        string _family, 
        string _patronymic,
        //uint _postId,
        //uint _departmentId, 
        string _rank) returns (bool createEmployer){
            EmployerStruct memory newEmployer = EmployerStruct({
                employerNum: employerNumber,
                employerName:_name,
                employerFamily:_family,
                employerPatronymic:_patronymic,
                employerPostID: 0,
                employerDepartmentID: 0,
                employerRank: _rank,
                employerStatus: true
            });
            employerAddr_employerNum[msg.sender] = employerNumber;
            employerArray.push(newEmployer);
            employerNumber = employerNumber + 1;
            return true;
        }
        
    function UpdateEmployer( 
        string _newRank
    ) returns (bool updateEmployer) {
        employerArray[employerAddr_employerNum[msg.sender]].employerRank = _newRank;
        return true;
    }

    function UbdateStatusEmployer(uint _employerNum, bool _newStatus) returns (bool updateStatus) {
        employerArray[_employerNum].employerStatus = _newStatus;
        return true;
    }
    
    function ApplyPost(uint _postId) returns (bool apply){
        for(uint i = 0; i < postNum_employerNum[_postId].length; i++){
            if(postNum_employerNum[_postId][i] == employerAddr_employerNum[msg.sender]){
                return false;
            }
        }
        postNum_employerNum[_postId].push(employerAddr_employerNum[msg.sender]);
        employerArray[employerAddr_employerNum[msg.sender]].employerPostID = _postId;
        return true;
    }

    function ApplyDepartment(uint _departmentId) returns (bool apply){
        for(uint i = 0; i < departmentNum_employerNum[_departmentId].length; i++){
            if(departmentNum_employerNum[_departmentId][i] == employerAddr_employerNum[msg.sender]){
                return false;
            }
        }
        departmentNum_employerNum[_departmentId].push(employerAddr_employerNum[msg.sender]);
        employerArray[employerAddr_employerNum[msg.sender]].employerDepartmentID = _departmentId;
        return true;
    }

    function UpdatePostEmployer(uint _newPostId) returns (bool update){
        uint reqPost = employerArray[employerAddr_employerNum[msg.sender]].employerPostID;
        delete postNum_employerNum[reqPost][employerAddr_employerNum[msg.sender]];
        postNum_employerNum[_newPostId].push(employerAddr_employerNum[msg.sender]);
        employerArray[employerAddr_employerNum[msg.sender]].employerPostID = _newPostId;
        return true;
    }

    function UpdateDepartmentEmployer(uint _newDepartmentId) returns (bool update){
        uint reqDepartment = employerArray[employerAddr_employerNum[msg.sender]].employerDepartmentID;
        delete departmentNum_employerNum[reqDepartment][employerAddr_employerNum[msg.sender]];
        departmentNum_employerNum[_newDepartmentId].push(employerAddr_employerNum[msg.sender]);
        employerArray[employerAddr_employerNum[msg.sender]].employerDepartmentID = _newDepartmentId;
        return true;
    }

    function GetEmployerArraySize() returns(uint[]){
        uint[] res;
        for (uint i = 0; i < employerArray.length; i++){
            res.push(1);
        }
        return(res);
    }

    function GetEmployerFromEmployerNum(uint _employerNum) returns(
        string name,
        string family, 
        string patronymic,
        uint postId,
        uint departmentId, 
        string rank,
        bool status){
            return (
                employerArray[_employerNum].employerName,
                employerArray[_employerNum].employerFamily,
                employerArray[_employerNum].employerPatronymic,
                employerArray[_employerNum].employerPostID,
                employerArray[_employerNum].employerDepartmentID,
                employerArray[_employerNum].employerRank,
                employerArray[_employerNum].employerStatus);
        }

    function GetEmployerFromEmployerAddr() returns(
        string name,
        string family, 
        string patronymic,
        uint postId,
        uint departmentId, 
        string rank,
        bool status){
            return (
                employerArray[employerAddr_employerNum[msg.sender]].employerName,
                employerArray[employerAddr_employerNum[msg.sender]].employerFamily,
                employerArray[employerAddr_employerNum[msg.sender]].employerPatronymic,
                employerArray[employerAddr_employerNum[msg.sender]].employerPostID,
                employerArray[employerAddr_employerNum[msg.sender]].employerDepartmentID,
                employerArray[employerAddr_employerNum[msg.sender]].employerRank,
                employerArray[employerAddr_employerNum[msg.sender]].employerStatus);
        }

    function GetEmployerNumFromEmployerAddr() returns(uint num){
        num = employerAddr_employerNum[msg.sender];
        return(num);
        }
}
