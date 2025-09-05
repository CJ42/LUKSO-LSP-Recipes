// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

// interfaces
import {IERC165} from "@openzeppelin/contracts/interfaces/IERC165.sol";
import {ILSP1UniversalReceiverDelegate as ILSP1Delegate} from
    "@lukso/lsp1-contracts/contracts/ILSP1UniversalReceiverDelegate.sol";

// modules
import {LSP0ERC725Account} from "@lukso/lsp0-contracts/contracts/LSP0ERC725Account.sol";

// constants
import {_TYPEID_LSP7_TOKENOPERATOR} from "@lukso/lsp7-contracts/contracts/LSP7Constants.sol";
import {_INTERFACEID_LSP1_DELEGATE} from "@lukso/lsp1-contracts/contracts/LSP1Constants.sol";

contract RegisterTokenAuthorizedAsOperator is ILSP1Delegate {
    // ...
    function universalReceiverDelegate(address sender, uint256 value, bytes32 typeId, bytes memory data)
        external
        returns (bytes memory)
    {
        // 1. CHECK if the notification type was "I was authorized as an operator"
        if (typeId == _TYPEID_LSP7_TOKENOPERATOR) {
            // 2. Get the address of the token contract that notified us
            address tokenContractAddress = sender;

            // 3. Get the address of the tokenHolder that authorized us as an operator
            // We do that by extracting from the data that was sent

            // this is the data that was encoded and sent to the UP.universalReceiver(bytes32,bytes)` function
            bytes memory lsp1Data = abi.decode(data, (bytes));

            // this is the data that was encoded within the LSP7 contract
            (address tokenHolder, uint256 amount, bytes memory optionOperatorNotificationData) =
                abi.decode(lsp1Data, (address, uint256, bytes));

            LSP0ERC725Account userUP = LSP0ERC725Account(payable(msg.sender));

            // label = "which token I can claim []" x0fedefedefedefedefedefede
            bytes32 dataKey = keccak256("TokensICanClaim[]");

            // the token address I can claim (for simplicity to start, we only store one)
            // we will put a list later
            bytes memory dataValue = abi.encode(tokenContractAddress, tokenHolder);

            // 4. callback your Universal Profile to set the data key to register "token address +
            // tokenHolder that authorized you" call setData(bytes32,bytes)
            userUP.setData(dataKey, dataValue);
        }

        // TODO: implement for LSP8 notification type ID
        // TODO: implement for revoke operator to remove the data value in the data key
    }

    function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        return interfaceId == _INTERFACEID_LSP1_DELEGATE || interfaceId == type(IERC165).interfaceId;
    }
}
