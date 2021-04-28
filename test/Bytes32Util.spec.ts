import {Bytes32MockInstance} from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const Bytes32Mock = artifacts.require("Bytes32Mock");

contract('Bytes32Util', (accounts) => {
  let bytes32MockInstance: Bytes32MockInstance

  beforeEach(async function () {
    bytes32MockInstance = await Bytes32Mock.new();
  });

  it('testToHexString', async () => {
    assert.equal(await bytes32MockInstance.testToHexString("0x1234"), "1234000000000000000000000000000000000000000000000000000000000000");
  });
});
