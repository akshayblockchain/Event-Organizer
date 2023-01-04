// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EventOrganizer {
    struct Event {
        uint256 id;
        address organizer;
        string name;
        uint256 date;
        uint256 price;
        uint256 ticketRemaining;
    }
    uint256 public nextId;
    mapping(uint256 => Event) public events;
    mapping(address => mapping(uint256 => uint256)) public tickets;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function createEvent(
        string memory name,
        uint256 date,
        uint256 price,
        uint256 ticketCount
    ) external {
        require(date > block.timestamp, "To create event Future Date require");
        require(price > 0, "Price should be greater then 0");
        require(ticketCount > 0, "ticket Count should be greater the 0");
        events[nextId] = Event(
            nextId,
            msg.sender,
            name,
            date,
            price,
            ticketCount
        );
        nextId++;
    }

    function buyTicket(uint256 id, uint256 ticketQuantity) external payable {
        require(events[id].date != 0, "No such event Present");
        require(events[id].date > block.timestamp, "Event already Done");
        require(
            events[id].ticketRemaining >= ticketQuantity,
            "Not Enough Ticket"
        );
        require(
            msg.value == (events[id].price * ticketQuantity),
            "Less Ether to buy Ticket"
        );
        events[id].ticketRemaining -= ticketQuantity;
        tickets[msg.sender][id] += ticketQuantity;
        payable(events[id].organizer).transfer(msg.value - (msg.value / 10)); // Event Contract commission 10%
    }

    function transferTicket(
        address to,
        uint256 id,
        uint256 quantity
    ) external {
        require(events[id].date != 0, "Event does not exist");
        require(events[id].date > block.timestamp, "Event already Done");
        require(
            tickets[msg.sender][id] >= quantity,
            "You dont have Enough Ticket to transfer"
        );
        tickets[msg.sender][id] -= quantity;
        tickets[to][id] += quantity;
    }

    function withdrawFund() public {
        require(msg.sender == owner, "Only Owner Allowed");
        payable(owner).transfer(address(this).balance);
    }
}
