import {Erc20TokenMockInstance} from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const Erc20TokenMock = artifacts.require("Erc20TokenMock");

contract('Erc20Token', (accounts) => {
  let erc20TokenMockInstance: Erc20TokenMockInstance

  beforeEach(async function () {
    erc20TokenMockInstance = await Erc20TokenMock.new("10000000000000", "ABC", "ABC", 18);
  });

  it('balanceOf', async () => {
    const balance = await erc20TokenMockInstance.balanceOf(accounts[0])
    assert.equal(balance.toString(), "10000000000000");
  });
});
