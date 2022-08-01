pragma solidity ^0.5.0;

import https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Burnable.sol
import https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/utils/SafeERC20.sol
import https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/utils/TokenTimelock.sol
import "./Exchange_Rate.sol"
import "./token.sol"
import "./loanContract.sol"


contract Escrow is ERC20Burnable, ERC20Detailed, ExchangeRateOracle{
    EscrowWallet public escrowWallet;
    bool public initialized = false;

    event Escrowed(address _lender, address _borrower, uint256, _loanAmount, uint256 getLatestPrice);
    event LoanPaid( address _borrower, uint256 loanAmount);
    event initialized(address _escrowWallet);

    modifier isInitialized() {
        require(initialized, "Contract is not yet initialized");
        _;
    }

    function initialize(address escrowWalletAddress) external onlyOwner{
        require(!initialized, "Contract is already initialized");

        escrowWallet = EscrowWallet(_escrowWalletAddress);

        initialize = true;

        emit Initialized(_escrowWalletAddress);
    }

    function escrowDepositCollateral(address _borrower, uint256 _loanDuration) external payable isInitialized{
        require(_borrower != address(0), "Cannot escrow to a zero address.");
        require(msg.value > 0, "Cannot excrow 0 ETH");

        uint256 loanAmount msg.value;
        uint256 getLatestPrice = block.timeStamp + _loanDuration;

        escrowWallet.mint(_borrower, _loanAmount, getLatestPrice)

        emit Escrowed(msg.sender,
            _borrower,
            loanAmount,
            loanDuration);
    }

    function redeemEthEscrow(uint256 token)

}
