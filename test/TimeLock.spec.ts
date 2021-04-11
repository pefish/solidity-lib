import {Erc20TokenWithMintInstance, TimeLockInstance} from "../types/truffle-contracts";
import Web3 from "web3"
import {NumberUtil} from "@pefish/js-node-assist";
import { EthWallet } from "@pefish/js-coin-eth"
import TimeUtil from "@pefish/js-util-time"

declare var web3: Web3;

const TimeLockMock = artifacts.require("TimeLockMock");
const Erc20TokenWithMintMock = artifacts.require("Erc20TokenWithMintMock");

contract('TimeLock', (accounts) => {
  let timeLockMockInstance: TimeLockInstance

  beforeEach(async function () {
    timeLockMockInstance = await TimeLockMock.new(accounts[0], 5);
  });

  it('executeTransaction', async () => {
    // 初始化一个 Erc20TokenWithMint
    const erc20TokenWithMintMockInstance: Erc20TokenWithMintInstance = await Erc20TokenWithMintMock.new("10000000000000", "ABC", "ABC", 18);
    // 更改 owner 为 timelock
    await erc20TokenWithMintMockInstance.transferOwnership(timeLockMockInstance.address)
    const newOwner = await erc20TokenWithMintMockInstance.owner()
    assert.equal(newOwner, timeLockMockInstance.address);
    // timelock 发起 mint
    const wallet = new EthWallet()
    const calldata = wallet.encodePayload(
        wallet.getMethodIdV1("mint(address,uint256)"),
        ["address", "uint256"],
        [accounts[0], "10000000000000"]
    )
    const eta = NumberUtil.toInt(Date.now() / 1000) + 7
    const queueTransactionResult = await timeLockMockInstance.queueTransaction(
        erc20TokenWithMintMockInstance.address,
        0,
        "",
        calldata,
        eta
    )
    const queuedTxHash = queueTransactionResult.logs[0].args.txHash
    const queued = await timeLockMockInstance.queuedTransactions(queuedTxHash)
    assert.equal(queued, true);
    // 立马执行 mint，应该报错
    try {
      await timeLockMockInstance.executeTransaction(
          erc20TokenWithMintMockInstance.address,
          0,
          "",
          calldata,
          eta
      )
    } catch (err) {
      assert.equal(err.message.includes("Transaction hasn't surpassed time lock"), true)
    }
    // 等待 10 s
    await TimeUtil.sleep(10000)

    // 再次执行，应该正常
    await timeLockMockInstance.executeTransaction(
        erc20TokenWithMintMockInstance.address,
        0,
        "",
        calldata,
        eta
    )

    // 校验 balance
    const balance = await erc20TokenWithMintMockInstance.balanceOf(accounts[0])
    assert.equal(balance.toString(), "20000000000000")
  });
});
