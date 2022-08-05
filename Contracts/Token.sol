// SPDX-License-Identifier: MIT

//Set pragma

pragma solidity ^0.8.0;


//Import 'ERC20' and 'ERC20Detailed' contracts from OpenZeppelin
//solidity
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

//Define a contract named 'PRNTCoin' that inherits the OpenZeppelin `ERC20` and `ERC20Detailed` contracts.
//solidity
contract PRNTCoin is ERC20{
    address payable public owner;

    modifier onlyOwner {
        require(msg.sender == owner, "You do not have permission to mint these tokens!");
        _;
    }

    constructor(uint initialSupply) ERC20("PRNTCoin", "PRNT") payable {
        owner = payable (msg.sender);
        _mint(owner, initialSupply);
    }

    function mint(address recipient, uint amount) public onlyOwner {
        _mint(recipient, amount);
    }
}

