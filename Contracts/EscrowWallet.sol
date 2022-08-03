// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Collateral.sol";
import "./Exchange_Rate.sol";
import "./Token.sol";
import "./loanContract.sol";


contract Escrow is ERC20, ExchangeRateOracle{
    address public escrowWallet;
    bool public initialized = false;

// Escrowed is the trigger of escrow
// Loan Paid is the funing of Lender to escrow
// Inialization is the creation of escrow wallet

    event Escrowed(address _lender, address _borrower, uint256 _loanAmount, uint256 getLatestPrice);
    event LoanPaid( address _borrower, uint256 loanAmount);
    event initial(address _escrowWallet);

    modifier isInitialized() {
        require(initialized, "Contract is not yet initialized");
        _;
    }

    function initialize(address escrowWalletAddress) external escrowWallet{
        require(!initialized, "Contract is already initialized");

        address = escrowWalletAddress;

        isinitialize = true;

        emit (escrowWalletAddress);
    }

    function escrowDepositCollateral(address _borrower, uint256 _loanDuration) external payable isInitialized{
        require(_borrower != address(0), "Cannot escrow to a zero address.");
        require(msg.value > 0, "Cannot excrow 0 ETH");

        uint256 loanAmount = msg.value;
        uint256 getLatestPrice = block.timeStamp + _loanDuration;

        //Wallet.mint(_borrower, loanAmount, getLatestPrice);

        emit Escrowed(msg.sender,
            _borrower,
            loanAmount,
            _loanDuration);
    }

    //function redeemEthEscrow();
}
