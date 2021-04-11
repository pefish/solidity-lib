
[Create App](https://github.com/pefish/create-app) 使用的dapp模板

* 使用Truffle框架
* Typescript支持
* SafeMath等常用库

## 依赖

* yarn global add truffle

## 构建

* yarn build

## 测试

* yarn test
* yarn test ./test/Erc20TokenWithMint.spec.ts

## 发布测试网

* INFURA_KEY=** PRIVATE_KEY=** truffle migrate --network=ropsten  // 部署测试环境

## 发布主网

* INFURA_KEY=** PRIVATE_KEY=** truffle migrate --network=mainnet
