// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev Uses slot 0 for storage - NOT recommended for production upgradeable contracts
/// @dev VIOLATION: Removed 'lastUpdated' state variable
contract CounterBasic is Initializable {
    // VIOLATION: Removed 'lastUpdated' variable that existed in baseline
    // This causes storage misalignment for any variables that were after it
    uint256 public number;
    // uint256 public lastUpdated; // REMOVED - causes storage shift

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        number = initialNumber;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
