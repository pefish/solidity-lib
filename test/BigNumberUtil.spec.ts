import { BigNumberMockInstance } from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const BigNumberMock = artifacts.require("BigNumberMock");

contract('BigNumberUtil', (accounts) => {
  let bigNumberMockInstance: BigNumberMockInstance

  beforeEach(async function () {
    bigNumberMockInstance = await BigNumberMock.new();
  });

  it('div', async () => {
    const result = await bigNumberMockInstance.div()
    // console.log(result.toString())
    assert.equal(result.toString(), "3333333333333333333333333333333333333", "toString error");
  });
});
