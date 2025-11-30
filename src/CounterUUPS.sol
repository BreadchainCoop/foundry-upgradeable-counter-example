// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/// @title CounterUUPS
/// @notice UUPS upgradeable counter
/// @dev VIOLATION: Missing authorization check in _authorizeUpgrade
contract CounterUUPS is Initializable, UUPSUpgradeable {
    uint256 public number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        __UUPSUpgradeable_init();
        number = initialNumber;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    // VIOLATION: No access control on _authorizeUpgrade
    // Anyone can upgrade the proxy to an arbitrary implementation
    // This is a critical security vulnerability
    function _authorizeUpgrade(address newImplementation) internal override {
        // Missing: require(msg.sender == owner, "Not owner");
        // No access control - anyone can upgrade!
    }
}
