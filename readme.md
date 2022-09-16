## Goal 
Serve an onchain HTML page via `ERC721.tokenUri()` that fetches Ethers from a CDN on the client. The page should present a user with a Mint button to mint an NFT on that contract


## Good to know
the html is in `src/index.html`

its contents are copy-pasted into `Contract.sol`, which serves the page via `tokenUri(uint256)`