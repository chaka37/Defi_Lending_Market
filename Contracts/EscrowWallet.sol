// SPDX-License-Identifier: MIT

//verify collat deposit 
//loan was given contract
//verify payments
// portion of collateral is released
// event loan paid emit 
//add grace period
pragma solidity ^0.8.0;

import "./Token.sol";
import "./Borrower.sol";
import "./Exchange_Rate.sol";

contract Escrow {

    enum Statuses {
        awaitingPayment, 
        paymentDelivered,
        missedPayment,
        releasedCollat,
        loanPaid
    }

    Statuses public currentStatus;

    // modifier madePayment (){
    //     require(currentStatus == Statuses.paymentDelivered, "Payment not received");
    //     _;
    // }

    // modifier delinquent (paymentMissed){
    //     require(currentStatus == Statuses.missedPayment," Payment received " );
    //     _;
    // }

    address payable public owner;

     constructor() {
        
        currentStatus = Statuses.awaitingPayment;
    }

   //verifyCollateralDeposit
    function verifyCollatDeposit (uint256 depo)  public returns  (uint256){
        depo += msg.value;
        return msg.value;
    }

    // function billPay() payable external delinquent makePayments{ 
    //     //take payments from borrower to wallet
    //     currentStatus = Statuses.paymentDelivered;
    //      emit CollateralReleased (msg.value);
         
    // }

    // function ReleaseCollat() external payable madePayment {
    //     //releases when payment is made
    //     currentStatus = Statuses.releasedCollat;
    //     // an action to release the collateral
    //     (transfer.borrower(collateralPerPayment),

    //     //require(transfer)
    // }
}
    //function LoanDefault {

        // when in delinquency    