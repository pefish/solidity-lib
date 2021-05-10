import {TestMockInstance} from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const TestMock = artifacts.require("TestMock");

contract('TestMock', (accounts) => {
  let testMockInstance: TestMockInstance

  beforeEach(async function () {
    testMockInstance = await TestMock.new();
  });

  it('testDiv', async () => {
    const result = await testMockInstance.testDiv()
    assert.equal(result.toString(), "3");
  });
});
