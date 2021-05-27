import { StringMockInstance, CallAnyContractMockInstance } from "../types/truffle-contracts";
import Web3 from "web3"
import {EthWallet} from "@pefish/js-coin-eth";

declare var web3: Web3;

const StringMock = artifacts.require("StringMock");
const CallAnyContractMock = artifacts.require("CallAnyContractMock");

contract('CallAnyContract', (accounts) => {
  let stringMockInstance: StringMockInstance
  let callAnyContractMockInstance: CallAnyContractMockInstance

  beforeEach(async function () {
    stringMockInstance = await StringMock.new();
    callAnyContractMockInstance = await CallAnyContractMock.new();
  });

  it('callAnyContractView', async () => {
    const wallet = new EthWallet()
    const payload = wallet.encodePayload(wallet.getMethodIdV1("isEqual(string,string)"), ["string","string"], ["4", "6567"])
    const result = await callAnyContractMockInstance.callAnyContractView(stringMockInstance.address, payload)
    const decodedResult = wallet.decodeParamsHex(["bool"], result)
    // console.log(decodedResult)
    assert.equal(decodedResult[0], false);

    const payload1 = wallet.encodePayload(wallet.getMethodIdV1("isEqual(string,string)"), ["string","string"], ["6567", "6567"])
    const result1 = await callAnyContractMockInstance.callAnyContractView(stringMockInstance.address, payload1)
    const decodedResult1 = wallet.decodeParamsHex(["bool"], result1)
    // console.log(decodedResult1)
    assert.equal(decodedResult1[0], true);

    const payload2 = wallet.encodePayload(wallet.getMethodIdV1("testAppend(string,string)"), ["string","string"], ["6567", "6567"])
    const result2 = await callAnyContractMockInstance.callAnyContractView(stringMockInstance.address, payload2)
    const decodedResult2 = wallet.decodeParamsHex(["string"], result2)
    // console.log(decodedResult2)
    assert.equal(decodedResult2[0], "65676567");
  });
});
