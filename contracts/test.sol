pragma solidity ^0.4.18;

contract test {
    mapping (uint => uint[]) reportNum_reportFieldNum;
    
    struct Field{
        uint reportNum;
        string name;
        string data;
    }

    Field[] public fieldList;
    
    uint fieldNumber = 0;
    
    function SetField(
        uint _reportNum, 
        string _fieldName, 
        string _fieldData) constant returns(
            uint,
            string,
            string){
        Field memory newField = Field({
            reportNum: _reportNum,
            name: _fieldName,
            data: _fieldData
        });
        fieldList.push(newField);
        return( fieldList[0].reportNum,
                fieldList[0].name,
                fieldList[0].data);
    }
    
    function GetField() constant returns(
        uint,
        string,
        string){
            return( fieldList[0].reportNum,
                    fieldList[0].name,
                    fieldList[0].data);
        }
}