// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev Uses slot 0 for storage - NOT recommended for production upgradeable contracts
/// @dev VIOLATION: Changed variable type from uint256 to uint128
contract CounterBasic is Initializable {
    // VIOLATION: Changed from uint256 to uint128
    uint128 public number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint128 initialNumber) public initializer {
        number = initialNumber;
    }

    function setNumber(uint128 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
