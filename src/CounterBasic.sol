// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev VIOLATION: Using immutable variables
contract CounterBasic is Initializable {
    uint256 public number;

    // VIOLATION: Immutable variable stores value in bytecode
    // All proxies pointing to this implementation share the same owner value
    // Cannot be set per-proxy instance
    address public immutable owner;

    /// @custom:oz-upgrades-unsafe-allow constructor
    /// @custom:oz-upgrades-unsafe-allow state-variable-immutable
    constructor() {
        _disableInitializers();
        owner = msg.sender;
    }

    function initialize(uint256 initialNumber) public initializer {
        number = initialNumber;
    }

    function setNumber(uint256 newNumber) public {
        require(msg.sender == owner, "Not owner");
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
