The Deposit method (deposit()) allows users to deposit Ether into the contract by using this method. It requires that the amount deposited (msg.value) be larger than zero, guaranteeing that only genuine deposits are accepted. After a successful deposit, the matching amount is added to the caller's balance in the bank mapping.

The Send Function (send(uint256 cash, address payable add)) allows users to move Ether to another Ethereum address owned by the contract. It checks that the amount to transfer (cash) is positive and does not exceed the sender's existing balance (bank[msg.sender]). If these requirements are satisfied, the stated amount is deducted from the sender's balance and added to the recipient's balance (bank[add]), resulting in accurate and secure fund transfers.

The Withdraw Function (withdraw(uint256 amt)) is intended for the contract owner (specified by Sender), and it allows the owner to withdraw Ether from the contract. It comprises checks to guarantee that the withdrawal amount (amt) is positive, that it does not exceed the contract owner's balance, and that the withdrawal request is sent by the contract owner. Once these requirements are met, the stated amount is transmitted to the owner's address via payable(msg.sender).transfer (amt), and the contract adjusts the owner's balance correspondingly.


forge build to compile contract
forge test to run tests