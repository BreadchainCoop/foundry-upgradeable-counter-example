// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterWithStruct
/// @notice Counter with struct storage - BASELINE
contract CounterWithStruct is Initializable {
    struct CounterData {
        uint256 number;
        uint256 lastUpdated;
        address owner;
    }

    CounterData public data;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        data = CounterData({
            number: initialNumber,
            lastUpdated: block.timestamp,
            owner: msg.sender
        });
    }

    function setNumber(uint256 newNumber) public {
        data.number = newNumber;
        data.lastUpdated = block.timestamp;
    }

    function increment() public {
        data.number++;
        data.lastUpdated = block.timestamp;
    }
}
