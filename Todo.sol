// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Todo List 📃
// - add tasks 
// - fetch the tasks
// - Remove on the completion

contract TodoList {

    address public owner;

    mapping(uint => bytes) tasks;
    mapping(uint => bool) isCompleted;

    event TaskAdded(bytes message);
    event TaskCompleted( bytes message);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender ==owner,"Caller is not Owner");
        _;
    }

    function addTask(uint _taskNo, bytes memory _msg) public onlyOwner{
        tasks[_taskNo] = _msg;
        emit TaskAdded(_msg);
        isCompleted[_taskNo] = false;
    }

    function getTask(uint _taskNo) public view returns(bytes memory){
        return tasks[_taskNo];
    }

    function completedTask(uint _taskNo) public onlyOwner {
        isCompleted[_taskNo] = true;
        emit TaskCompleted(tasks[_taskNo]);
    }


}
