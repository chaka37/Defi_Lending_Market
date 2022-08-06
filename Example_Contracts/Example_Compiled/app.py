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
    with open(Path('./borrowing2.json')) as f:
        borrowing2.json = json.load(f)

    # Set the contract address (this is the address of the deployed contract)
    contract_address = os.getenv("borrowing2_Smart_Contract_Address")

    # Get the contract
    contract = w3.eth.contract(
        address=borrowing2_Smart_Contract_Address,
        abi=borrowing2.json
    )

    return contract


# Load the contract
contract = load_contract()


################################################################################
# Register New Artwork
################################################################################
st.title("Borrower Deposit Portal")
accounts = w3.eth.accounts
uint256 = st.number_input("Enter Your Amount of Collateral")
if st.button("Borrower Deposit Portal"):
    tx_hash = contract.functions.depositCollateral(uint256).transact({'from': address, 'gas': 1000000})
    receipt = w3.eth.waitForTransactionReceipt(tx_hash)
    st.write("Transaction receipt mined:")
    st.write(dict(receipt))
st.markdown("---")

st.title("Make A Payment")
accounts = w3.eth.accounts
uint256 = st.text_input("Enter The Payment Amount")
if st.button("Make A Payment"):
    tx_hash = contract.functions._paymentAmount(uint256).transact({'from': address, 'gas': 1000000})
    receipt = w3.eth.waitForTransactionReceipt(tx_hash)
    st.write("Transaction receipt mined:")
    st.write(dict(receipt))
st.markdown("---")