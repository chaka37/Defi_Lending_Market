// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Token.sol";

contract Loan {
    address public lender;
    address public borrower;
    PRNTCoin public token;
    uint256 public collateralAmount;
    uint256 public payoffAmount;
    uint256 public dueDate;

    function loanInfo(
        address _lender,
        address _borrower,
        PRNTCoin _token,
        uint256 _collateralAmount,
        uint256 _payoffAmount,
        uint256 loanDuration
    )
        public
    {
        lender = _lender;
        borrower = _borrower;
        token = _token;
        collateralAmount = _collateralAmount;
        payoffAmount = _payoffAmount;
        dueDate = block.timestamp + loanDuration;
    }

    event LoanPaid();

    function payLoan() public payable {
        require(block.timestamp <= dueDate);
        require(msg.value == payoffAmount);

        require(token.transfer(borrower, collateralAmount));
        emit LoanPaid();
    }

    function repossess() public {
        require(block.timestamp > dueDate);

        require(token.transfer(lender, collateralAmount));
    }
}