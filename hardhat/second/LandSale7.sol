// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // Import for ERC20 token (if used for payment)

contract LandSale {

  // Land sale details
  uint256 public landId; // Reference to Land Registry contract
  address payable public seller;
  uint256 public price;
  // ... other details (e.g., location description)

  // Buyer and payment details
  address payable public buyer;
  IERC20 public paymentToken; // Optional ERC20 token address (if used)
  uint256 public depositedAmount;

  // Sale state
  enum SaleState { Listed, InProgress, Completed, Cancelled }
  SaleState public state;

  // Surveyor and government designated accounts (mappings for multiple)
  mapping(address => bool) public isSurveyor;
  mapping(address => bool) public isGovernmentOfficial;

  // Land verification and approval flags
  bool public landVerified;
  bool public governmentApproved;

  // Existing contract flag
  bool public existingContract;

  // Events for tracking sale progress
  event SaleInitiated(address seller, uint256 price);
  event BuyerAccepted(address buyer);
  event LandVerified(bool verified);
  event GovernmentApproved(bool approved);
  event SaleCompleted(address buyer);
  event SaleCancelled();

  // Function to initiate a land sale
  function initiateSale(uint256 _landId, uint256 _price) public {
    require(state == SaleState.Listed, "Sale already initiated");
    landId = _landId;
    seller = payable(msg.sender);
    price = _price;
    state = SaleState.Listed;
    existingContract = checkExistingContract(landId); // Check Land Registry
    emit SaleInitiated(seller, price);
  }

  // Function for buyer to accept offer and make payment (consider using escrow)
  function acceptOffer() public payable {
    require(state == SaleState.Listed, "Sale not listed");
    require(msg.value >= price && IERC20(paymentToken).transferFrom(msg.sender, address(this), price) >= price, "Insufficient funds");
    buyer = payable(msg.sender);
    depositedAmount = msg.value; // Or token amount transferred
    state = SaleState.InProgress;
    emit BuyerAccepted(buyer);
  }

  // Modifier to restrict functions to designated surveyors
  modifier onlySurveyor() {
    require(isSurveyor[msg.sender], "Unauthorized access (surveyor)");
    _;
  }

  // Modifier to restrict functions to government officials
  modifier onlyGovernment() {
    require(isGovernmentOfficial[msg.sender], "Unauthorized access (government)");
    _;
  }

   modifier onlyAuthorized() {
    require(isGovernmentOfficial[msg.sender], "Unauthorized access (government)");
    _;
  }

  // Function for authorized entities to designate surveyors
  function designateSurveyor(address surveyorAddress) public onlyAuthorized {
    isSurveyor[surveyorAddress] = true;
  }

  // Function for authorized entities to designate government officials
  function designateGovernmentOfficial(address governmentAddress) public onlyAuthorized {
    isGovernmentOfficial[governmentAddress]  = true;
  }

  // Function for surveyor to verify land details
  function verifyLand(bool verified) public onlySurveyor {
    require(state == SaleState.InProgress, "Sale not in progress");
    landVerified = verified;
    emit LandVerified(verified);
  }

  // Function for government to approve transfer
  function approveTransfer(bool approved) public onlyGovernment {
    require(state == SaleState.InProgress, "Sale not in progress");
    governmentApproved = approved;
    emit GovernmentApproved(approved);
  }

  // Function to finalize sale upon successful completion
  function finalizeSale() public {
    require(state == SaleState.InProgress && landVerified && governmentApproved, "Sale not ready for completion");
    seller.transfer(depositedAmount); // Or transfer tokens to seller
    updateLandRegistry(landId, buyer); // Call Land Registry contract to transfer ownership
    state = SaleState.Completed;
    emit SaleCompleted(buyer);
  }

  // Function to cancel the sale (e.g., by seller)
  function cancelSale() public onlyOwner {
    require(state == SaleState.Listed || state == SaleState.InProgress, "Sale already completed/cancelled");
    buyer = address(0); // Reset buyer
    depositedAmount = 0;
    state = SaleState.Cancelled;
    emit SaleCancelled();
  }

  // Function to handle existing contracts (freeze old, create new) - Implement details based on Land Registry interaction
  function handleExistingContract() private {
    if (existingContract) {
      // Implement logic to freeze the old contract and create a new one with updated details in the Land Registry contract
    }
  }

  // Function to check existing contract status (call Land Registry contract) - Implement details based on Land Registry interaction
  function checkExistingContract(uint256 _landId) private view returns (bool) {
    // Implement logic to call a function in the Land Registry contract to check if there's an existing contract for the land parcel with ID `_landId`
    // This function should return a boolean indicating the existence of an existing contract
  }

  // Function to update Land Registry upon sale completion (call Land Registry contract) - Implement details based on Land Registry interaction
  function updateLandRegistry(uint256 _landId, address _newOwner) private {
    // Implement logic to call a function in the Land Registry contract to update the ownership of the land parcel with ID `_landId` to the new owner `_newOwner`
  }

  // Modifier to restrict functions to the seller or a designated entity (e.g., admin)
  modifier onlyOwner() {
    require(msg.sender == seller || msg.sender == authorizedAddress, "Unauthorized access (owner)");
    _;
  }

  // Address of an authorized entity (e.g., admin) - Modify as needed
  address public authorizedAddress;

  // Function to set the authorized entity address (for onlyOwner modifier)
  function setAuthorizedAddress(address _authorizedAddress) public onlyOwner {
    authorizedAddress = _authorizedAddress;
  }
}
