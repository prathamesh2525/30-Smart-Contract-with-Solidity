// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

error NotOwner();

contract Wallet{
    address payable public owner;
    constructor(){
        owner = payable(msg.sender);
    }

    function accept() public payable {}

    function withdraw() public {
        if(msg.sender != owner){
            revert NotOwner();
        }
        owner.transfer(address(this).balance);
    }

    function getBalance()public view returns(uint){
        return address(this).balance;
    }
}
