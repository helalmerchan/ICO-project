// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contracts/TokenICO.sol
interface ERC20{
    function transfer(address recipient, uint256 amount) external returns(bool);
    function balanceOf(address account) external view returns(uint256);
    function allowance(address owner, address spender) external view returns(uint256);
    function approve(address spender, uint256 amount) external returns(bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns(bool);
    function symbol() external view returns(string memory);
    function totalSupply() external view returns(uint256);
    function name() external view returns(string memory);
}

contract TokenICO{
    address public owner;
    address public tokenAddress;
    uint256 public tokenSalePrice;
    uint256 public soldToken;

    modifier onlyOwner(){
        require(msg.sender == owner, "Only contract owner can perform this Action");
        _;
    }

    constructor(){
        owner = msg.sender;
    } 

    function updateToken(address _tokenAddress) public onlyOwner{ 
        tokenAddress = _tokenAddress;
    }

    function updateTokenSalePrice(uint256 _tokenSalePrice) public onlyOwner{
        tokenSalePrice = _tokenSalePrice;
    }

    function multiply(uint256 x, uint256 y) internal pure returns(uint256 z){
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyToken(uint256 _tokenAmount) public payable{
        require(msg.value == multiply(_tokenAmount, tokenSalePrice), "Insufficient ETH for the token purchase");

        ERC20 token = ERC20(tokenAddress);
        require(_tokenAmount <= token.balanceOf(address(this)), "Not enough token left for sale");

        require(token.transfer(msg.sender, _tokenAmount * 1e18));
    }

    function getTokenDetails(){}

    function transferToOwner(){}

    function transferEther(){}

    function withdrawAllToken(){}

}