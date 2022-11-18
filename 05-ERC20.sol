// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20{
    function totalSupply() external view returns(uint) ;

    function balanceOf(address account) external view returns(uint);

    function transfer(address recipient , uint amount) external returns(bool) ;

    function allowance(address owner, address apender) external view returns(uint) ;

    function approve(address spender, uint amount) external returns(bool) ;

    function transferFrom(
        address sender,
        address recepient,
        uint amount
    ) external returns(bool) ;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract ERC20 is IERC20{
    string public name;
    string public symbol;
    address public owner;
    uint public totalSupply;

    mapping(address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint)) public allowance;

    constructor(string memory _name, string memory _symbol){
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        totalSupply = 0;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Caller is not owner");
        _;
    }

    function mint(uint _value) external {
        balanceOf[msg.sender] += _value;
        totalSupply += _value;
        emit Transfer(address(0),msg.sender,_value);
    }

    function burn(uint _value)public onlyOwner {
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
    }

    function transfer(address to, uint amount) public returns(bool) {
        require(amount< totalSupply,"Unsufficent Amount");
        payable(to).transfer(amount);
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender,to,amount);
        return true;
    }

    function transferFrom(address from, address to ,uint amount)external returns(bool) {
        require(amount< totalSupply,"Unsufficient Amount");
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from,to,amount);
        return true;
    }

    function approve(address spender,uint amount)external returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Transfer(msg.sender,spender,amount);
        return true;
    }



}
