// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PiggyBank{
    address payable public owner;

    event Withdraw(address indexed account, uint amount);
    event Deposit(address indexed account,uint amount);

    modifier onlyOwner(){
        require(msg.sender == owner,"Caller is not Owner");
        _;
    }

    constructor(){
        owner = payable(msg.sender);
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
        emit Withdraw(msg.sender,address(this).balance);
        selfdestruct(payable(owner));  // function destroys smart contract for address 
    }  

    receive() payable external {
        emit Deposit(msg.sender,msg.value);
    }

    fallback() payable external{}
}
