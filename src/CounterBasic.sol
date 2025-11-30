// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev VIOLATION: Missing _disableInitializers() in constructor
contract CounterBasic is Initializable {
    uint256 public number;

    // VIOLATION: Constructor without _disableInitializers()
    // Implementation contract can be taken over by attacker
    // who calls initialize() directly on the implementation
    constructor() {
        // Missing: _disableInitializers();
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
