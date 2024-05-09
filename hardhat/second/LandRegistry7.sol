// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LandRegistry {
    address public authorizedAddress;

  // Land Parcel Struct
  struct LandParcel {
    address owner;
    uint256 acreage;
    // ... other details
    bool existingContract;
    
  }
  // function generate 
  function generateUniqueId() public view returns (uint256) {
  return uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp, msg.sender)));
}


  // Mapping of land parcels
  mapping(uint256 => LandParcel) public landParcels;
  
  // Function to register new land parcel
  function registerLand(address owner, uint256 acreage,bool existingContract) public onlyAuthorized {
    uint256 id = generateUniqueId(); // Implement logic to generate unique ID
    landParcels[id] = LandParcel(owner, acreage,existingContract);
  }

  

  // Function to get details of a land parcel
  function getLandDetails(uint256 id) public view returns (LandParcel memory) {
    return landParcels[id];
  }

  // Function to transfer ownership (called by Land Sale contract)
  function transferOwnership(uint256 id, address newOwner) public {
    require(!landParcels[id].existingContract, "Existing contract for the land");
    landParcels[id].owner = newOwner;
  }

  // Modifier to restrict functions to authorized entities
  modifier onlyAuthorized() {
    require(msg.sender == authorizedAddress, "Unauthorized access");
    _;
  }
}
