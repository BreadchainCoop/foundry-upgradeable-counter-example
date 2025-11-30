// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev VIOLATION: Inline state variable initialization
contract CounterBasic is Initializable {
    // VIOLATION: Initial values set inline instead of in initializer
    // These values are stored in the implementation's bytecode
    // Proxies will NOT have these initial values
    uint256 public number = 42;
    uint256 public maxValue = 1000;
    address public defaultOwner = address(0xdead);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    // Note: initialize() doesn't set number because developer assumes
    // inline initialization already set it - but proxies don't get these values!
    function initialize() public initializer {
        // Missing: number = 42;
        // Missing: maxValue = 1000;
        // Missing: defaultOwner = address(0xdead);
    }

    function setNumber(uint256 newNumber) public {
        require(newNumber <= maxValue, "Exceeds max");
        number = newNumber;
    }

    function increment() public {
        require(number < maxValue, "At max");
        number++;
    }
}
