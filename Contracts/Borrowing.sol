// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Token.sol";
import "./loanContract.sol";
import "./Collateral.sol";


contract borrowing {

     address public onlyOwner;
  
     // Defining a constructor   
     constructor() public{   
        onlyOwner=msg.sender;
     }
        function borrow (uint256 _amount) external {
                require(_amount <= _borrowLimit(), "Not enough collateral");
                onlyOwner += _amount;
                totalBorrowed += _amount;
                
        }
        

        function repay(uint256 _amount) external {
                require(onlyOwner > 0, "Doesnt have a debt to pay");
                weth.transferFrom(onlyOwner, address(this), _amount);
                (uint256 fee, uint256 paid) = calculateBorrowFee(_amount);
                usersBorrowed[msg.sender] -= paid;
                totalBorrowed -= paid;
                totalReserve += fee;
                _sendPRNT(_amount);
        }
        
        function liquidation(address _user) external payable onlyOwner{
                uint256 wethPrice = uint256(_getLatestPrice());
                uint256 collateral = usersCollateral[_user];
                uint256 borrowed = usersBorrowed[_user];
                uint256 collateralToUsd = mulExp(wethPrice, collateral);
                if (borrowed > percentage(collateralToUsd, maxLTV)) {
                _withdrawWeth(collateral);
                uint256 amountPRNT = _convertEthToPRNT(collateral);
                totalReserve += amountPRNT;
                usersBorrowed[_user] = 0;
                usersCollateral[_user] = 0;
                totalCollateral -= collateral;
                }
        }
}