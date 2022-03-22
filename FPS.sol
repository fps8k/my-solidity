// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;

import "./IERC20.sol";

/*
* @title: 
*        FPS, an ERC-20 standard token.
* @author: Anthony (fps).
* @date: 21/03/2022.
*
* @notice: This token, FPS, obeys the standard of the ERC-20, created as my debut token.
* Also, currently, I do not seem to understand the concept of the allowance, approve and transferFrom functions but 
* I hope Reddit comes to my aid.
*
* I M P O R T A N T :
* '{text}' => Implies text is a data type.
* `{text}` => Implies text is a variable name.
*
* T L D R :
* 'data_type'
* `variable_name`
*/

contract FPS is IERC20
{
    /*
    * @dev: Sets and allocates some tokens as `balances` to `addresses`.
    * Also creates an allowance between the 'address' {`owner`} and 'address' {`spender`} to a particular 'uint' `allowance`
    */

    mapping (address => uint) private balances;
    
    mapping (address => mapping (address => uint)) private allowance;

    /*
    * @dev: Setting a 1 million total supply of the fps token and the decimal.
    */
    uint256 private _totalSupply;
    uint8 private _decimal;
    
    /*
    * @dev: Setting token name and symbol.
    */
    string private _name;
    string private _symbol;
    address constant owner = 0x5e078E6b545cF88aBD5BB58d27488eF8BE0D2593;
    
    /*
    * @dev: Constructor
    */
    constructor()
    {
        _name = "FPS Coin";
        _symbol = "FPS";

        // total supply is 1 million plus the 3 decimal zeros
        _totalSupply = 1000000000;
        _decimal = 3;

        // address owner = msg.sender;

        // get the owner of the contract and assign to him all the funds
        // balances[msg.sender] = _totalSupply;

        // allocate all to me
        balances[owner] = _totalSupply;
    }

    /*
    * @dev: `name()` function returns the name of the token
    */
    function name() public view returns(string memory)
    {
        return _name;
    }

    
    /*
    * @dev: `symbol()` function returns the token symbol
    */
    function symbol() public view returns(string memory)
    {
        return _symbol;
    }

    
    /*
    * @dev: `decimals()` function returns the token decimals
    */
    function decimals() public view returns(uint8)
    {
        return 10;
    }

    /*
    * @notice: Implementation of functions necessary according to the ERC-20 standard.
    * Function 1:
    *
    *
    * @dev: `totalSupply()` function returns the total number of token coins in existence
    */
    function totalSupply() public view virtual override returns(uint)
    {
        return _totalSupply;
    }

    /*
    * @notice: Function 2:
    *
    * @dev: `balanceOf()` function: Returns the amount of token owned by a particular `account`
    */
    function balanceOf(address account) public view virtual override returns (uint)
    {
        return balances[account];
    }

    /*
    * @notice: Function 3:
    *
    * @dev: `transfer()` function: Transfers some token `amount` to a particular account of 'address', `to`, from the callers account
    * -- increments the `balances` of `to` by `amount`
    * -- decrements the `balances` of `msg.sender` by `amount`
    *
    * Returns a boolean that shows that it worked
    *
    * Emits a {Transfer} event
    *
    *
    * @notice: This function is controlled by a modifier `canSend()` that makes sure that the sender has enough token in his account to send
    */
    modifier canSend(address from, address to, uint amount)
    {
        require(from != address(0), "You cannot transfer from an invalid address.");

        require(to != address(0), "You cannot transfer to an invalid address.");

        require(amount != 0, "You cannot send 0 FPS.");

        require(balances[from] >= amount, "You do not have enough FPS Coins to make this transaction.");
        _;
    }

    function transfer(address to, uint amount) public view virtual override canSend(msg.sender, to, amount) returns(bool)
    {
        balances[to] += amount;
        balances[msg.sender] -= amount;
        emit Transfer(msg.sender, to, amount);

        return true;
    }

    /*
    * @notice: Function 4:
    * @dev: `approve()` Sets `amount` as the allowance of `spender` over the caller's tokens. 
    *  Emits an {Approval} event.
    *
    * This is protected by a modifier
    */
    modifier canApprove(address spender, uint amount)
    {
        require(spender != address(0), "You cannot request from an invalid address.");
        require(amount > 0, "You can't request for empty allowance.");
        require(balances[owner] > amount, "Cannot approve alowance.");
        require(allowance[owner][spender] + amount < 100, "Allowance limit reached");
        require(amount <= 100, "Allowance limit is 100.");
        _;
    }

    function approve(address spender, uint amount) public view virtual override returns(bool)
    {
        allowance[owner][spender] += amount;
        emit Approval(owner, spender, amount);
    }

    /*
    * Function 5:
    */
}