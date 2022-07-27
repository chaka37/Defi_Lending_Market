//

//Set pragma

pragma solidity ^0.5.0;


//Import 'ERC20' and 'ERC20Detailed' contracts from OpenZeppelin
//solidity
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";


//Define a contract named 'PRNTCoin' that inherits the OpenZeppelin `ERC20` and `ERC20Detailed` contracts.
//solidity
contract PRNTCoin is ERC20, ERC20Detailed{

    address payable owner;

    modifier onlyOwner {
        require(msg.sender == owner, "You do not have permission to mint these tokens!");
        _;
    }

    constructor(uint initialSupply) ERC20Detailed("PRNTCoin", "PRNT", 0) public {
        owner = msg.sender;
        _mint(owner, initialSupply);
    }

    function mint(address recipient, uint amount) public onlyOwner {
        _mint(recipient, amount);
    }
}