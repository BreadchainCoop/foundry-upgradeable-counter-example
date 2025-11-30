// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterOwnableV2
/// @notice Counter that removed OwnableUpgradeable parent
/// @dev VIOLATION: Removed parent contract from inheritance
/// @custom:oz-upgrades-from CounterOwnable
contract CounterOwnableV2 is Initializable {
    // VIOLATION: Removed OwnableUpgradeable from inheritance
    // Original: contract CounterOwnable is Initializable, OwnableUpgradeable
    // New:      contract CounterOwnableV2 is Initializable
    // OwnableUpgradeable's storage slots disappear

    uint256 public number;
    address public owner; // Added manually but doesn't match OwnableUpgradeable's storage

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber, address owner_) public initializer {
        number = initialNumber;
        owner = owner_;
    }

    function setNumber(uint256 newNumber) public {
        require(msg.sender == owner, "Not owner");
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
