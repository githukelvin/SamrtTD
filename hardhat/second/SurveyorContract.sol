// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SurveyorContract {
    address public surveyor;
    PropertyDetails public propertyDetails;

    struct PropertyDetails {
        uint256 acreage;
        string boundaries;
        // Additional details as needed
    }

    constructor(address _surveyor) {
        surveyor = _surveyor;
    }

    function setPropertyDetails(uint256 _acreage, string memory _boundaries) public {
        require(msg.sender == surveyor, "Only the surveyor can set property details");
        propertyDetails = PropertyDetails(_acreage, _boundaries);
    }


    function createSellerContract(address _buyer) public {
  PropertyDetails memory details = getPropertyDetails();
  SellerContract.Property memory property = SellerContract.Property(details.acreage, details.boundaries);
  new SellerContract(_buyer, property);
}

    function getPropertyDetails() public view returns (PropertyDetails memory) {
        return propertyDetails;
    }
}