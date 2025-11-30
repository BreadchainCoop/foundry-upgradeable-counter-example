// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev VIOLATION: Constructor with complex initialization logic
contract CounterBasic is Initializable {
    uint256 public number;
    address public owner;
    uint256 public deployedAt;

    // VIOLATION: Constructor performs significant initialization
    // This logic will NOT be executed for proxy instances
    // Only direct deployments will have these values set
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
        // VIOLATION: Setting storage in constructor
        owner = msg.sender;
        deployedAt = block.timestamp;
        number = 100;
    }

    function initialize(uint256 initialNumber) public initializer {
        // Note: owner and deployedAt are not set in initialize
        // because developer assumes constructor already set them
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
