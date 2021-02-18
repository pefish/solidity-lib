import { StringMockInstance } from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const StringMock = artifacts.require("StringMock");

contract('String', (accounts) => {
  let stringMockInstance: StringMockInstance

  beforeEach(async function () {
    stringMockInstance = await StringMock.new();
  });

  it('toString', async () => {
    assert.equal(await stringMockInstance.uint256ToString(3452), "3452", "toString error");
    assert.equal(await stringMockInstance.uint256ToString(0), "0", "toString error");
    assert.equal(await stringMockInstance.uint256ToString(73567372), "73567372", "toString error");
  });

  it('isEqual', async () => {
    assert.equal(await stringMockInstance.isEqual("4", "6567"), false, "isEqual error");
    assert.equal(await stringMockInstance.isEqual("78", "-3"), false, "isEqual error");
    assert.equal(await stringMockInstance.isEqual("6547", "6547"), true, "isEqual error");
  });
});
