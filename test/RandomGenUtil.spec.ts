import { RandomGenMockInstance } from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const RandomGenMock = artifacts.require("RandomGenMock");

contract('RandomGenUtil', (accounts) => {
  let randomGenMockInstance: RandomGenMockInstance

  beforeEach(async function () {
    randomGenMockInstance = await RandomGenMock.new();
  });

  it('randomGen', async () => {
    const result = await randomGenMockInstance.randomGen(6245627, 1000)
    // console.log(result.toString())
    assert.equal(result.toNumber() < 1000, true);
  });
});
