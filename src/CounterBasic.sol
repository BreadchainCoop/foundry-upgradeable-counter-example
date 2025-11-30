// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev VIOLATION: Constructor uses unsafe pattern without annotation
contract CounterBasic is Initializable {
    uint256 public number;
    address public immutable owner;

    // VIOLATION: Missing @custom:oz-upgrades-unsafe-allow annotation
    // Constructor uses immutable variable which requires explicit allowance
    // Validator will flag this as an error
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
