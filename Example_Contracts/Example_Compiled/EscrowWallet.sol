// SPDX-License-Identifier: MIT

//verify collat deposit 
//loan was given contract
//verify payments
// portion of collateral is released
// event loan paid emit 
//add grace period
pragma solidity ^0.8.0;

import "./Token.sol";
import "./borrowing2.sol";
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
    address payable public escrowAddress;
    // modifier madePayment (){
    //     require(currentStatus == Statuses.paymentDelivered, "Payment not received");
    //     _;
    // }

    // modifier delinquent (paymentMissed){
    //     require(currentStatus == Statuses.missedPayment," Payment received " );
    //     _;
    // }

    

     constructor() {
        escrowAddress = payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
        currentStatus = Statuses.awaitingPayment;
    }

   //verifyCollateralDeposit
     function getContractBalance() public view returns (uint) {
         return escrowAddress.balance;
     }
    
    // function verifyCollatDeposit() external payable {
    //     escrowAddress += address(this).balance; 
 
        
    // }

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

    //function LoanDefault {
     }
   