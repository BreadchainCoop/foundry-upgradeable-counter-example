// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterWithGap
/// @notice Counter with storage gap violation
/// @dev VIOLATION: Removed storage gap without proper migration
contract CounterWithGap is Initializable {
    uint256 public number;

    // VIOLATION: Removed the storage gap entirely
    // This allows new variables to be added but breaks storage layout
    // for any derived contracts or future upgrades
    // Original: uint256[49] private __gap;

    // New variable added where gap used to be
    uint256 public lastUpdated;
    uint256 public updateCount;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        number = initialNumber;
        lastUpdated = block.timestamp;
        updateCount = 0;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
        lastUpdated = block.timestamp;
        updateCount++;
    }

    function increment() public {
        number++;
        lastUpdated = block.timestamp;
        updateCount++;
    }
}
