// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DisarliWorldToken is ERC20, Ownable {
    uint256 public constant INITIAL_SUPPLY = 21_000_000 * 10 ** 18;
    uint256 public constant MAX_SUPPLY = 50_000_000 * 10 ** 18;

    address public bridge;

    modifier onlyBridge() {
        require(msg.sender == bridge, "Not authorized");
        _;
    }

    constructor() ERC20("DisarliWorldToken", "DSWT") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function setBridge(address _bridge) external onlyOwner {
        bridge = _bridge;
    }

    function mint(address to, uint256 amount) external onlyBridge {
        require(totalSupply() + amount <= MAX_SUPPLY, "Max supply exceeded");
        _mint(to, amount);
    }
}
