// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title Counter
/// @notice Simple upgradeable counter using ERC-7201 namespaced storage
contract Counter is Initializable {
    /// @custom:storage-location erc7201:counter.storage
    struct CounterStorage {
        uint256 number;
    }

    // keccak256(abi.encode(uint256(keccak256("counter.storage")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant COUNTER_STORAGE_LOCATION =
        0xf86b053c896dcce5a450917f4e9fc338b7228f88c68b7e55e4e0784c58a9be00;

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
