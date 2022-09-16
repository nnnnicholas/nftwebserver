// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "solmate/tokens/ERC721.sol";
import "openzeppelin/contracts/utils/Strings.sol";
import "brechtpd/base64/Base64.sol";

contract Contract is ERC721{
    using Strings for uint256;
    
    uint256 totalSupply;
    string html1 = '<!DOCTYPE html> <html lang="en"> <head> <meta charset="UTF-8" /> <meta name="viewport" content="width=device-width, initial-scale=1.0" /> <meta http-equiv="X-UA-Compatible" content="ie=edge" /> <script type="module"> import { ethers } from "https://cdn-cors.ethers.io/lib/ethers-5.5.4.esm.min.js"; window.addEventListener("load", function () { (async () => { let contractAddress = "';
    string html2 = '"; let provider; if (window.ethereum) { console.log("detected"); provider = new ethers.providers.Web3Provider( window.ethereum, "any" ); } else { console.log("not detected"); provider = new ethers.providers.JsonRpcProvider( "https://cloudflare-eth.com/" ); } try { const accounts = await window.ethereum.request({ method: "eth_requestAccounts", }); console.log(accounts); let connectedWallet = (document.querySelector( "#connectedWallet" ).innerHTML = accounts); } catch (error) { console.log("error connecting"); } try { let tx = await provider.call({ to: contractAddress, data: "0x1249c58b", }); console.log(tx); } catch (error) { console.log("error connecting"); } try { let tx = await provider.call({ to: "0x4976fb03C32e5B8cfe2b6cCB31c09Ba78EBaBa41", data: "0x3b3b57debf074faa138b72c65adbdcfb329847e4f2c04bde7f7dd7fcad5a52d2f395a558", }); console.log(tx); } catch (error) { console.log("error connecting"); } let output = await provider.getBlockNumber(); let div = (document.querySelector("#number").innerHTML = output); })(); }); </script> <title>Website</title> </head> <body> <div id="connectedWallet">No wallet detected.</div> <div> <input type="button" value="mint" /> </div> </body> <style> body { display: flex; flex-flow: column nowrap; align-items: center; } body > div { padding: 14px; } </style> </html>';
    constructor(string memory _name, string memory _symbol) ERC721(_name,_symbol) {}

    function mint() external {
        _mint(msg.sender, totalSupply++);
    }

    function tokenURI(uint256) public view override returns (string memory) {
        string memory html = string(abi.encodePacked(html1, Strings.toHexString(address(this)) , html2));
        string memory website=  string(abi.encodePacked("data:text/html;base64,", Base64.encode(bytes(html)))); // HTML to base64
        string memory json = Base64.encode(bytes(string(abi.encodePacked(    '{"name": "NFT Webserver", "description": "This NFT serves an html page that can be used to mint more tokens from this collection.", "image": "',website,'"}')))); // JSON concatenation, to base64
        json = string(abi.encodePacked('data:application/json;base64,', json)); // prefix json with base64
        return json;
    }    
}