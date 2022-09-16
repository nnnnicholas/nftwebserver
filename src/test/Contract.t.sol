// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "brechtpd/base64/Base64.sol";
import "../Contract.sol";
import "./console.sol";


contract ContractTest is DSTest {
    Contract c;

    function setUp() public {
        c = new Contract("nft web server", "NFTWEB");
    }

    function testMint() public {
        c.mint();
    }

    function testTokenURI() public {
        testMint();
        //generate tokenuri
        string
            memory html1 = "<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0' /><meta http-equiv='X-UA-Compatible' content='ie=edge' /><script type='module'> import { ethers } from 'https://cdn-cors.ethers.io/lib/ethers-5.5.4.esm.min.js'; (async () => { let contractAddress = '";
        string
            memory html2 = "';let provider; if (window.ethereum) { console.log('detected'); provider = new ethers.providers.Web3Provider(window.ethereum, 'any'); } else { console.log('not detected'); provider = new ethers.providers.JsonRpcProvider('https://cloudflare-eth.com/'); } try{ const accounts = await window.ethereum.request({ method: 'eth_requestAccounts', }); console.log(accounts); let connectedWallet = document.querySelector('#connectedWallet').innerHTML=accounts; } catch(error){ console.log('error connecting') } try{ let tx = await provider.call({ // ENS public resolver address to: '0x4976fb03C32e5B8cfe2b6cCB31c09Ba78EBaBa41', // `function addr(namehash('ricmoo.eth')) view returns (address)` data: '0x3b3b57debf074faa138b72c65adbdcfb329847e4f2c04bde7f7dd7fcad5a52d2f395a558' }); console.log(tx); // provider.sendTransaction({ // to: 'nnnnicholas.eth', // method:'', // params:'', // value: ethers.utils.parseEther('0.01') // }) }catch(error){ console.log('error connecting'); } let output = await provider.getBlockNumber(); let div = document.querySelector('#number').innerHTML = output; // const signer = provider.getSigner(); // const tx = signer.sendTransaction({ // to: 'nnnnicholas.eth', // value: ethers.utils.parseEther('0.01') // }); })(); </script><title>Website</title></head><body><div></div><div id='connectedWallet'>No wallet detected.</div><div><input type='button' value='mint'></input></div></body><style>body{display:flex;flex-flow:column nowrap;align-items:center}body>div{padding:14px}</style></html>";
        string memory html = string(abi.encodePacked(html1, address(c), html2));
        string memory website = string(
            abi.encodePacked(
                "data:text/html;base64,",
                Base64.encode(bytes(html))
            )
        ); // HTML to base64
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "NFT Webserver", "description": "This NFT serves an html page that can be used to mint more tokens from this collection.", "image": "',
                        website,
                        '"}'
                    )
                )
            )
        ); // JSON concatenation, to base64
        json = string(abi.encodePacked("data:application/json;base64,", json)); // prefix json with base64
        console.log(c.tokenURI(0));
        assertEq(c.tokenURI(0), json);
    }
}
