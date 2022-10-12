// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Login {
    //private variables 
    //Each bytes32 variable would occupy one slot
    //beacause bytes32 variable has 256 bits which is the size of the slot

    //slot 0
    bytes32 private username;

    //slot 1
    bytes32 private password;

    constructor(bytes32 _username, bytes32 _password) {
        username = _username;
        password = _password;
    }
}