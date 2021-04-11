import {Erc20TokenWithMintInstance} from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const Erc20TokenWithMintMock = artifacts.require("Erc20TokenWithMintMock");

contract('Erc20TokenWithMint', (accounts) => {
  let erc20TokenWithMintMockInstance: Erc20TokenWithMintInstance

  beforeEach(async function () {
    erc20TokenWithMintMockInstance = await Erc20TokenWithMintMock.new("10000000000000", "ABC", "ABC", 18);
  });

  it('balanceOf', async () => {
    const balance = await erc20TokenWithMintMockInstance.balanceOf(accounts[0])
    assert.equal(balance.toString(), "10000000000000");
  });

  it('mint', async () => {
    await erc20TokenWithMintMockInstance.mint(accounts[0], "10000000000000")
    const balance = await erc20TokenWithMintMockInstance.balanceOf(accounts[0])
    assert.equal(balance.toString(), "20000000000000");
  });
});
