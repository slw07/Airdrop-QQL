//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import { QqlToken } from "./QqlToken.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Fault {
    mapping(address account => uint256) records;   //记录账号数量
    mapping(address account => uint256) lastClaimTime;  //记录上次领水时间
    uint256 public constant CLAIM_INTERVAL = 24 * 60 * 60;  //领水间隔
    uint256 private constant DROPAMOUNT = 1 * 10 ** 17;
    QqlToken public qqlToken;

    constructor(address _token) {
        qqlToken = QqlToken(_token);
    }

    function dropWallet() external {
        _drop(msg.sender);
    }

    function dropAccount(address account) external {
        require(account != address(0), "Zero address");
        _drop(account);
    }

    function _drop(address account) internal {
        require(block.timestamp >= lastClaimTime[account] + CLAIM_INTERVAL, "Faucet: 24 hours not passed");
        require(qqlToken.balanceOf(address(this)) > DROPAMOUNT, "drop out");
        lastClaimTime[account] = block.timestamp;
        bool success = qqlToken.transfer(account, DROPAMOUNT);
        if (success) {
            records[account] += DROPAMOUNT;
        } else {
            revert("Transfer failed");
        }
    }
}