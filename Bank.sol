// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.2 <0.9.0;

contract Bank{
    address owner;
    constructor(){
        owner = payable(msg.sender);
    }

    struct Details{
        string name;
        uint256 balance;
        address payable owner;
    }
    mapping (address => Details) private addressToDetails;

    function register(string memory _name )public{
        addressToDetails[msg.sender] = Details(
            
            _name,
            0,
            payable(msg.sender)

        );

    }
    function checkDetails()public view checkOwner() returns(Details memory) {
        return addressToDetails[msg.sender];
    }
      modifier checkOwner{
        require(addressToDetails[msg.sender].owner == msg.sender , "User Doesnt exist");
        _;
    }
    function checkBalance()public view checkOwner()  returns (uint256){
        return addressToDetails[msg.sender].balance;
    }

    modifier costs (uint _amount){
        require(msg.value >= _amount , "this is tooo little to deposit ,  wouldnt you rather keep that shii in your pocket");
        _;
    }
  
    function deposit( uint256 _price) public  checkOwner(){
        addressToDetails[msg.sender].balance+=_price;
    }

}