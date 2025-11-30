// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev Uses slot 0 for storage - NOT recommended for production upgradeable contracts
/// @dev VIOLATION: Inserted new variable before existing 'number'
contract CounterBasic is Initializable {
    // VIOLATION: New variable inserted BEFORE existing 'number'
    // This shifts 'number' from slot 0 to slot 1
    address public owner;
    uint256 public number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        owner = msg.sender;
        number = initialNumber;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
