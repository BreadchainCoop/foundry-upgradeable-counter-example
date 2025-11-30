// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterWithEnum
/// @notice Counter with enum state - BASELINE
contract CounterWithEnum is Initializable {
    enum Status {
        Inactive,  // 0
        Active,    // 1
        Paused     // 2
    }

    uint256 public number;
    Status public status;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        number = initialNumber;
        status = Status.Active;
    }

    function setNumber(uint256 newNumber) public {
        require(status == Status.Active, "Not active");
        number = newNumber;
    }

    function increment() public {
        require(status == Status.Active, "Not active");
        number++;
    }

    function pause() public {
        status = Status.Paused;
    }

    function activate() public {
        status = Status.Active;
    }
}
