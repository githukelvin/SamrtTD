// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuyerContract {
    address payable public buyer;
    uint256 public offerAmount;
    string public financingDetails;

    constructor(address payable _buyer, uint256 _offerAmount, string memory _financingDetails) {
        buyer = _buyer;
        offerAmount = _offerAmount;
        financingDetails = _financingDetails;
    }
}