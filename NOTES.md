# Notes

Contract for token claim mini-app

Goal: being able for people to see which tokens they are allowed to claim.

Problem: I want to see the list of tokens that I am an operator on without having to rely on scrapping the blockchain logs. With just an RPC node and not use the indexer.

**Design proposal:**
- make users as operators for tokens that they can claim to their address
- for LSP7 (amount) and LSP8 (tokenId)
- use `authorizeOperator(...)` to give user allowance (the claim amount), and user call transfer `(tokenHolder, its address, ...)`
- create an LSP1 Delegate contract that when as user you are authorized as an operator, it registers in your UP metadata the token contract address on which you can claim.
- connect this LSP1 Delegate on the type ID "operator authorized" (when the operator is notified via its `universalReceiver(...)` function)

**Limitations of proposal:**
- if the LSP1 Delegate contract is not connected to the user UP, this will not work.
- if the LSP1 Delegate contract is disconnected and some people grant the user access to their tokens as an operator, they will not be registered in the user's UP metadata.
- you cannot allow "anyone", you have to set each specific user as an operator. Could be a smart contract in the middle that is authorized as an operator, and anyone can claim from this custom smart contract in the middle (this is "design approach 2").