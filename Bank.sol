// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Bank{

    address owner;
    
    constructor (){
        owner=msg.sender;
    }

    struct Customer{
        uint balance;
        address accountNO;
        string name;
        uint dob;
        uint mobNo;
        bool status;
    }

    mapping (address => Customer) customers;

    function createBankAcc(string memory _name, uint _mobNo) public payable{
        require(msg.value>=1 && customers[msg.sender].status!=true,"INSUUFICIENT FUND");
        customers[msg.sender] = Customer(msg.value-1, msg.sender, _name, block.timestamp, _mobNo, true);
    }

    function chkDetails(address _accNo) public view returns (Customer memory ) {
        require(msg.sender == owner || customers[_accNo].accountNO == msg.sender, "NOT AURTHORISED" );
        return customers[_accNo];
    }

    function deposit(address _toAddress) public payable{
        require(msg.value>1 ether || customers[_toAddress].balance >= 1, "Minimum deposit amount should be greater than 1 ether");
        customers[_toAddress].balance=customers[_toAddress].balance + msg.value;
    }

    function transfer(address _trAddress) public payable{
        require(customers[msg.sender].balance>=msg.value,"NOT ENOUGH BALANCE");
        customers[msg.sender].balance = customers[msg.sender].balance-msg.value;
        customers[_trAddress].balance = customers[_trAddress].balance + msg.value;
    }



}