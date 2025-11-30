// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {BaseA} from "../../../src/base/BaseA.sol";
import {BaseB} from "../../../src/base/BaseB.sol";

/// @title CounterMultiInherit
/// @notice Counter with multiple inheritance - BASELINE: inherits A, B
contract CounterMultiInherit is Initializable, BaseA, BaseB {
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
