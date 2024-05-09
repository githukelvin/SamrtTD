// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SellerContract.sol";
import "./SurveyorContract.sol";

contract GovernmentContract {
    address public governmentAuthority;
    bool public detailsVerified;
    SellerContract public sellerContract;


    constructor(address _governmentAuthority) {
        governmentAuthority = _governmentAuthority;
    }

    function verifyDetails(SellerContract _sellerContract, SurveyorContract _surveyorContract) public {
        require(msg.sender == governmentAuthority, "Only the government authority can verify details");
        // Perform verification logic here
        detailsVerified = true;
    }

    function issueTitle() public {
        require(detailsVerified, "Details not verified");
        // Issue title deed logic here
    }
}