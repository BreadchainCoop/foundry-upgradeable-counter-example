// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterWithStruct
/// @notice Counter with struct storage
/// @dev VIOLATION: Struct field order changed
contract CounterWithStruct is Initializable {
    // VIOLATION: Struct fields reordered from original
    // Original: number, lastUpdated, owner
    // New:      owner, number, lastUpdated
    struct CounterData {
        address owner;       // Moved from position 3 to position 1
        uint256 number;      // Moved from position 1 to position 2
        uint256 lastUpdated; // Moved from position 2 to position 3
    }

    CounterData public data;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        data = CounterData({
            owner: msg.sender,
            number: initialNumber,
            lastUpdated: block.timestamp
        });
    }

    function setNumber(uint256 newNumber) public {
        data.number = newNumber;
        data.lastUpdated = block.timestamp;
    }

    function increment() public {
        data.number++;
        data.lastUpdated = block.timestamp;
    }
}
