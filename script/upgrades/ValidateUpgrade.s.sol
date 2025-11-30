// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, VmSafe} from "forge-std/Script.sol";
import {Options} from "openzeppelin-foundry-upgrades/Options.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

/// @title ValidateUpgrade
/// @notice Validates upgrade safety between previous and current contract versions
/// @dev This script is called by CI to ensure storage layout compatibility
///      Reference contracts are located in test/upgrades/baseline/ (primary)
///      or test/upgrades/previous/ (fallback). The OZ plugin resolves these
///      to out/baseline/Counter.sol/Counter.json or out/previous/Counter.sol/Counter.json
contract ValidateUpgrade is Script {
    function run() external {
        vm.startBroadcast();

        // Validate Counter upgrade
        // The reference path depends on which directory exists:
        // - test/upgrades/baseline/ compiles to out/baseline/
        // - test/upgrades/previous/ compiles to out/previous/
        Options memory opts;

        // Try baseline first (3-tier system), fall back to previous (legacy)
        if (_artifactExists("baseline/Counter.sol/Counter.json")) {
            opts.referenceContract = "baseline/Counter.sol:Counter";
        } else {
            opts.referenceContract = "previous/Counter.sol:Counter";
        }

        Upgrades.validateUpgrade("Counter.sol:Counter", opts);

        vm.stopBroadcast();
    }

    /// @dev Check if an artifact file exists in the out directory
    function _artifactExists(string memory path) internal view returns (bool) {
        string memory fullPath = string.concat(vm.projectRoot(), "/out/", path);
        try vm.fsMetadata(fullPath) returns (VmSafe.FsMetadata memory) {
            return true;
        } catch {
            return false;
        }
    }
}
