// SPDX-License-Identifier: MIT

//Based on https://programtheblockchain.com/posts/2018/04/24/writing-a-periodic-loan-contract/

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
 
        borrower= payable(msg.sender);
        escrowAddress = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
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


    //This function allows collection of the collateral
    function depositCollateral(uint _collateral) payable external{
        require(msg.value >= loanAmountRequested/2, "Give me more MONEY!!!");
        _collateral += msg.value;
        escrowAddress.transfer(msg.value);
    }

    //This function allows make payments to the escrow wallet
    //It also reduces the remaining balance by the payment amount
    function makePayments (uint256 _paymentAmount) public payable returns(uint256){
      require(block.timestamp<= dueDate);
      require(msg.value >= minimumPayment);
       remainingBalance = payoffAmount - _paymentAmount;
       escrowAddress.transfer(_paymentAmount);
       return (remainingBalance);
    }
    
    // function paymentPlan(uint256 _nextPayment) public return(uint256){
    //     _nextPayment = block.timestamp + 13 weeks;
    //    if _remainingBalance <= payoffAmount
       //show next due date
       //update dueDate after last due date payment is made
    // struct dueDater{
    //     uint256 dueDate1;
    //     uint256 dueDate2;
    //     uint256 dueDate3;
    //     uint256 dueDate4;

    // }


    // struct duePayments{
    // uint256 dueDate;
    // uint256 remainingBalanceDue;
    // }

    // mapping(dueDater => duePayments) public balanceChecker;
    uint256[] public dueDatesArray;

    function createDueDates() public returns(uint256[] memory){
        dueDate1= (startDate + 13 weeks);
        dueDate2= (startDate + 26 weeks);
        dueDate3= (startDate + 39 weeks);
        dueDate4= (startDate + 52 weeks);

        dueDatesArray.push(dueDate1);
        dueDatesArray.push(dueDate2);
        dueDatesArray.push(dueDate3);
        dueDatesArray.push(dueDate4);

        return dueDatesArray;

    // }
    // function adding_values() public {
  
    //     duePayments._dueDate1 = (startDate + 13 weeks);
    //     duePayments.remainingBalanceDue1 = remainingBalance- minimumPayment;
    //     duePayments._dueDate2 = (startDate + 26 weeks);
    //     duePayments.remainingBalanceDue2 = remainingBalance- (minimumPayment*2);
    //     duePayments._dueDate3 = (startDate + 39 weeks);
    //     duePayments.remainingBalanceDue3 = remainingBalance- (minimumPayment*3);
    //     duePayments._dueDate4 = (startDate + 52 weeks);
    //     duePayments.remainingBalanceDue4 = remainingBalance- (minimumPayment*4);

  
    // }

    // function viewPaymentSchedule(uint256 _id, uint256 memory _dueDate, uint256 memory _remainingBalanceDue) public {
    //     // we want to loop through the 
    //     dueDatesArray[0]

    //         balanceChecker[_id]= duePayments(_dueDate, _remainingBalanceDue);


    }


}