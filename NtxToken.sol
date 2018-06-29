pragma solidity ^0.4.23;

import "./Zeppelin/token/ERC20/StandardToken.sol";
import "./Zeppelin/ownership/Ownable.sol";

contract NTX_Token is Ownable, StandardToken {
    string public name = "Nakamotox Coin";
    string public symbol = "NTX";
    uint8 public decimals = 18;

    constructor() public Ownable() StandardToken() {
        totalSupply_ = 210 * 10**6 * 10**18;
        balances[msg.sender] = totalSupply_;
    }

    event Burn(address indexed burner, uint256 value);

    function burn(uint256 _value) public onlyOwner {
        _burn(msg.sender, _value);
    }

    function _burn(address _who, uint256 _value) internal {
        require(_value <= balances[_who]);

        balances[_who] = balances[_who].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);

        emit Burn(_who, _value);
        emit Transfer(_who, address(0), _value);
    }
}
