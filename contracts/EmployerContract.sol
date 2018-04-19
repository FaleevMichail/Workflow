// Контракт, содержащий данные о сотрудниках и функции для взаимодействия с ними

pragma solidity ^0.4.18;

contract EmployerContract{

    mapping (address => uint) employerAddr_employerNum;
    //mapping (uint => string) number_rank;

    struct EmployerStruct{
        uint employerNum;
        string employerName;
        string employerFamily;
        string employerPatronymic;
        uint employerPostID;
        uint employerDepartmentID;
        string employerRank;
        uint employerRankNum;
        bool employerStatus;
        bool isConfirm;
    }

    EmployerStruct[] employerArray;
    string[] rankArray;
    uint employerNumber;

    function EmployerContract() public {
        RankCreater();
        employerArray.push(EmployerStruct(0, "Defoult", "Default", "Default", 0, 0, "Default", 0 , false, false));
        employerArray.push(EmployerStruct(1, "Иван", "Липугин", "Александрович", 1, 1, "Рядовой", 1 , true, false));
        employerArray.push(EmployerStruct(2, "Михаил", "Фолев", "Петрович", 2, 2, "Ефрейтор", 2 , true, true));
        employerArray.push(EmployerStruct(3, "Андрей", "Девятов", "Викторович", 3, 3, "Младший сержант", 3, true, true));
        employerArray.push(EmployerStruct(4, "Алексей", "Лексусов", "Тринеевич", 4, 4, "Младший сержант", 3, true, true));
        employerNumber = 5;
        employerAddr_employerNum[msg.sender] = 2;
    }

    function RankCreater() returns(bool) {
        rankArray.push("Без звания");
        rankArray.push("Рядовой");
        rankArray.push("Ефрейтор");
        rankArray.push("Младший Сержант");
        rankArray.push("Сержант");
        rankArray.push("Старший Сержант");
        rankArray.push("Прапорщик");
        rankArray.push("Страший прапорщий");
        rankArray.push("Младший лейтенант");
        rankArray.push("Лейтенант");
        rankArray.push("Старший Лейтенант");
        rankArray.push("Капитан");
        rankArray.push("Майор");
        rankArray.push("Подполковник");
        rankArray.push("Полковник");
        rankArray.push("Генерал-Майор");
        rankArray.push("Генерал-лейтенант");
        rankArray.push("Генерал-полковник");
        return true;
    }

    function GetRankFromNum(uint rankNum) returns(uint num, string rank){
        return(rankNum, rankArray[rankNum]);
    }

    function GetRanks() returns(uint[]){
        uint[] ranks;
        for (uint i = 0; i < rankArray.length; i++){
            ranks.push(1);
        }
        return(ranks);
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
                employerRankNum: 0,
                employerStatus: true,
                isConfirm: false
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

    function UpdateEmployerFromNum(
        uint num,
        string _newRank
    ) returns (bool updateEmployer){
        employerArray[num].employerRank = _newRank;
        return true;
    }

    function UpdateEmployerWorkplaceFromNum(
        uint num,
        uint newPost,
        uint newDepartment,
        uint newFlagIsConfirm
        ) returns(bool updateEmployerWorkplace){
            employerArray[num].employerPostID = newPost;
            employerArray[num].employerDepartmentID = newDepartment;
            if(newFlagIsConfirm == 1){
                employerArray[num].isConfirm = true;
            }else{
                employerArray[num].isConfirm = false;
            }
            
            return true;
        }

    function UpdateStatusEmployer(uint _employerNum, bool _newStatus) returns (bool updateStatus) {
        employerArray[_employerNum].employerStatus = _newStatus;
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
        uint num,
        string name,
        string family, 
        string patronymic,
        string rank,
        bool status,
        uint employerRankNum){
            return (
                employerArray[_employerNum].employerNum,
                employerArray[_employerNum].employerName,
                employerArray[_employerNum].employerFamily,
                employerArray[_employerNum].employerPatronymic,
                employerArray[_employerNum].employerRank,
                employerArray[_employerNum].employerStatus,
                employerArray[_employerNum].employerRankNum);
        }

    function GetEmployerWorkplaceFromNum(uint _employerNum) returns(
        uint postId,
        uint departmentId,
        bool isConfirm){
            return(
                employerArray[_employerNum].employerPostID,
                employerArray[_employerNum].employerDepartmentID,
                employerArray[_employerNum].isConfirm
            );
    }

    function GetEmployerFromEmployerAddr() returns(
        uint num,
        string name,
        string family, 
        string patronymic,
        string rank,
        bool status,
        uint employerRankNum){
            return(
                employerArray[employerAddr_employerNum[msg.sender]].employerNum,
                employerArray[employerAddr_employerNum[msg.sender]].employerName,
                employerArray[employerAddr_employerNum[msg.sender]].employerFamily,
                employerArray[employerAddr_employerNum[msg.sender]].employerPatronymic,
                employerArray[employerAddr_employerNum[msg.sender]].employerRank,
                employerArray[employerAddr_employerNum[msg.sender]].employerStatus,
                employerArray[employerAddr_employerNum[msg.sender]].employerRankNum);
        }

    function GetEmployerWorkplaceFromAddr() returns(
        uint postId,
        uint departmentId,
        bool isConfirm){
            return(
                employerArray[employerAddr_employerNum[msg.sender]].employerPostID,
                employerArray[employerAddr_employerNum[msg.sender]].employerDepartmentID,
                employerArray[employerAddr_employerNum[msg.sender]].isConfirm
            );
    }

    /*function GetEmployerNumFromEmployerAddr() returns(uint[]){
        uint[] num;
        num.push(employerAddr_employerNum[msg.sender]);
        return(num);
    }*/

    function GetEmployerNumFromEmployerAddr() returns(uint){
        return(employerAddr_employerNum[msg.sender]);
    }

    function GetEmployersFromDepartmentId (uint depId) returns (uint[]){
        uint[] result;
        for (uint i =0; i < employerArray.length; i++){
            if(employerArray[i].employerDepartmentID == depId){
                result.push(1);
            }else{
                result.push(0);
            }
        }
        return(result);
    }

    function GetEmployersFromPostId (uint postId) returns (uint[]){
        uint[] result;
        for (uint i =0; i < employerArray.length; i++){
            if(employerArray[i].employerPostID == postId){
                result.push(1);
            }else{
                result.push(0);
            }
        }
        return(result);
    }
}
