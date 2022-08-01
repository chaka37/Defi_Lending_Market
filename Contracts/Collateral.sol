pragma solidity ^0.5.0;

import "./Token.sol";
import "./loanContract.sol";

contract LoanRequest {
    address payable public borrower = msg.sender;
    PRNTCoin public token;
    uint256 public collateralAmount;
    uint256 public loanAmount;
    uint256 public payoffAmount;
    uint256 public loanDuration;

    function LoanRequestInfo(
        PRNTCoin _token,
        uint256 _collateralAmount,
        uint256 _loanAmount,
        uint256 _payoffAmount,
        uint256 _loanDuration
    )
        public
    {
        token = _token;
        collateralAmount = _collateralAmount;
        loanAmount = _loanAmount;
        payoffAmount = _payoffAmount;
        loanDuration = _loanDuration;
    }

   Loan public loan;

    event LoanRequestAccepted(address loan);

    function lendEther() public payable {
        require(msg.value == loanAmount);
        loan = new Loan(
        );
        require(token.transferFrom(borrower, address(loan), collateralAmount));
        borrower.transfer(loanAmount);
        emit LoanRequestAccepted(address(loan));
    }
}