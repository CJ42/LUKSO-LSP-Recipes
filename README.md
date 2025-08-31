# LUKSO LSP Recipes

> TODO: description

## Getting started

1. [Install foundry](https://getfoundry.sh/).

2. Install the [**`bun`** package manager](https://bun.sh/package-manager).

3. Install the dependencies

```bash
forge install
bun install
```

## Development

### Add new packages

You can install new packages and dependencies using **`bun`** or Foundry.

```bash
bun add @remix-project/remixd
```

### Build

To generate the artifacts (contract ABIs and bytecode), simply run:

```shell
bun run build
```

The contract ABIs will placed under the `artifacts/` folder.

### Test

```shell
bun run test
```

### Format Solidity code

```shell
bun run format
```

The formatting rules can be adjusted in the [`foundry.toml`](./foundry.toml) file, under the `[fmt]` section.

<!-- ### Gas Snapshots

```shell
forge snapshot
``` -->

<!-- ### Anvil

```shell
$ anvil
```
-->


## Documentation

This template repository is based on Foundry, **a blazing fast, portable and modular toolkit for EVM application development written in Rust.** It includes:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

You can find more documentation at: https://book.getfoundry.sh/
