// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NashNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;
    /**
    @dev _baseTokenURI for computing {tokenURI}. If set the resulting URI 
    for each token will be the concatenation of the baseURI and the tokenId
     */
     string _baseTokenURI;

     //_price is the price of one NashNFT
     uint256 public _price = 0.001 ether;

     //_paused is used to pause the contract when theirs an emergency
     bool public _paused;

     //max number of NashNFT 
     uint256 public maxTokenIds = 100;

     //total number of tokenIds minted
     uint256 public tokenIdsMinted;

     //modifier - by default booleans have a value of false, 
     //thus !_paused(not paused==false or not false) 
     modifier onlyWhenNotPaused {
        require(!_paused, "Contract currently paused");
        _;
     }

     /**
     @dev ERC721 constructor takes in a 'name' and a symbol to the token collection
     constructor for our NashNFT takes in the baseURI to set _baseTokenURI for the collection

    */
    constructor(string memory baseURI) ERC721("NashNFT", "NNFT"){
        _baseTokenURI = baseURI;
    }

    /**
    @dev mint allows a user to mint 1 NFT per transaction
     */
     function mint() public payable onlyWhenNotPaused {
        require(tokenIdsMinted < maxTokenIds, "Exceeded maximum NashNFT supply");
        require(msg.value >= _price, "Ether sent is not correct");
        tokenIdsMinted += 1;
        _safeMint(msg.sender, tokenIdsMinted);
     }

     /**
     @dev setpaused does the pause unpause thing
      */
      function setPaused(bool val) public onlyOwner {
        _paused = val;
      }

     /**
     @dev withdraw sends all the ether in the contract to owner 
      */  
      function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
      }

      // Function to recieve Ether. msg.data must be empty
      receive() external payable {}

      //Fallback function is called when msg.data is not empty
      fallback() external payable {}
}