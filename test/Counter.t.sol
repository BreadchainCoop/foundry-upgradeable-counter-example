// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        ProxyAdmin admin = new ProxyAdmin(address(this));
        Counter implementation = new Counter(1);
        bytes memory initData = abi.encodeCall(Counter.initialize, (0));
        TransparentUpgradeableProxy proxy =
            new TransparentUpgradeableProxy(address(implementation), address(admin), initData);
        counter = Counter(address(proxy));
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
