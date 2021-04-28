import {BytesMockInstance} from "../types/truffle-contracts";
import Web3 from "web3"
import {EthWallet} from "@pefish/js-coin-eth";
import {StringUtil} from "@pefish/js-node-assist";

declare var web3: Web3;

const BytesMock = artifacts.require("BytesMock");

contract('BytesUtil', (accounts) => {
  let bytesMockInstance: BytesMockInstance

  beforeEach(async function () {
    bytesMockInstance = await BytesMock.new();
  });

  it('testRecover', async () => {
    const wallet = new EthWallet()
    const msg = "test"
    const signature = wallet.signMessage("0x492191028c8fd5b4942a4edc004c76dd7427df1a9a33db2632135ab5011ed63b", msg)
    const vrs = wallet.decodeSignature(signature)
    assert.equal(await bytesMockInstance.testRecover(msg, vrs.v, vrs.r, vrs.s), "0xC3B6064Cb543ef68d0F3314d85f6f89525cEDf8F", "toString error");
  });

  it('testToHexString', async () => {
    assert.equal(await bytesMockInstance.testToHexString("0x1234"), "1234000000000000000000000000000000000000000000000000000000000000");
  });
});
