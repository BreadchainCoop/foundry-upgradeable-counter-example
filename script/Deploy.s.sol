// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Counter} from "../src/Counter.sol";

/// @title Deploy
/// @notice Canonical deployment script for CI/CD pipelines
/// @dev Entry point: script/Deploy.s.sol:Deploy
contract Deploy is Script {
    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        require(pk != 0, "PRIVATE_KEY required");

        vm.startBroadcast(pk);

        // Deploy ProxyAdmin
        ProxyAdmin admin = new ProxyAdmin(msg.sender);
        console2.log("ProxyAdmin", address(admin));

        // Deploy implementation with version number (tests constructor arg verification)
        Counter implementation = new Counter(1);
        console2.log("Counter_Implementation", address(implementation));

        // Deploy TransparentUpgradeableProxy with initializer call
        uint256 initialNumber = 42;
        bytes memory initData = abi.encodeCall(Counter.initialize, (initialNumber));
        TransparentUpgradeableProxy proxy =
            new TransparentUpgradeableProxy(address(implementation), address(admin), initData);
        console2.log("Counter_Proxy", address(proxy));

        // Verify initializer was called correctly
        Counter proxiedCounter = Counter(address(proxy));
        console2.log("Counter_Proxy.number()", proxiedCounter.number());
        require(proxiedCounter.number() == initialNumber, "Initializer did not set number correctly");

        vm.stopBroadcast();
    }
}
