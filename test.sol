// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HexToBytes32 {
    bytes32 private _secret;
    event Log(address sender, string message);
    constructor() {
        bytes32 _s;
        assembly { _s := 0x7465737490aa7465737490aa }
        _secret = _s;
    }

    function convert() public returns (bool) {
        bytes32 result;
        bool r;
        //assembly { result := 0x7465737490aa7465737490aa }
        result = 0x00000000000000000000000000000000000000007465737490aa7465737490aa;
        r = changeOwner(result);
        emit Log(msg.sender, string(abi.encodePacked("Covert() ...")));
        return r;
    }
    function changeOwner(bytes32 secret) public returns (bool) {
        require(_secret == secret);
        if(bytes16(_secret) == bytes16(secret)) {
            emit Log(msg.sender, "[+] Success." );
            return true;
        } else {
            emit Log(msg.sender, "[-] " );
            return false;
        }
    }

}