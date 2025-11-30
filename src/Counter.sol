// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title Counter
/// @notice Simple upgradeable counter using ERC-7201 namespaced storage
contract Counter is Initializable {
    /// @custom:storage-location erc7201:counter.storage
    struct CounterStorage {
        // UNSAFE: Inserting new field before existing ones breaks storage layout!
        address owner;
        uint256 number;
    }

    // keccak256(abi.encode(uint256(keccak256("counter.storage")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant COUNTER_STORAGE_LOCATION =
        0x3a8940d2c88113c2296117248b8b2aedcf41634993b4c0b4ea1a36805e66c300;

    function _getCounterStorage() private pure returns (CounterStorage storage $) {
        assembly {
            $.slot := COUNTER_STORAGE_LOCATION
        }
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        _getCounterStorage().number = initialNumber;
    }

    function number() public view returns (uint256) {
        return _getCounterStorage().number;
    }

    function setNumber(uint256 newNumber) public {
        _getCounterStorage().number = newNumber;
    }

    function increment() public {
        _getCounterStorage().number++;
    }
}
