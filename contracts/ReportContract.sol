pragma solidity ^0.4.18;

//import "./EmployerContract.sol";

contract ReportContract /*is EmployerContract*/ {

    mapping (uint => uint[]) employerNum_reportArrayNum;
    
    mapping (uint => uint[]) templateReportNum_departmentNum;
    mapping (uint => uint[]) templateReportNum_postNum; // каким званиям разрешено подтверждать
    mapping (uint => string[]) templateReportNum_fieldName;
    mapping (uint => uint[]) reportNum_employersNum;
    mapping (uint => IsVerification[]) reportNum_isVer;
    mapping (uint => string[]) reportNum_reasonForDeny;
    mapping (uint => string[]) reportNum_fieldData;
    mapping (uint => uint[]) departmentNum_employerReport;
    mapping (uint => uint[]) reportNum_reportFieldNum;
    
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
    uint fieldNumber;

    function ReportContract() public{
        AutoCreaterTemplateReport();
        AutoCreaterEmployerReport();
        AutoCreaterFieldForReport();
    }
    
    function AutoCreaterTemplateReport() {

        templateReportArray.push(TemplateReportStruct(0, "Рапорт на oтпуск"));
        templateReportArray.push(TemplateReportStruct(1, "Рапорт на технику"));
        templateReportArray.push(TemplateReportStruct(2, "Рапорт на парковку"));
        templateReportArray.push(TemplateReportStruct(3, "Рапорт на лечение"));
        
        templateReportNum_departmentNum[0] = [1,2,3,4];
        templateReportNum_postNum[0] = [1,2];
        templateReportNum_fieldName[0] = ["Место проведения отпуска", "Вид транспорта", "Лица, которые следуют со мной", "Дата начала отпуска", "Дата окончания отпуска"];
        
        templateReportNum_departmentNum[1] = [1,4,5];
        templateReportNum_postNum[1] = [1,2];
        templateReportNum_fieldName[1] = ["Тип устройтсва", "Сирийный номер", "Потребляемая мощность"];
        
        templateReportNum_departmentNum[2] = [1];
        templateReportNum_postNum[2] = [1,2];
        templateReportNum_fieldName[2] = ["Марка автомобиля", "Сирийный номер"];
        
        templateReportNum_departmentNum[3] = [5,6];
        templateReportNum_postNum[3] = [1,2];
        templateReportNum_fieldName[3] = ["Тип заболевания", "Дата начала лечения"];
        
        templateReportNumber = 4;
    }
    
    function AutoCreaterEmployerReport(){
        
        employerReportArray.push(EmployersReportStruct(0, 1, 0 ,false,now));
        reportNum_employersNum[0] = [0,0,0,0];
        reportNum_isVer[0] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[0] = ["None", "None", "None", "None"];
        for (uint i = 0; i < templateReportNum_departmentNum[0].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[0][i]].push(0);
        }
        reportNum_fieldData[0] = ["Республика Чувашия, г.Алатырь", "Поезд", "Один", "1.08.2018", "31.08.2018"];
        
        employerReportArray.push(EmployersReportStruct(1, 2, 0 ,false,now));
        reportNum_employersNum[1] = [0,0,0,0];
        reportNum_isVer[1] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[1] = ["None", "None", "None", "None"];
        for ( i = 0; i < templateReportNum_departmentNum[0].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[0][i]].push(1);
        }
        reportNum_fieldData[1] = ["Кировская область, г.Киров", "Поезд", "Один", "1.08.2018", "31.08.2018"];
        
        employerReportArray.push(EmployersReportStruct(2, 3, 0 ,false,now));
        reportNum_employersNum[2] = [0,0,0,0];
        reportNum_isVer[2] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[2] = ["None", "None", "None", "None"];
        for ( i = 0; i < templateReportNum_departmentNum[0].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[0][i]].push(2);
        }
        reportNum_fieldData[2] = ["Пензенская область, г.Кузнецк", "Поезд", "Один", "1.08.2018", "31.08.2018"];
        
        employerReportArray.push(EmployersReportStruct(3, 4, 0 ,false,now));
        reportNum_employersNum[3] = [0,0,0,0];
        reportNum_isVer[3] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[3] = ["None", "None", "None", "None"];
        for ( i = 0; i < templateReportNum_departmentNum[0].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[0][i]].push(3);
        }
        reportNum_fieldData[3] = ["Ленинградская область, г.Санкт-Петербург", "Поезд", "Один", "1.08.2018", "31.08.2018"];
        
        employerReportArray.push(EmployersReportStruct(4, 1, 1 ,false,now));
        reportNum_employersNum[4] = [0,0,0];
        reportNum_isVer[4] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[5] = ["None", "None", "None"];
        for ( i = 0; i < templateReportNum_departmentNum[1].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[1][i]].push(4);
        }
        reportNum_fieldData[4] = ["Чайник", "12309487123847", "1 кВт"];
        
        employerReportArray.push(EmployersReportStruct(5, 2, 1 ,false,now));
        reportNum_employersNum[5] = [0,0,0];
        reportNum_isVer[5] = [IsVerification.PROCESSING, IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[5] = ["None", "None", "None"];
        for ( i = 0; i < templateReportNum_departmentNum[1].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[1][i]].push(5);
        }
        reportNum_fieldData[5] = ["Лампа", "234523452345", "60 Вт"];
        
        employerReportArray.push(EmployersReportStruct(6, 1, 2 ,false,now));
        reportNum_employersNum[6] = [0];
        reportNum_isVer[6] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[6] = ["None"];
        for ( i = 0; i < templateReportNum_departmentNum[2].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[2][i]].push(6);
        }
        reportNum_fieldData[6] = ["Лада Веста", "ф420сб"];
        
        employerReportArray.push(EmployersReportStruct(7, 3, 2 ,false,now));
        reportNum_employersNum[7] = [0];
        reportNum_isVer[7] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[7] = ["None"];
        for ( i = 0; i < templateReportNum_departmentNum[2].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[2][i]].push(7);
        }
        reportNum_fieldData[7] = ["Лада Гранта", "ф120сб"];
        
        employerReportArray.push(EmployersReportStruct(8, 4, 2 ,false,now));
        reportNum_employersNum[8] = [0];
        reportNum_isVer[8] = [IsVerification.PROCESSING];
        reportNum_reasonForDeny[8] = ["None"];
        for ( i = 0; i < templateReportNum_departmentNum[2].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[2][i]].push(8);
        }
        reportNum_fieldData[8] = ["Лада Приора", "ф001сб"];
        
        employerReportArray.push(EmployersReportStruct(9, 1, 3 ,false,now));
        reportNum_employersNum[9] = [0,0];
        reportNum_isVer[9] = [IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[9] = ["None", "None"];
        for ( i = 0; i < templateReportNum_departmentNum[3].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[3][i]].push(9);
        }
        reportNum_fieldData[9] = ["Сотрясение мозга", "12.05.2018"];
        
        employerReportArray.push(EmployersReportStruct(10, 4, 3 ,false,now));
        reportNum_employersNum[10] = [0,0];
        reportNum_isVer[10] = [IsVerification.PROCESSING, IsVerification.PROCESSING];
        reportNum_reasonForDeny[10] = ["None", "None"];
        for ( i = 0; i < templateReportNum_departmentNum[3].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[3][i]].push(10);
        }
        reportNum_fieldData[10] = ["Горловой абсцес", "1.05.2018"];
        
        employerNum_reportArrayNum[1].push(0);
        employerNum_reportArrayNum[1].push(4);
        employerNum_reportArrayNum[1].push(6);
        employerNum_reportArrayNum[1].push(9);
        employerNum_reportArrayNum[2].push(1);
        employerNum_reportArrayNum[2].push(5);
        employerNum_reportArrayNum[3].push(2);
        employerNum_reportArrayNum[3].push(7);
        employerNum_reportArrayNum[4].push(3);
        employerNum_reportArrayNum[4].push(8);
        employerNum_reportArrayNum[4].push(10);

        reportNuber = 11;
    }

    function AutoCreaterFieldForReport(){
        
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
        for ( i = 0; i < templateReportNum_departmentNum[_templateReport].length; i++){
            departmentNum_employerReport[templateReportNum_departmentNum[_templateReport][i]].push(reportNuber);
        }

        reportNuber = reportNuber + 1;
        return true;
    }

    function GetReportFieldSize(uint _templateReportNum) returns(uint){
        
        return templateReportNum_fieldName[_templateReportNum].length;
    }

    function GetReportFieldNameFromFieldNum(uint _templateReportNum, uint _fieldNum
    )returns(string){
        return(templateReportNum_fieldName[_templateReportNum][_fieldNum]);
    }

    function SetReportFieldDataFromFieldNum(uint _reportNum, string _fieldData) returns(bool){
        reportNum_fieldData[_reportNum].push(_fieldData);
        return true;
    }

    function SetReportFieldData(
        uint _reportNum,
        string _fieldData
        )returns(bool){
            reportNum_fieldData[_reportNum].push(_fieldData);
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

    function GetReportForDepartment(uint dep) returns (uint[]){
        uint[] reports;
        for (uint i = 0 ; i < departmentNum_employerReport[dep].length; i++){
            uint repNum = departmentNum_employerReport[dep][i];
            for (uint j = 0; j < templateReportNum_departmentNum[employerReportArray[repNum].templateReportNum].length; j++){
                if(dep == templateReportNum_departmentNum[employerReportArray[repNum].templateReportNum][j]){
                    if(reportNum_isVer[repNum][j] == IsVerification.DENY || reportNum_isVer[repNum][j] == IsVerification.PROCESSING){
                        reports.push(repNum);
                    }
                }
            }

        }
        return(departmentNum_employerReport[dep]);
    }

    function UpdateStatusReportSuccess(uint _reportNum, uint depNum, uint _employerNum) returns(bool){
        for (uint i = 0; i < templateReportNum_departmentNum[employerReportArray[_reportNum].templateReportNum].length; i++){
            if(depNum == templateReportNum_departmentNum[employerReportArray[_reportNum].templateReportNum][i]){
                reportNum_isVer[_reportNum][i] = IsVerification.ACCEPT;
                reportNum_employersNum[_reportNum][i] = _employerNum;
            }
        }
        return true;
    }

    function UpdateStatusReportDeny(uint _reportNum, uint depNum, uint _employerNum) returns(bool){
        for (uint i = 0; i < templateReportNum_departmentNum[employerReportArray[_reportNum].templateReportNum].length; i++){
            if(depNum == templateReportNum_departmentNum[employerReportArray[_reportNum].templateReportNum][i]){
                reportNum_isVer[_reportNum][i] = IsVerification.DENY;
                reportNum_employersNum[_reportNum][i] = _employerNum;
            }
        }
        return true;
    }
}