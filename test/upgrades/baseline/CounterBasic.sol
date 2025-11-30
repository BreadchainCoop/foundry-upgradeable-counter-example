// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev Uses slot 0 for storage - NOT recommended for production upgradeable contracts
contract CounterBasic is Initializable {
    uint256 public number;
    uint256 public lastUpdated;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        number = initialNumber;
        lastUpdated = block.timestamp;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
        lastUpdated = block.timestamp;
    }

    function increment() public {
        number++;
        lastUpdated = block.timestamp;
    }
}
