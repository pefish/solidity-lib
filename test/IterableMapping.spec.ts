import { IterableMappingMockInstance } from "../types/truffle-contracts";

const IterableMappingMock = artifacts.require("IterableMappingMock");

contract('IterableMapping', (accounts) => {
  let iterableMappingMockInstance: IterableMappingMockInstance

  beforeEach(async function () {
    iterableMappingMockInstance = await IterableMappingMock.new();
  });

  it('insert and sum', async () => {
    await iterableMappingMockInstance.insert(0, 2)
    await iterableMappingMockInstance.insert(1, 3)
    await iterableMappingMockInstance.insert(4, 4)
    assert.equal((await iterableMappingMockInstance.get(0)).toString(), "2", "insert error");
    assert.equal((await iterableMappingMockInstance.get(1)).toString(), "3", "insert error");
    assert.equal((await iterableMappingMockInstance.get(4)).toString(), "4", "insert error");
    assert.equal((await iterableMappingMockInstance.sum()).toString(), "9", "insert error");
  });
});
