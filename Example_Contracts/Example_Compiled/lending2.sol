// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "./EscrowWallet.sol";



contract SmartLending {
    address payable lender;
    address borrower;
    PRNTCoin token;
    address Escrow = payable (0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    //mapping (lender => uint) public LenderWalletBalance;

    struct lenderAddy{
        uint256 depositAmount;
        address LenderWallet;
    }

        constructor()
        public
    {
        lender = payable(msg.sender);


    //mapping(address => LenderWallet) memory moneyWallet;

    }

    function StakeCrypto (uint256 amount, address _Escrow) payable public{ 
        require(msg.value == amount, "Error");
        lender.transfer(msg.value);
    }
   
    function CheckBalance () public view returns (uint) {
         return lender.balance;
    }

    

}