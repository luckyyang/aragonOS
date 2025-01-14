const homedir = require('homedir')
const path = require('path')

const HDWalletProvider = require('truffle-hdwallet-provider')
const HDWalletProviderPrivkey = require('truffle-hdwallet-provider-privkey')

const DEFAULT_MNEMONIC = 'stumble story behind hurt patient ball whisper art swift tongue ice alien'

const defaultRPC = (network) =>
`https://${network}.infura.io/v3/7851ca7a578b4e08a349409689b246af`

const elaethRPC = 'https://rpc.elaeth.io:443'

const configFilePath = (filename) =>
  path.join(homedir(), `.aragon/${filename}`)

const mnemonic = () => {
  try {
    return require(configFilePath('mnemonic.json')).mnemonic
  } catch (e) {
    return DEFAULT_MNEMONIC
  }
}

const settingsForNetwork = (network) => {
  try {
    return require(configFilePath(`${network}_key.json`))
  } catch (e) {
    return { }
  }
}

// Lazily loaded provider
const providerForNetwork = (network) => (
  () => {
    let { rpc, keys } = settingsForNetwork(network)
    if (network === 'elaeth') {
      rpc = elaethRPC
    } else {
      rpc = rpc || defaultRPC(network)
    }
    console.log('rpc is: ', rpc)
    if (!keys || keys.length == 0) {
      return new HDWalletProvider(mnemonic(), rpc)
    }

    return new HDWalletProviderPrivkey(keys, rpc)
  }
)

const mochaGasSettings = {
  reporter: 'eth-gas-reporter',
  reporterOptions : {
    currency: 'USD',
    gasPrice: 3
  }
}

const mocha = process.env.GAS_REPORTER ? mochaGasSettings : {}

module.exports = {
  compilers: {
    solc: {
      version: "0.4.24"
    }
  },
  networks: {
    rpc: {
      network_id: 15,
      host: 'localhost',
      port: 8545,
      gas: 6.9e6,
      gasPrice: 15000000001
    },
    devnet: {
      network_id: 16,
      host: 'localhost',
      port: 8535,
      gas: 6.9e6,
      gasPrice: 15000000001
    },
    mainnet: {
      network_id: 1,
      provider: providerForNetwork('mainnet'),
      gas: 7.9e6,
      gasPrice: 3000000001
    },
    ropsten: {
      network_id: 3,
      provider: providerForNetwork('ropsten'),
      gas: 4.712e6
    },
    rinkeby: {
      network_id: 4,
      provider: providerForNetwork('rinkeby'),
      gas: 6.9e6,
      gasPrice: 15000000001
    },
    elaeth: {
      network_id: 3,
      provider: providerForNetwork('elaeth'),
      gas: 8e6,
      gasPrice: 1e9
    },
    kovan: {
      network_id: 42,
      provider: providerForNetwork('kovan'),
      gas: 6.9e6
    },
    coverage: {
      host: "localhost",
      network_id: "*",
      port: 8555,
      gas: 0xffffffffff,
      gasPrice: 0x01
    },
    development: {
      host: 'localhost',
      network_id: '*',
      port: 8545,
      gas: 6.9e6,
      gasPrice: 15000000001
    },
  },
  build: {},
  mocha,
  solc: {
    optimizer: {
      enabled: true,
      runs: 10000
    }
  },
}
