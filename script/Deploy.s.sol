// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Counter} from "../src/Counter.sol";
import {CounterBasic} from "../src/CounterBasic.sol";

/// @title Deploy
/// @notice Canonical deployment script for CI/CD pipelines
/// @dev Entry point: script/Deploy.s.sol:Deploy
contract Deploy is Script {
    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        require(pk != 0, "PRIVATE_KEY required");

        vm.startBroadcast(pk);

        uint256 initialNumber = 42;

        // Deploy shared ProxyAdmin
        ProxyAdmin admin = new ProxyAdmin(msg.sender);
        console2.log("ProxyAdmin", address(admin));

        // Deploy Counter (ERC-7201 namespaced storage)
        Counter counterImplementation = new Counter();
        console2.log("Counter Implementation", address(counterImplementation));

        bytes memory counterInitData = abi.encodeCall(Counter.initialize, (initialNumber));
        TransparentUpgradeableProxy counterProxy =
            new TransparentUpgradeableProxy(address(counterImplementation), address(admin), counterInitData);
        console2.log("Counter Proxy", address(counterProxy));

        Counter proxiedCounter = Counter(address(counterProxy));
        console2.log("Counter.number()", proxiedCounter.number());
        require(proxiedCounter.number() == initialNumber, "Counter initializer did not set number correctly");

        // Deploy CounterBasic (traditional storage layout)
        CounterBasic counterBasicImplementation = new CounterBasic();
        console2.log("CounterBasic Implementation", address(counterBasicImplementation));

        bytes memory counterBasicInitData = abi.encodeCall(CounterBasic.initialize, (initialNumber));
        TransparentUpgradeableProxy counterBasicProxy =
            new TransparentUpgradeableProxy(address(counterBasicImplementation), address(admin), counterBasicInitData);
        console2.log("CounterBasic Proxy", address(counterBasicProxy));

        CounterBasic proxiedCounterBasic = CounterBasic(address(counterBasicProxy));
        console2.log("CounterBasic.number()", proxiedCounterBasic.number());
        require(proxiedCounterBasic.number() == initialNumber, "CounterBasic initializer did not set number correctly");

        vm.stopBroadcast();
    }
}
