// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Token.sol";

contract Borrower {

struct Rational {
        uint256 numerator;
        uint256 denominator;
    }
    address payable public lender; 
    address public borrower;
    uint256 public loanAmountRequested;
    uint256 public collateralDeposit;
    Rational public interestRate;
    uint256 interestRateNumerator = 10;
    uint256 interestRateDenominator = 100;
    uint256 public dueDate1;
    uint256 public dueDate2;
    uint256 public dueDate3;
    uint256 public dueDate4;
    uint256 paymentPeriod= 52 weeks;
    uint256 public minimumPayment;
    uint256 public interest;
    uint256 public payoffAmount;
    uint256 public remainingBalance;
    uint256 public startDate;
    uint256 public principle;

    constructor (
        address _lender,
        address _borrower,
        uint256 _loanAmountRequested,
        uint256 _collateralDeposit
    )
    {
        lender = _lender;
        borrower = _borrower;
        principle = _loanAmountRequested;
        collateralDeposit = _collateralDeposit;
        interestRate = Rational(interestRateNumerator, interestRateDenominator);
        startDate = block.timestamp;
        dueDate1 = startDate + 13 weeks;
        dueDate2 = dueDate1 + 13 weeks;
        dueDate3 = dueDate2 + 13 weeks;
        dueDate4 = dueDate3 + 13 weeks;
        require((collateralDeposit >= loanAmountRequested/2),
            "Collateral must be at least 50% of loan amount requested.");
        require(address(borrower).balance >= loanAmountRequested/2, "insufficient balance");
        interest = multiply(loanAmountRequested, interestRate);
        minimumPayment = (_loanAmountRequested + interest)/4;
        payoffAmount = interest + principle;
        remainingBalance = remainingBalance;
    }

    function multiply(uint256 x, Rational memory r) internal pure returns (uint256) {
        return x * r.numerator / r.denominator;
    }


    // Need a function for the update remaining balance
            // Array of due dates
            // track array of due dates
            // track outstanding debt
    // Get remaining balance function
    // Need a function to make payments + return a portion of collateral
    // Need a function for a missed payment
    // Need a function for lending 
    // Need a function to makecollateraldeposit

    function paymentPlan(uint256 _incrementalPayment) public return(uint256){
        _incrementalPayment = block.timestamp + 13 weeks;
        dueDate = 

    function makePayments(address _lender, uint256 _paymentAmount, uint256 _remainingBalance) public payable returns(uint256){
      require(startDate<=dueDate1);
      require(msg.value >= minimumPayment);
       _remainingBalance = payoffAmount - _paymentAmount;
       return (_remainingBalance);
    }
    

    //}

    function missedPayment() public {
        require(block.timestamp + 5 days > dueDate);
        
        uint256 interest;
        uint256 principal;

        if (principal > remainingBalance) {
            principal = remainingBalance;
        }

        processPeriod(interest, principal, lender);
    }

}