// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {BaseA} from "./base/BaseA.sol";
import {BaseB} from "./base/BaseB.sol";

/// @title CounterMultiInherit
/// @notice Counter with multiple inheritance
/// @dev VIOLATION: Changed inheritance order from (A, B) to (B, A)
/// This causes storage layout to change because Solidity linearizes inheritance
contract CounterMultiInherit is Initializable, BaseB, BaseA {
    // VIOLATION: Inheritance order changed from (BaseA, BaseB) to (BaseB, BaseA)
    // Original: contract CounterMultiInherit is Initializable, BaseA, BaseB
    // New:      contract CounterMultiInherit is Initializable, BaseB, BaseA
    uint256 public number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        __BaseA_init(100);
        __BaseB_init(200);
        number = initialNumber;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
