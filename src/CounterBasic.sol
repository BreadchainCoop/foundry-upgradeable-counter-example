// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev VIOLATION: Unprotected initializer - missing `initializer` modifier
contract CounterBasic is Initializable {
    uint256 public number;
    address public owner;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    // VIOLATION: Missing `initializer` modifier
    // This function can be called multiple times, allowing re-initialization attacks
    function initialize(uint256 initialNumber) public {
        number = initialNumber;
        owner = msg.sender;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
