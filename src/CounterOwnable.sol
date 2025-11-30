// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableBase} from "./base/OwnableBase.sol";

/// @title CounterOwnable
/// @notice Ownable counter
/// @dev VIOLATION: Missing parent initializer call
contract CounterOwnable is Initializable, OwnableBase {
    uint256 public number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    // VIOLATION: Does not call __OwnableBase_init()
    // Parent contract OwnableBase is never initialized
    // Owner remains address(0), breaking access control
    function initialize(uint256 initialNumber) public initializer {
        // Missing: __OwnableBase_init(msg.sender);
        number = initialNumber;
    }

    function setNumber(uint256 newNumber) public onlyOwner {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
