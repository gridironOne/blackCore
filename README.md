# blackCore

[![LoC](https://tokei.rs/b1/github/gridironOne/blackCore)](https://github.com/gridironOne/blackCore)

This project implements an application for the Black Core chain that all the other chains in the ecosystem connect
to as a raised and open moderator for interoperability, shared security, and as a gateway to other ecosystems and
chains.

## Talk to us!

* [Twitter](https://twitter.com/gridironOne)
* [Telegram](https://t.me/gridironOneChat)
* [Discord](https://discord.com/channels/796174129077813248)

## Hardware Requirements

* **Minimal**
    * 1 GB RAM
    * 25 GB HDD
    * 1.4 GHz CPU
* **Recommended**
    * 2 GB RAM
    * 100 GB HDD
    * 2.0 GHz x2 CPU

> NOTE: SSDs have limited TBW before non-catastrophic data errors. Running a full node requires a TB+ writes per day,
> causing rapid deterioration of SSDs over HDDs of comparable quality.

## Operating System

* Linux/Windows/MacOS(x86)
* **Recommended**
    * Linux(x86_64)

## Installation Steps

> Prerequisite: go1.19.3+ required. [ref](https://golang.org/doc/install)

> Prerequisite: git. [ref](https://github.com/git/git)

> Optional requirement: GNU make. [ref](https://www.gnu.org/software/make/manual/html_node/index.html)

* Clone git repository

```shell
git clone https://github.com/gridironOne/blackCore.git
```

* Checkout release tag

```shell
git fetch --tags
git checkout [vX.X.X]
```

* Install

```shell
cd blackCore
make all
```

### Generate keys

`blackCore keys add [key_name]`

or

`blackCore keys add [key_name] --recover` to regenerate keys with
your [BIP39](https://github.com/bitcoin/bips/tree/master/bip-0039) mnemonic

### Connect to a chain and start node

* [Install](#installation-steps) blackCore application
* Initialize node

```shell
blackCore init [NODE_NAME]
```

* Replace `${HOME}/.blackCore/config/genesis.json` with the genesis file of the chain.
* Add `persistent_peers` or `seeds` in `${HOME}/.blackCore/config/config.toml`
* Start node

```shell
blackCore start
```

### Initialize a new chain and start node

* Initialize: `blackCore init [node_name] --chain-id [chain_name]`
* Add key for genesis account `blackCore keys add [genesis_key_name]`
* Add genesis account `blackCore add-genesis-account [genesis_key_name] 10000000000000000000stake`
* Create a validator at genesis `blackCore gentx [genesis_key_name] 10000000stake --chain-id [chain_name]`
* Collect genesis transactions `blackCore collect-gentxs`
* Start node `blackCore start`
* To start rest server set `enable=true` in `config/app.toml` under `[api]` and restart the chain

### Ledger Support

> NOTE: *If you are using Cosmos Ledger app*: Black uses coin-type 750; generating keys through this method below
> will create keys with coin-type 118(cosmos) and will only be supported by CLI and not by current or future wallets.

* Install the Black application on the Ledger
  device. [ref](https://github.com/gridironOne/blackCore/blob/main/docs/resources/Ledger.md#install-the-black-ledger-application)
* Connect the Ledger device to a system with blackCore binary and open the Black application on it.
* Add key

```shell
blackCore keys add [key_name] --ledger
```

* Sign transaction

```shell
blackCore tx [transaction parameters] --ledger
```

### Reset chain

```shell
rm -rf ~/.blackCore
```

### Shutdown node

```shell
killall blackCore
```

### Check version

```shell
blackCore version
```

## Test-nets

* [test-core-1](https://github.com/gridironOne/genesisTransactions/tree/master/test-core-1)

## Main-net

* [core-1](https://github.com/gridironOne/genesisTransactions/tree/master/core-1)
