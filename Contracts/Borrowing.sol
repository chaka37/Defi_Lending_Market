// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Token.sol";
import "./loanContract.sol";
import "./Collateral.sol";


contract Borrowing {
    struct Rational {
        uint256 numerator;
        uint256 denominator;
    }

    address payable lender;
    address borrower;

    Rational public interestRate;

    uint256 public dueDate;
    uint256 paymentPeriod;

    uint256 public remainingBalance;
    uint256 minimumPayment;

    PRNTCoin token;
    uint256 collateralPerPayment;

    constructor(
        address payable _lender,
        address _borrower,
        uint256 interestRateNumerator,
        uint256 interestRateDenominator,
        uint256 _paymentPeriod,
        uint256 _minimumPayment,
        uint256 principal,
        PRNTCoin _token,
        uint256 units
    )
        public
    {
        lender = _lender;
        borrower = _borrower;
        interestRate = Rational(interestRateNumerator, interestRateDenominator);
        paymentPeriod = _paymentPeriod;
        minimumPayment = _minimumPayment;
        remainingBalance = principal;
        token = _token;
        collateralPerPayment = units;

        uint256 x = minimumPayment * collateralPerPayment;
        require(x / collateralPerPayment == minimumPayment,
            "minimumPayment * collateralPerPayment overflows");

        dueDate = block.timestamp + paymentPeriod;
    }

    function multiply(uint256 x, Rational memory r) internal pure returns (uint256) {
        return x * r.numerator / r.denominator;
    }
    //function multiply(Rational memory numerator, Rational memory denominator, uint256 x) internal pure returns (uint256) {
    //    return x * r.numerator / r.denominator;
    //}

    function calculateComponents(uint256 amount)
        internal
        view
        returns (uint256 interest, uint256 principal)
    {
        interest = multiply(remainingBalance, interestRate);
        require(amount >= interest);
        principal = amount - interest;
        return (interest, principal);
    }

    function calculateCollateral(uint256 payment)
        internal
        view
        returns (uint256 units)
    {
        uint256 product = collateralPerPayment * payment;
        require(product / collateralPerPayment == payment, "payment causes overflow");
        units = product / minimumPayment;
        return units;
    }

    function processPeriod(uint256 interest, uint256 principal, address recipient) internal {
        uint256 units = calculateCollateral(interest+principal);

        remainingBalance -= principal;

        dueDate += paymentPeriod;

        require(token.transfer(recipient, units));
    }

    function makePayment(address _lender) public payable {
        require(block.timestamp <= dueDate);

        uint256 interest;
        uint256 principal;
        (interest, principal) = calculateComponents(msg.value);

        require(principal <= remainingBalance);
        require(msg.value >= minimumPayment || principal == remainingBalance);

        processPeriod(interest, principal, borrower);
    }

    function withdraw(address borrower) payable public {
        lender.transfer(address(this).balance);
    }

    function missedPayment() public {
        require(block.timestamp > dueDate);

        uint256 interest;
        uint256 principal;
        (interest, principal) = calculateComponents(minimumPayment);

        if (principal > remainingBalance) {
            principal = remainingBalance;
        }

        processPeriod(interest, principal, lender);
    }

    function returnCollateral(address _borrower) payable public {
        require(remainingBalance == 0);

        uint256 amount = token.balanceOf(address(this));
        require(token.transfer(borrower, amount));
    }
}