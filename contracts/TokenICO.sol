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

        payable(owner).transfer(msg.value);

        soldToken += _tokenAmount;
    }

    function getTokenDetails() public view returns( string memory name, string memory symbol ,uint256 balance, uint256 supply, uint256 tokenPrice, address tokenAddr){
        ERC20 token = ERC20(tokenAddress);
        return(
            token.name(),
            token.symbol(),
            token.balanceOf(address(this)),
            token.totalSupply(),
            tokenSalePrice,
            tokenAddress
        );
    }

    function transferToOwner(uint256 _amount) external payable{
        require(msg.value >= _amount, "Insufficient fund for the transfer");

        (bool success, ) =  owner.call{value: _amount}("");

        require(success, "Transfer failed");
    }

    function transferEther(address payable _receiver, uint256 _amount) external payable{
        require(msg.value >= _amount, "Insufficient fund for the transfer");

        (bool success, ) =  _receiver.call{value: _amount}("");

        require(success, "Transfer failed");
    }

    function withdrawAllToken() public onlyOwner{
        ERC20 token = ERC20(tokenAddress);
        uint256 balance = token.balanceOf(address(this));

        require(balance > 0, "No token to withdraw");
        
        require(token.transfer(owner, balance), "Transfer failed!");
    }

}