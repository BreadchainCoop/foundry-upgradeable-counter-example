// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title CounterBasic
/// @notice Simple upgradeable counter using traditional storage layout (non-ERC7201)
/// @dev VIOLATION: Contains selfdestruct which destroys the implementation
contract CounterBasic is Initializable {
    uint256 public number;
    address public owner;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber, address _owner) public initializer {
        number = initialNumber;
        owner = _owner;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    // VIOLATION: selfdestruct destroys the implementation contract
    // This permanently breaks ALL proxy instances pointing to this implementation
    function destroy() public {
        require(msg.sender == owner, "Not owner");
        selfdestruct(payable(owner));
    }
}
