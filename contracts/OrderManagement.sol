// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OrderManagement {
    struct Order {
        string productId;
        string userId;
        string status;
        string sellerId;
    }

    mapping(string => Order) orders;
    mapping(address => bool) public admins;

    modifier onlyAdmin() {
        require(admins[msg.sender], "Only an admin can call this function.");
        _;
    }

    constructor() {
        admins[msg.sender] = true;
    }

    function addAdmin(address _admin) public onlyAdmin {
        admins[_admin] = true;
    }

    function removeAdmin(address _admin) public onlyAdmin {
        admins[_admin] = false;
    }

    function pushOrder(
        string memory _orderId,
        string memory _productId,
        string memory _userId,
        string memory _status,
        string memory _sellerId
    ) public onlyAdmin {
        orders[_orderId] = Order(_productId, _userId, _status, _sellerId);
    }

    function getOrder(string memory _orderId)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        Order memory order = orders[_orderId];
        return (order.productId, order.userId, order.status, order.sellerId);
    }

    function updateOrderStatus(string memory _orderId, string memory _newStatus)
        public
        onlyAdmin
    {
        Order storage order = orders[_orderId];
        order.status = _newStatus;
    }
}
