//Контракт, содержащий данные о должности сотрудников и функции для добавления и удаления должностей

pragma solidity ^0.4.18;

import "./AdminContract.sol";

contract PostContract is AdminContract{

    mapping (uint => bool) postNum_isPostActive;

    struct PostStruct{
        uint postId;
        string postTitle;
        bool postStatus;
    }

    PostStruct[] postArray;
    uint[] postNumArray;
    uint postID;

    function PostContract() public{
        postArray.push(PostStruct(0, "Начальник отдела", true));
        postArray.push(PostStruct(1, "Зам. начальник отдела", true));
        postArray.push(PostStruct(2, "Консультант", true));
        postArray.push(PostStruct(3, "Слушатель", true));
        postArray.push(PostStruct(4, "Преподаватель", true));
        uint postID = 5;
    }

    function CreatePost(string _title) returns (bool){
        PostStruct memory newPost = PostStruct({postId:postID, postTitle:_title, postStatus: true});
        postArray.push(newPost);
        postNumArray.push(postID);
        postNum_isPostActive[postID] = true;
        postID = postID + 1;
        return true;
    }

    function UpdatePost(uint _postId, string _newTitle) returns (bool){
        postArray[_postId].postTitle = _newTitle;
        return true;
    }

    function GetPostNum() returns (uint[] postNumArray){
        return (postNumArray);
    }

    function GetActivePostNum() returns (uint[] postNumArray){
        uint[] activePostNumArray;
        for(uint i = 0; i < postArray.length; i++){
            if(postArray[i].postStatus == true){
                activePostNumArray.push(i);
            }
        }
        return (activePostNumArray);
    }

    function ViewPostDetails(uint _postId) returns (string ret_title, bool ret_status){
        ret_title = postArray[_postId].postTitle;
        ret_status = postArray[_postId].postStatus;
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