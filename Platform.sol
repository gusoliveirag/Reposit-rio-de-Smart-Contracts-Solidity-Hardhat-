// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Token de Pagamento (ERC-20)
contract MyToken is ERC20, Ownable {
    constructor() ERC20("UtilityToken", "UTK") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

// Plataforma NFT (ERC-721)
contract MyNFT is ERC721URIStorage, Ownable {
    IERC20 public paymentToken;
    uint256 public price;
    uint256 private _tokenIds;

    constructor(address _tokenAddress, uint256 _initialPrice) 
        ERC721("UnyleyaNFT", "UNY") 
        Ownable(msg.sender) 
    {
        paymentToken = IERC20(_tokenAddress);
        price = _initialPrice;
    }

    function setPrice(uint256 _newPrice) public onlyOwner {
        price = _newPrice;
    }

    function mintNFT(string memory tokenURI) public returns (uint256) {
        // Validação de saldo e allowance
        require(paymentToken.balanceOf(msg.sender) >= price, "Saldo insuficiente de UTK");
        require(paymentToken.allowance(msg.sender, address(this)) >= price, "Aprove o contrato primeiro");

        // Transferência do pagamento (ERC-20) para o dono do contrato
        paymentToken.transferFrom(msg.sender, owner(), price);

        // Cunhagem do NFT (ERC-721)
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
