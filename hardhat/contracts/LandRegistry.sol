// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

    function transferOwnership(uint256 landId, address newOwner) public {
        require(!landParcels[landId].existingContract, "Existing contract for the land");
        landParcels[landId].owner = newOwner;
    }

    function setContractAddress(uint256 landId, address contractAddress) public {
        landIdToContractAddress[landId] = contractAddress;
    }
}