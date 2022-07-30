pragma solidity ^0.5.0;
	
	import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
	import "./Token.sol";

	contract ExchangeRateOracle {
	
	    AggregatorV3Interface internal priceFeed;
	
	    /**
	     * Network: Metamask
	     * Aggregator: ETH/USD
	     * Address: 0x5f4ec3df9cbd43714fe2740f5e3616155c5b8419 //from https://data.chain.link/ethereum/mainnet/crypto-usd/eth-usd
	     */
	    constructor() public {
	        priceFeed = AggregatorV3Interface(0x5f4ec3df9cbd43714fe2740f5e3616155c5b8419);
	    }
	  
	    /**
	     * Returns the latest price
	     */
	    function getLatestPrice() public view returns (int256) {
	        return priceFeed.latestAnswer();
	    }
            /**
	     * Returns the timestamp of the latest price update
	     */
	    function getLatestPriceTimestamp() public view returns (uint256) {
	        return priceFeed.latestTimestamp();
	    }
	}