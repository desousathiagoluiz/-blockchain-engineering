// ICO hadcoins

// Version
pragma solidity ^0.4.11;

contract hadcoin_ico {
    // Maximum number of hadcoins available in ICO
    uint public max_hadcoins = 1000000;

    // Exchange rate of Hadcoins to USD
    uint public usd_to_hadcoins = 1000;

    // Total hadcoins that were purchased by investors
    uint public total_hadcoins_bought = 0;

    // Equivalence Functions
    mapping(address => uint) equity_hadcoins;
    mapping(address => uint) equity_usd;

    // Checking if more Hadcoin ICOs can be purchased
    modifier can_buy_hadcoins(uint usd_invested) {
        require (usd_invested * usd_to_hadcoins + total_hadcoins_bought <= max_hadcoins);
        _;
    }

    // Returns the amount invested in hadcoins
    function equity_in_hadcoins(address investor) external constant returns (uint){
        return equity_hadcoins[investor];
    }

    // Returns the amount invested in USD
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }

    // Buy of Hadcoins
    function buy_hadcoins(address investor, uint usd_invested) external 
    can_buy_hadcoins(usd_invested) {
        uint hadcoins_bought = usd_invested * usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoins_bought;
        equity_usd[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought += hadcoins_bought;
    }

    // Sale of Hadcoins
    function sell_hadcoins(address investor, uint hadcoins_sold) external {
        equity_hadcoins[investor] -= hadcoins_sold;
        equity_usd[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought -= hadcoins_sold;
    }
    
}

