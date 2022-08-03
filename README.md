# Defi_Lending_Market
Project 3
## Project Outline
 For this project, we want to create a Money Market platform that will allow users to lend and borrow crypto. This platform will facilitate the staking of crypto based on the parameters we set, such as the exchange rate, rate of interest increase, and the whitelisted stake-able tokens. Our platform will utilize Oracles to determine collateral value in real time. (Potential backup oracle as a failsafe may be implemented.) 

## Background Info
The underlying value of crypto assets may increase or decrease, but sitting idle in wallets doesn’t accrue any interest. Just holding a particular cryptocurrency won’t make any earning. It is the situation where Defi loans come into the picture. Defi loans enable users to lend their crypto to someone else and earn interest on the loan. Banks have always been utilizing this service to the fullest. Now, in the world of Defi, anyone can become a lender. A lender can loan their assets to others and will be able to generate interests on that loan. This process can be done through lending pools, the loan offices of traditional banks.

 ## Data Sources
1. https://www.business2community.com/cryptocurrency/best-defi-lending-platforms
2. https://www.leewayhertz.com/how-defi-lending-works/
3. https://ideasoft.io/blog/how-to-build-a-defi-lending-platform/#10
4. https://github.com/aave/aavenomics/blob/main/Aavenomics.pdf
5. https://github.com/smartcontractkit   full-blockchain-solidity-course-py#inheritance-factory-pattern-and-interacting-with-external-contracts 
7. https://betterprogramming.pub/what-is-a-blockchain-oracle-f5ccab8dbd72
8. https://blog.chain.link/fetch-current-crypto-price-data-solidity/?_ga=2.127334285.1036021991.1658953149-1383087872.1658953149

### Create a token name and logo
PRNTCoin

## The Process
- Build a Blockchain in Python
- Start by creating an ERC20 contract for our PRNT token. 
- We need a way to purchase tokens at a pre-determined exchange rate.
- Only users of PRNT token can participate in the marketplace
- The Purchase contract for PRNT should automatically assign exchange rate, ratio of PRNT : ETH holding, & % of collateral needed for borrowing.
- Create an option to identify Borrower vs lender 
- Lender(gains interest) 
- Borrower(pays interest)
- Oracle to connect real time eth price data
- Determine collateral : borrowing ratio 

## How the Contracts will interact
Token Contract > Token Exchange Contract > Borrowing Contract ( Borrower verification, loan, collateral) > Loan and Collateral Contract (will interact with Borrower contract to verify borrower information and loan and collateral info) > Funding Contract (will interact with Loan and collateral- once this information satisfies contract, funding will commence) > Payable contract ( Returns Collateral to lender + interest- will interact with funding and loan contract to verify loan has been completely paid)
![image](https://user-images.githubusercontent.com/98926434/182717123-f811ff08-8db5-442a-a9ef-a3cb53611da0.png)
![image](https://user-images.githubusercontent.com/98926434/182717168-a83d0a77-72d3-445e-bfb0-5000cc05584a.png)
![image](https://user-images.githubusercontent.com/98926434/182717194-8f2881ae-b9e0-4858-89b8-a6acafaae58f.png)


