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
     Details[] public detailed;
    mapping (address => Details) private addressToDetails;
    uint256 newBalance = addressToDetails[msg.sender].balance;
   


    function register(string memory _name )public{
        addressToDetails[msg.sender] = Details(
            
            _name,
            0,
            payable(msg.sender)

        );
        detailed.push(Details(
            
            _name,
            0,
            payable(msg.sender)
            
            ));

    }
    function getDetails()public view returns(Details[] memory){
        return detailed;
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
  
    receive() external payable  checkOwner() costs(0.001 ether){
        addressToDetails[msg.sender].balance+=msg.value;
    }

}