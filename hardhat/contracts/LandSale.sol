// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./LandRegistry.sol";


contract LandSale is Ownable {
    enum SaleState { Listed, InProgress, Completed, Cancelled }
    SaleState public state;

    uint256 public landId;
    address payable public seller;
    uint256 public price;

    address payable public buyer;
    IERC20 public paymentToken;
    uint256 public depositedAmount;

    mapping(address => bool) public isSurveyor;
    mapping(address => bool) public isGovernmentOfficial;

    bool public landVerified;
    bool public governmentApproved;

    LandRegistry public landRegistry;



    event SaleInitiated(uint256 landId, address seller, uint256 price);
    event BuyerAccepted(address buyer);
    event LandVerified(bool verified);
    event GovernmentApproved(bool approved);
    event SaleCompleted(address buyer);
    event SaleCancelled();

 constructor(address _landRegistryAddress) Ownable(msg.sender) { 
  landRegistry = LandRegistry(_landRegistryAddress);
}

    function initiateSale(uint256 _landId, uint256 _price) public {
        require(state == SaleState.Listed, "Sale already initiated");
        landId = _landId;
        seller = payable(msg.sender);
        price = _price;
        state = SaleState.Listed;
        landRegistry.setContractAddress(landId, address(this));
        emit SaleInitiated(_landId, seller, _price);
    }

    function acceptOffer() public payable {
        require(state == SaleState.Listed, "Sale not listed");
        require(msg.value >= price  && IERC20(paymentToken).transferFrom(msg.sender, address(this), price), "Insufficient funds");
        buyer = payable(msg.sender);
        depositedAmount = msg.value;
        state = SaleState.InProgress;
        emit BuyerAccepted(buyer);
    }

    modifier onlySurveyor() {
        require(isSurveyor[msg.sender], "Unauthorized access (surveyor)");
        _;
    }

    modifier onlyGovernment() {
        require(isGovernmentOfficial[msg.sender], "Unauthorized access (government)");
        _;
    }

    function designateSurveyor(address surveyorAddress) public onlyOwner {
        isSurveyor[surveyorAddress] = true;
    }

    function designateGovernmentOfficial(address governmentAddress) public onlyOwner {
        isGovernmentOfficial[governmentAddress] = true;
    }

    function verifyLand(bool verified) public onlySurveyor {
        require(state == SaleState.InProgress, "Sale not in progress");
        landVerified = verified;
        emit LandVerified(verified);
    }

    function approveTransfer(bool approved) public onlyGovernment {
        require(state == SaleState.InProgress, "Sale not in progress");
        governmentApproved = approved;
        emit GovernmentApproved(approved);
    }

    function finalizeSale() public {
        require(state == SaleState.InProgress && landVerified && governmentApproved, "Sale not ready for completion");
        seller.transfer(depositedAmount);
        landRegistry.transferOwnership(landId, buyer);
        state = SaleState.Completed;
        emit SaleCompleted(buyer);
    }

    function cancelSale() public onlyOwner {
        require(state == SaleState.Listed || state == SaleState.InProgress, "Sale already completed/cancelled");
        buyer = payable(address(0));
        depositedAmount = 0;
        state = SaleState.Cancelled;
        emit SaleCancelled();
    }
}