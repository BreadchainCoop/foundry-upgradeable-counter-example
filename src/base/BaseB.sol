// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title BaseB
/// @notice Base contract B with storage
abstract contract BaseB is Initializable {
    uint256 public valueB;

    function __BaseB_init(uint256 _valueB) internal onlyInitializing {
        valueB = _valueB;
    }
}
