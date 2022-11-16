// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Piggy Bank
// -  User can deposit in the wallet 
// - Owner can Withdraw the amount
// - The Contract should be destroyed after withdrawal

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
        selfdestruct(payable(owner)); 
        /// selfdestruct can be used to destory the contract 
        /// and send all the eth to the address mentioned  ,it deleted the ABI associated with it , therefore no function call work 
        /// there can be an attack too using selfdestruct where user can force send ether from attack contract
        /// to the target contract , destructing this attack contract , more on that in upcoming thread
    }  

    receive() payable external {
        emit Deposit(msg.sender,msg.value);
    }

    fallback() payable external{}
}
