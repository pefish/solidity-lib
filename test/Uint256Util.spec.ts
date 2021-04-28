import {Uint256MockInstance} from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const Uint256Mock = artifacts.require("Uint256Mock");

contract('Uint256Util', (accounts) => {
  let uint256MockInstance: Uint256MockInstance

  beforeEach(async function () {
    uint256MockInstance = await Uint256Mock.new();
  });

  it('testToString', async () => {
    assert.equal(await uint256MockInstance.testToString(3452), "3452", "toString error");
    assert.equal(await uint256MockInstance.testToString(0), "0", "toString error");
    assert.equal(await uint256MockInstance.testToString(73567372), "73567372", "toString error");
  });
});
