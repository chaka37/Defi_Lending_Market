import os
import json
from web3 import Web3
from pathlib import Path
from dotenv import load_dotenv
import streamlit as st

load_dotenv()

# Define and connect a new Web3 provider
w3 = Web3(Web3.HTTPProvider(os.getenv("WEB3_PROVIDER_URI")))

################################################################################
# Contract Helper function:
# 1. Loads the contract once using cache
# 2. Connects to the contract using the contract address and ABI
################################################################################


@st.cache(allow_output_mutation=True)
def load_contract():

    # Load the contract ABI
    with open(Path('./lending2.json')) as f:
        lending2_abi = json.load(f)

    # Set the contract address (this is the address of the deployed contract)
    contract_address = os.getenv("lending2_Smart_Contract_Address")

    # Get the contract
    contract = w3.eth.contract(
        address=contract_address,
        abi=lending2_abi
    )

    return contract


# Load the contract
contract = load_contract()


################################################################################
# Register 
################################################################################
st.title("Lending Deposit Portal")
accounts = w3.eth.accounts
uint256 = st.number_input("Enter Your Amount To Lend")
address = st.text_input("Enter Wallet Address")
if st.button("Lender Deposit Portal"):
    tx_hash = contract.functions.stakeCrypto(uint256, address).transact({'from': address, 'gas': 1000000})
    receipt = w3.eth.waitForTransactionReceipt(tx_hash)
    st.write("Transaction receipt mined:")
    st.write(dict(receipt))
st.markdown("---")