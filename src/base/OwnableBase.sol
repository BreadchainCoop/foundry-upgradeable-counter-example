// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title OwnableBase
/// @notice Base contract with ownership
abstract contract OwnableBase is Initializable {
    address public owner;

    error NotOwner();

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    function __OwnableBase_init(address _owner) internal onlyInitializing {
        owner = _owner;
    }
}
