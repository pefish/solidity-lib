import { StringMockInstance } from "../types/truffle-contracts";
import Web3 from "web3"
import {EthWallet} from "@pefish/js-coin-eth";

declare var web3: Web3;

const StringMock = artifacts.require("StringMock");

contract('String', (accounts) => {
  let stringMockInstance: StringMockInstance

  beforeEach(async function () {
    stringMockInstance = await StringMock.new();
  });

  it('isEqual', async () => {
    assert.equal(await stringMockInstance.isEqual("4", "6567"), false, "isEqual error");
    assert.equal(await stringMockInstance.isEqual("78", "-3"), false, "isEqual error");
    assert.equal(await stringMockInstance.isEqual("6547", "6547"), true, "isEqual error");
  });

  it('testAppend', async () => {
    assert.equal(await stringMockInstance.testAppend("4", "6567"), "46567");
  });

  it('testRecover', async () => {
    const wallet = new EthWallet()
    const msg = "test"
    const signature = wallet.signMessage("0x492191028c8fd5b4942a4edc004c76dd7427df1a9a33db2632135ab5011ed63b", msg)
    const vrs = wallet.decodeSignature(signature)
    assert.equal(await stringMockInstance.testRecover(msg, vrs.v, vrs.r, vrs.s), "0xC3B6064Cb543ef68d0F3314d85f6f89525cEDf8F", "toString error");
  });
});
