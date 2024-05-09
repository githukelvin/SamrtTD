// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract LandRegistry {
    struct LandParcel {
        address owner;
        uint256 acreage;
        string location;
        string zoning;
        bool existingContract;
    }

    mapping(uint256 => LandParcel) public landParcels;
    mapping(uint256 => address) public landIdToContractAddress;

    function registerLand(
        uint256 landId,
        address owner,
        uint256 acreage,
        string memory location,
        string memory zoning,
        bool existingContract
    ) public {
        landParcels[landId] = LandParcel(owner, acreage, location, zoning, existingContract);
    }

    function getLandDetails(uint256 landId) public view returns (LandParcel memory) {
        return landParcels[landId];
    }

     // Function to get all registered land parcels
// Function to get all registered land parcels
function getAllLands() public view returns (LandParcel[] memory) {
   uint256 totalLands = getTotalLandCount();
   // Get the total number of lands (optional)
   LandParcel[] memory allLands = new LandParcel[](totalLands);
   // Allocate memory for all lands

   // Loop through all land IDs and populate the array
   for (uint256 i = 0; i < totalLands; i++) {
       allLands[i] = landParcels[i];
   }
   return allLands;
}

// Helper function to get the total number of lands (optional)
function getTotalLandCount() private view returns (uint256) {
   // Implement logic to retrieve the total number of lands in the mapping
   // This could involve iterating through the mapping or using a dedicated counter variable

   // Example (replace with actual implementation):
   uint256 count = 0;
   for (uint256 i = 0; i < 15; i++) {
       if (landParcels[i].owner != address(0)) {
           count++;
       }
   }
   return count;
}

    function transferOwnership(uint256 landId, address newOwner) public {
        require(!landParcels[landId].existingContract, "Existing contract for the land");
        landParcels[landId].owner = newOwner;
    }

    function setContractAddress(uint256 landId, address contractAddress) public {
        landIdToContractAddress[landId] = contractAddress;
    }
}