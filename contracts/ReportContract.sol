pragma solidity ^0.4.18;

//import "./EmployerContract.sol";

contract ReportContract /*is EmployerContract*/ {

    mapping (uint => uint[]) employerNum_reportArrayNum;
    
    mapping (uint => uint[]) templateReportNum_departmentNum;
    mapping (uint => uint[]) templateReportNum_postNum; // каким званиям разрешено подтверждать
    mapping (uint => uint[]) reportNum_employersNum;
    mapping (uint => IsVerification[]) reportNum_isVer;
    mapping (uint => string[]) reportNum_reasonForDeny;
    
    enum IsVerification{
        ACCEPT,
        DENY,
        PROCESSING
    }

    struct TemplateReportStruct{
        uint templateReportNum;
        string reportTitle;
    }

    struct EmployersReportStruct{
        uint reportNum;
        uint employerNum;
        uint templateReportNum;
        bool isApprove;
        uint time;
    }

    EmployersReportStruct[] public employerReportArray;
    TemplateReportStruct[] public templateReportArray;

    uint public templateReportNumber;
    uint public reportNuber;

    function ReportContract() public{
        AutoCreaterTemplateReport();
        AutoCreaterEmployerReport();
    }
    
    function AutoCreaterTemplateReport() {

        templateReportArray.push(TemplateReportStruct(0, "Рапорт на oтпуск"));
        templateReportArray.push(TemplateReportStruct(1, "Рапорт на технику"));
        templateReportArray.push(TemplateReportStruct(2, "Рапорт на парковку"));
        templateReportArray.push(TemplateReportStruct(3, "Рапорт на лечение"));
        
        templateReportNum_departmentNum[0] = [1,2,3];
        templateReportNum_departmentNum[0].push(4);
        templateReportNum_postNum[0] = [0,1];
        
        templateReportNum_departmentNum[1] = [0,3,4];
        templateReportNum_postNum[1] = [0,1];
        
        templateReportNum_departmentNum[2] = [0];
        templateReportNum_postNum[2] = [0,1];
        
        templateReportNum_departmentNum[3] = [4,5];
        templateReportNum_postNum[3] = [0,1];
        
        templateReportNumber = 4;
    }
    
    function AutoCreaterEmployerReport(){
        
        employerReportArray.push(EmployersReportStruct(0, 0, 0 ,false,now));
        reportNum_employersNum[0] = [0,0,0,0];
        reportNum_isVer[0] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[0] = ["None", "None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(1, 1, 0 ,false,now));
        reportNum_employersNum[1] = [0,0,0,0];
        reportNum_isVer[1] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[1] = ["None", "None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(2, 2, 0 ,false,now));
        reportNum_employersNum[2] = [0,0,0,0];
        reportNum_isVer[2] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[2] = ["None", "None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(3, 3, 0 ,false,now));
        reportNum_employersNum[3] = [0,0,0,0];
        reportNum_isVer[3] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[3] = ["None", "None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(4, 0, 1 ,false,now));
        reportNum_employersNum[4] = [0,0,0];
        reportNum_isVer[4] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[5] = ["None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(5, 1, 1 ,false,now));
        reportNum_employersNum[5] = [0,0,0];
        reportNum_isVer[5] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[5] = ["None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(6, 0, 2 ,false,now));
        reportNum_employersNum[6] = [0];
        reportNum_isVer[6] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[6] = ["None"];
        
        employerReportArray.push(EmployersReportStruct(7, 2, 2 ,false,now));
        reportNum_employersNum[7] = [0];
        reportNum_isVer[7] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[7] = ["None"];
        
        employerReportArray.push(EmployersReportStruct(8, 3, 2 ,false,now));
        reportNum_employersNum[8] = [0];
        reportNum_isVer[8] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[8] = ["None"];
        
        employerReportArray.push(EmployersReportStruct(9, 0, 3 ,false,now));
        reportNum_employersNum[9] = [0,0];
        reportNum_isVer[9] = [IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[9] = ["None", "None"];
        
        employerReportArray.push(EmployersReportStruct(10, 3, 3 ,false,now));
        reportNum_employersNum[10] = [0,0];
        reportNum_isVer[10] = [IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[10] = ["None", "None"];
        
        employerNum_reportArrayNum[0].push(0);
        employerNum_reportArrayNum[0].push(4);
        employerNum_reportArrayNum[0].push(6);
        employerNum_reportArrayNum[0].push(9);
        employerNum_reportArrayNum[1].push(1);
        employerNum_reportArrayNum[1].push(5);
        employerNum_reportArrayNum[2].push(2);
        employerNum_reportArrayNum[2].push(7);
        employerNum_reportArrayNum[3].push(3);
        employerNum_reportArrayNum[3].push(8);
        employerNum_reportArrayNum[3].push(10);

        reportNuber = 11;
    }

    function CreateReport(
        uint _templateReport,
        uint _employerNum
    ) returns (bool createReport){
        EmployersReportStruct memory newReport = EmployersReportStruct({
            reportNum:reportNuber,
            employerNum:_employerNum,
            templateReportNum:_templateReport,
            isApprove:false,
            time:now
        });
        employerReportArray.push(newReport);
        for(uint i = 0; i < templateReportNum_departmentNum[_templateReport].length; i++){
            reportNum_employersNum[reportNuber].push(0);
            reportNum_isVer[reportNuber].push(IsVerification.PROCESSING);
            reportNum_reasonForDeny[reportNuber].push("None");
        }
        employerNum_reportArrayNum[_employerNum].push(reportNuber);
        reportNuber = reportNuber + 1;
        return true;
    }

    function CreateTemplateReport(
        string _title,
        uint[] _departments
        //uint[] _departmentNum
    ) returns (bool createTemplateReport){
        TemplateReportStruct memory newTemplateReport = TemplateReportStruct({
            templateReportNum:templateReportNumber,
            reportTitle:_title
        });
        templateReportArray.push(newTemplateReport);
        
        for (uint i = 0; i < _departments.length; i++){
            templateReportNum_departmentNum[templateReportNumber].push(_departments[i]);
        }
        templateReportNum_postNum[templateReportNumber] = [1,2];
        templateReportNumber = templateReportNumber + 1;
        return true;
    }

    /*function ReceptionDepartment(
        uint _departmentNum, 
        uint _num
    ) returns (bool){
        templateReportNum_departmentNum[templateReportNumber].push(_departmentNum);
        if (_num == templateReportNum_departmentNum[templateReportNumber].length){
            templateReportNumber = templateReportNumber + 1;
        }
        return true;
    }*/
    

    function GetEmployersReportListFromNum(uint _employerNum) returns(uint[] reportsArray){
        return employerNum_reportArrayNum[_employerNum];
    }
    
    function GetEmployersAcceptReport() returns(uint[]){
        uint[] acceptReport;
        for(uint i = 0; i<employerReportArray.length; i++){
            if(employerReportArray[i].isApprove == true){
                acceptReport[i];
            }
        }
        return acceptReport;
    }
    
    function GetEmployersNotAcceptReport() returns(uint[]){
        uint[] notAcceptReport;
        for(uint i = 0; i<employerReportArray.length; i++){
            if(employerReportArray[i].isApprove == false){
                notAcceptReport[i];
            }
        }
        return notAcceptReport;
    }

    function GetEmployerReportSize() returns(uint[]){
        uint[] arr;
        for (uint i = 0; i < employerReportArray.length; i++){
            arr.push(1);
        }
        return arr;
    }
    
    function GetEmployersReportFromNum(uint _num) returns(
        uint employerNum,
        string title,
        bool isApprove,
        uint[] depNum,
        uint[] empNum,
        uint[] ,
        uint reportTime
        ){
            
            uint templateReport = employerReportArray[_num].templateReportNum;
            depNum = templateReportNum_departmentNum[templateReport];
            empNum = reportNum_employersNum[_num];
            reportTime = employerReportArray[_num].time;
            
            uint[] isVer;
            
            for (uint i=0; i<depNum.length; i++){
                if(reportNum_isVer[_num][i] == IsVerification.ACCEPT){
                    isVer.push(1);
                }else{
                    if(reportNum_isVer[_num][i] == IsVerification.DENY){
                        isVer.push(0);
                    }else{
                        isVer.push(2);
                    }
                }
            }
            
            return(
                employerNum = employerReportArray[_num].employerNum,
                templateReportArray[employerReportArray[_num].templateReportNum].reportTitle,
                employerReportArray[_num].isApprove,
                depNum,
                empNum,
                isVer,
                reportTime
            );
    }
    
    /*function GetMessageFromDepartmentNumReportNum(
    uint _reportNum, 
    uint _departmentNum) returns (string reason){
        return(employerReportArray[_reportNum].departmentNum_resonForDeny[_departmentNum]);
    } */

    function GetTemplateReportArraySize() returns(
        uint[]
        ){
            uint[] arr;
            arr.push(templateReportArray.length);
            return arr;
    }

    function GetTemplateReportFromNum(uint _num) returns (
        string reportTitle,
        uint[],
        uint[],
        uint){
            return(
                templateReportArray[_num].reportTitle,
                templateReportNum_departmentNum[_num],
                templateReportNum_postNum[_num],
                templateReportArray[_num].templateReportNum);
    }

    function UpdateStatusReprot(uint _num, bool newStatus) returns (
        bool){
            employerReportArray[_num].isApprove = newStatus;
            return true;
    }
    
    //Проверка данных подверждающего человека
    /*/function ApprovedReport(uint _reportNum) returns(
        uint mistakeNum){

            uint templateReport = employerReportArray[_reportNum].templateReportNum;
            
            var (employerDepartmentID, employerPostID) = GetEmployerWorkplaceFromAddr(msg.sender);
            bool depFlag = false;
            bool postFlag = false;
            for (uint i = 0; i < templateReportNum_departmentNum[templateReport].length; i++){
                if(employerDepartmentID == templateReportNum_departmentNum[templateReport][i]){
                    depFlag = true;
                }else{
                    return 1;
                }
            }
            for (i = 0; i < templateReportNum_postNum[templateReport].length; i++){
                if (employerPostID == templateReportNum_postNum[templateReport][i]){
                    postFlag = true;
                }else{
                    return 1;
                }
            }

            if(depFlag && postFlag){
                reportNum_isVer[_reportNum][employerDepartmentID] = IsVerification.ACCEPT;
                mistakeNum = 0;
            }else{
                mistakeNum = 2;
            }
            return mistakeNum;
        }*/
    }