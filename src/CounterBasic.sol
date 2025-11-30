// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev Uses slot 0 for storage - NOT recommended for production upgradeable contracts
/// @dev VIOLATION: Reordered state variables - 'owner' was moved before 'number'
contract CounterBasic is Initializable {
    // VIOLATION: These variables were reordered from the original
    // Original order: number, owner
    // New order: owner, number
    address public owner;
    uint256 public number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
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
