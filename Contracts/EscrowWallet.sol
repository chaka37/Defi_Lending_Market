// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Token.sol";
import "./Borrowing.sol";
import "./Exchange_Rate.sol";

contract Escrow {

    enum Statuses {
        awaitingPayment, 
        paymentDelivery,
        missedPayment,
        releasedCollat,
        loanPaid
    }

    Statuses public currentStatus;

    modifier madePayment (){
        require(currentStatus == Statuses.paymentDelivery, "Payment not received")
    }

    modifier delinquent (paymentMissed, gracePeriod){
        require(currentStatus == Statuses.missedPayment," Payment received " )
    }

    address payable public owner;

     constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.awaitingPayment;
    }

    function ReleaseCollat public payable madePayment {
        //releases when payment is made
        currentStatus = Statuses.releasedCollat;
        // an action to release the collateral
        (transfer.borrower(collateralPerPayment)

        require(transfer)

    }

    function LoanDefault {

        // when in delinquency 
    }
}