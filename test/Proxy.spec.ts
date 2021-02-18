import { ProxyInstance } from "../types/truffle-contracts";
import Web3 from "web3"

declare var web3: Web3;

const Proxy = artifacts.require("ProxyMock");
const ProxyTest = artifacts.require("ProxyTestMock");

contract('Proxy', (accounts) => {
  let proxyInstance: ProxyInstance

  beforeEach(async function () {
    const testInstance = await ProxyTest.new()
    proxyInstance = await Proxy.new(testInstance.address);
  });


  it('storeWords getWords', async () => {
    let upgradeabilityProxyContract = new web3.eth.Contract(ProxyTest.abi, proxyInstance.address)

    await upgradeabilityProxyContract.methods["storeWords"](123).send({
      from: accounts[0],
      gas: 3000000,
    })
    const result1 = await upgradeabilityProxyContract.methods["getWords"]().call()
    // console.log(result1)
    assert.equal(result1, 123, "getWords error");
  });

  it('send eth', async () => {
    await proxyInstance["send"](1)
    const balance = await web3.eth.getBalance(proxyInstance.address)
    assert.equal(balance, "1", "balance error");
  });
});
