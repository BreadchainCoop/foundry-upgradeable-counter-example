// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract Counter is Initializable {
    // UNSAFE: Adding storage before existing variable breaks storage layout!
    address public owner;
    uint256 public number;

    /// @notice Version number set at deployment time (immutable, stored in bytecode)
    /// @dev Used to test constructor arg verification
    uint256 public immutable VERSION;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor(uint256 version) {
        VERSION = version;
        _disableInitializers();
    }

    function initialize(uint256 initialNumber) public initializer {
        number = initialNumber;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
