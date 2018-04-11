pragma solidity ^0.4.18;

contract ReportContract {

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
        
        employerReportArray.push(EmployersReportStruct(0, 0, 0 ,false));
        reportNum_employersNum[0] = [0,0,0,0];
        reportNum_isVer[0] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[0] = ["None", "None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(1, 1, 0 ,false));
        reportNum_employersNum[1] = [0,0,0,0];
        reportNum_isVer[1] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[1] = ["None", "None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(2, 2, 0 ,false));
        reportNum_employersNum[2] = [0,0,0,0];
        reportNum_isVer[2] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[2] = ["None", "None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(3, 3, 0 ,false));
        reportNum_employersNum[3] = [0,0,0,0];
        reportNum_isVer[3] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[3] = ["None", "None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(4, 0, 1 ,false));
        reportNum_employersNum[4] = [0,0,0];
        reportNum_isVer[4] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[5] = ["None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(5, 1, 1 ,false));
        reportNum_employersNum[5] = [0,0,0];
        reportNum_isVer[5] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[5] = ["None", "None", "None"];
        
        employerReportArray.push(EmployersReportStruct(6, 0, 2 ,false));
        reportNum_employersNum[6] = [0];
        reportNum_isVer[6] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[6] = ["None"];
        
        employerReportArray.push(EmployersReportStruct(7, 2, 2 ,false));
        reportNum_employersNum[7] = [0];
        reportNum_isVer[7] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[7] = ["None"];
        
        employerReportArray.push(EmployersReportStruct(8, 3, 2 ,false));
        reportNum_employersNum[8] = [0];
        reportNum_isVer[8] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[8] = ["None"];
        
        employerReportArray.push(EmployersReportStruct(9, 0, 3 ,false));
        reportNum_employersNum[9] = [0,0];
        reportNum_isVer[9] = [IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[9] = ["None", "None"];
        
        employerReportArray.push(EmployersReportStruct(10, 3, 3 ,false));
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
        string _title
    ) returns (bool createReport){
        
        templateReportArray.push(TemplateReportStruct(
            templateReportNumber,
            _title
        ));
        
        templateReportNumber = templateReportNumber + 1;
        return true;
    }

    function GetEmployersReport(uint _employerNum) returns(uint[] reportsArray){
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
        uint[] 
        ){
            
            uint templateReport = employerReportArray[_num].templateReportNum;
            depNum = templateReportNum_departmentNum[templateReport];
            empNum = reportNum_employersNum[_num];
            
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
                isVer
            );
    }
    
    /*function GetMessageFromDepartmentNumReportNum(
    uint _reportNum, 
    uint _departmentNum) returns (string reason){
        return(employerReportArray[_reportNum].departmentNum_resonForDeny[_departmentNum]);
    } */

    function GetTemplateReportFromNum(uint _num) returns (
        string reportTitle,
        uint[],
        uint[]){
            return(
                templateReportArray[_num].reportTitle,
                templateReportNum_departmentNum[_num],
                templateReportNum_postNum[_num]);
    }

    function UpdateStatusReprot(uint _num, bool newStatus) returns (
        bool){
            employerReportArray[_num].isApprove = newStatus;
            return true;
    }
    
}