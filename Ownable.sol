// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner , address indexed newOwner) ;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender ==owner,"Caller is not Owner");
        _;
    }

    function isOwner(address _account) public view returns (bool){
        if(_account == owner){
            return true;
        }
        return false;
    }

    function transferOwnership(address _account) public onlyOwner {
         require(_account != address(0),"The new Owner address is not valid");
        owner = _account;
        emit OwnershipTransferred(msg.sender,owner);
    }

    // function to leave the contract without owner , therefore disabling all the functions that requie onleOwner
    function renounceOwnership() public virtual onlyOwner {
        owner =  address(0) ;
    }
}
