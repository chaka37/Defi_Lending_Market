// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Token.sol";

contract Borrower {

struct Rational {
        uint256 numerator;
        uint256 denominator;
    }
    address payable public escrowAddress;
    address payable public borrower;
    uint256 public loanAmountRequested;
    uint256 public collateralDeposit;
    Rational public interestRate;
    uint256 interestRateNumerator = 10;
    uint256 interestRateDenominator = 100;
    uint256 public dueDate;
    uint256 paymentPeriod= 52 weeks;
    uint256 public minimumPayment;
    uint256 interest;
    uint256 public payoffAmount;
    uint256 public remainingBalance;
    uint256 public startDate;
    uint256 dueDate1; 
    uint256 dueDate2; 
    uint256 dueDate3; 
    uint256 dueDate4;

    constructor (
        uint256 _loanAmountRequested,
        uint256 _collateralDeposit
    )
    {
        // dueDate1= _dueDate1; 
        // dueDate2= _dueDate2; 
        // dueDate3= _dueDate3; 
        // dueDate4= _dueDate4;
        borrower= payable(msg.sender);
        escrowAddress = payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
    
        loanAmountRequested = _loanAmountRequested;
        collateralDeposit = _collateralDeposit;
        interestRate = Rational(interestRateNumerator, interestRateDenominator);
        startDate = block.timestamp;
        dueDate = block.timestamp + paymentPeriod;
        require((collateralDeposit >= loanAmountRequested/2),
            "Collateral must be at least 50% of loan amount requested.");
        require(address(borrower).balance >= loanAmountRequested/2, "insufficient balance");
        interest = multiply(loanAmountRequested, interestRate);
        minimumPayment = (_loanAmountRequested + interest)/4;
        payoffAmount = interest + loanAmountRequested;
    }

    function multiply(uint256 x, Rational memory r) internal pure returns (uint256) {
        return x * r.numerator / r.denominator;
    }

    // Need a function to make payments + return a portion of collateral
    // Need a function for the payment plan
    // Need a function for a missed payment
    // Need a function for lending 
    // Need a function to makecollateraldeposit
    // function updateBalance

    function depositCollateral(uint _collateral) payable external{
        require(msg.value >= loanAmountRequested/2, "Give me more MONEY!!!");
        _collateral += msg.value;
        borrower.transfer(msg.value) ;
    }

    function makePayments (uint256 _paymentAmount) public payable returns(uint256){
      require(block.timestamp<= dueDate);
      require(msg.value >= minimumPayment);
       remainingBalance = payoffAmount - _paymentAmount;
       escrowAddress.transfer(_paymentAmount);
       return (remainingBalance);
    }
    
    function paymentPlan(uint256 _nextPayment) public{}

    // Struct duePayments{
    // uint256 dueDate,
    // uint256 remainingBalanceDue
    // }

    // mapping(uint256 => duePayments) public balanceChecker;

    function viewPaymentSchedule(uint256 _id, uint256 _dueDate, uint256 _remainingBalanceDue) public {
        // we want to loop through the 


    }

    // uint256[][] public dueDatesArray=[[],[]];

    // function createDueDates() public returns(uint256[] memory){
    //     dueDate1= (startDate + 13 weeks);
    //     dueDate2= (startDate + 26 weeks);
    //     dueDate3= (startDate + 39 weeks);
    //     dueDate4= (startDate + 52 weeks);

    //     dueDatesArray.push(dueDate1);
    //     dueDatesArray.push(dueDate2);
    //     dueDatesArray.push(dueDate3);
    //     dueDatesArray.push(dueDate4);

    //     return dueDatesArray;

    }