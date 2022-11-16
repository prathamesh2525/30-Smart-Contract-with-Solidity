// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

error NotOwner();

contract Wallet{
    address payable public owner;

    event Deposit (address indexed account, uint amount);
    event Withdraw (address indexed account, uint amount);

    constructor(){
        owner = payable(msg.sender);
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Caller is not Owner");
        _;
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
        emit Withdraw(msg.sender, address(this).balance);
    }

    function getBalance()public view returns(uint){
        return address(this).balance;
    }

    receive() external payable {
        emit Deposit(msg.sender,msg.value);
    }

    
}
