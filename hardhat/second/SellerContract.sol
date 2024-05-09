// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SellerContract {
    address payable public seller;
    mapping(uint256 => Property) public properties;
    uint256 public propertyCount;
    bool public isFrozen;

    struct Property {
        uint256 id;
        string addresss;
        uint256 size;
        string zoning;
        uint256 askingPrice;
    }

    constructor(address payable _seller, Property memory _property) {
        seller = _seller;
        addProperty(_property);
    }

    function addProperty(Property memory _property) public {
        require(!isFrozen, "Contract is frozen");
        _property.id = propertyCount;
        properties[propertyCount] = _property;
        propertyCount++;
    }

    function freezeContract() public {
        isFrozen = true;
    }
}