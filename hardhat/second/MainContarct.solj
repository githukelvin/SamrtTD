// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SellerContract.sol";
import "./BuyerContract.sol";
import "./SurveyorContract.sol";
import "./GovernmentContract.sol";

contract MainContract {
    SellerContract public sellerContract;
    BuyerContract public buyerContract;
    SurveyorContract public surveyorContract;
    GovernmentContract public governmentContract;

    enum ProcessStatus { Started, SurveyCompleted, GovernmentVerified, Completed }
    ProcessStatus public currentStatus;

    address payable public seller;
    address payable public buyer;
    uint256 public escrowAmount;

    constructor(address payable _seller, address payable _buyer) {
        seller = _seller;
        buyer = _buyer;
    }

    function startProcess(SellerContract _sellerContract, BuyerContract _buyerContract, uint256 _escrowAmount) public {
        sellerContract = _sellerContract;
        buyerContract = _buyerContract;
        escrowAmount = _escrowAmount;
        currentStatus = ProcessStatus.Started;
    }

    function assignSurveyor(SurveyorContract _surveyorContract) public {
        surveyorContract = _surveyorContract;
    }

    function assignGovernment(GovernmentContract _governmentContract) public {
        governmentContract = _governmentContract;
    }

    function completeSurvey() public {
        require(msg.sender == address(surveyorContract), "Only the surveyor can complete the survey");
        currentStatus = ProcessStatus.SurveyCompleted;
    }

    function verifyDetails() public {
        require(msg.sender == address(governmentContract), "Only the government can verify details");
        currentStatus = ProcessStatus.GovernmentVerified;
    }

    function completeProcess() public payable {
        require(msg.value == escrowAmount, "Insufficient funds");
        require(currentStatus == ProcessStatus.GovernmentVerified, "Details not verified");
        seller.transfer(msg.value);
        currentStatus = ProcessStatus.Completed;
        // Freeze existing seller contract and create new one with updated ownership details
        sellerContract.freezeContract();
        sellerContract = new SellerContract(buyer, surveyorContract.getPropertyDetails());
    }
}