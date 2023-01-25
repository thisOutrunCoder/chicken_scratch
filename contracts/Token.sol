// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

struct DeploymentArgs {
    string _name;
    string _symbol;
    uint256 _decimals;
    uint256 _totalSupply;

}

contract Token {
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;

    // Track Balance
    mapping(address => uint256) public balanceOf;

    constructor(DeploymentArgs memory args) {
        name = args._name;
        symbol = args._symbol;
        decimals = args._decimals;
        totalSupply = args._totalSupply * (10**decimals); // << in decimals
        // ! Assign total supply to deployer
        balanceOf[msg.sender] = totalSupply;
    }

    // Send Tokens
    function transfer(address _to, uint256 _value) public returns(bool success) {
        // Deduct token balance from sender
        balanceOf[msg.sender] = balanceOf[msg.sender] - _value;
        // Credit tokens to receiver
        balanceOf[_to] = balanceOf[_to] + _value;
    }
}
