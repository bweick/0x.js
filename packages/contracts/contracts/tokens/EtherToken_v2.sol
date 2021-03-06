/*

  Copyright 2017 ZeroEx Intl.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

pragma solidity 0.4.18;

import "./UnlimitedAllowanceToken_v2.sol";
import "./../utils/SafeMath_v2.sol";

contract EtherToken_v2 is UnlimitedAllowanceToken_v2, SafeMath_v2 {

    string constant public name = "Ether Token";
    string constant public symbol = "WETH";
    string constant public version = "2.0.0"; // version 1.0.0 deployed on mainnet at 0x2956356cd2a2bf3202f771f50d3d14a367b48070
    uint8 constant public decimals = 18;

    /// @dev Fallback to calling deposit when ether is sent directly to contract.
    function()
        public
        payable
    {
        deposit();
    }

    /// @dev Buys tokens with Ether, exchanging them 1:1.
    function deposit()
        public
        payable
    {
        balances[msg.sender] = safeAdd(balances[msg.sender], msg.value);
        totalSupply = safeAdd(totalSupply, msg.value);
        Transfer(address(0), msg.sender, msg.value);
    }

    /// @dev Sells tokens in exchange for Ether, exchanging them 1:1.
    /// @param _value Number of tokens to sell.
    function withdraw(uint _value)
        public
    {
        balances[msg.sender] = safeSub(balances[msg.sender], _value);
        totalSupply = safeSub(totalSupply, _value);
        require(msg.sender.send(_value));
        Transfer(msg.sender, address(0), _value);
    }
}

