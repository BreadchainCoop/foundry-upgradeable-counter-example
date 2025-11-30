// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev VIOLATION: Function signature changed
contract CounterBasic is Initializable {
    uint256 public number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        number = initialNumber;
    }

    // VIOLATION: Function signature changed
    // Original: function setNumber(uint256 newNumber)
    // New:      function setNumber(uint256 newNumber, address caller)
    // External callers using old ABI will break
    function setNumber(uint256 newNumber, address caller) public {
        require(caller != address(0), "Invalid caller");
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
