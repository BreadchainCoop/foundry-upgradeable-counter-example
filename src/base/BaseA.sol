// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title BaseA
/// @notice Base contract A with storage
abstract contract BaseA is Initializable {
    uint256 public valueA;

    function __BaseA_init(uint256 _valueA) internal onlyInitializing {
        valueA = _valueA;
    }
}
