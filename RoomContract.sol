//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract RoomBooking {
    enum Statuses {
        Vacant,
        Occupied
    }

    event Occupy(address _occupant, uint _value);

    Statuses public currentStatus;
    address payable owner;


    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhenVacant {
        require(currentStatus == Statuses.Vacant, "Room occupied");
        _;
    }

    modifier costs(uint amount) {
        require(msg.value >= amount, "not enough funds");
        _;
    }


    function book() public payable onlyWhenVacant costs(2 ether) {

        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
       //(bool sent, bytes memory data) = owner.call{value: msg.value}("");

       emit Occupy(msg.sender, msg.value);

    }


}