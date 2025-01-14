const logDeploy = require('./helpers/deploy-logger')
const getAccounts = require('./helpers/get-accounts')

const globalArtifacts = this.artifacts // Not injected unless called directly via truffle
const globalWeb3 = this.web3 // Not injected unless called directly via truffle

const defaultOwner = process.env.OWNER

module.exports = async (
  truffleExecCallback,
  {
    artifacts = globalArtifacts,
    web3 = globalWeb3,
    owner = defaultOwner,
    verbose = true
  } = {}
) => {
  const log = (...args) => {
    if (verbose) { console.log(...args) }
  }

  if (!owner) {
    const accounts = await getAccounts(web3)
    owner = accounts[0]
    log(`No OWNER environment variable passed, setting ENS owner to provider's account: ${owner}`)
  }

  const ENS = artifacts.require('ENS')
  const ENSFactory = artifacts.require('ENSFactory')

  const ENSFactoryDeployedAddress = '0x0BD2409cCa2E8A1329aBCa5782652dFa3573a342'
  const ensAddr = '0xfd013e43e120a5c9189f50407183454fca764dee'
  // const ENSFactoryDeployedAddress = '0x2043A32E3e463Dfaa2Af561CA6bF39021A07222f'
  // const ensAddr = '0xd5b453fb92a23532a1d4aef5719260d10adcc675'

  log('Deploying ENSFactory...')
  let factory
  try {
    factory = await ENSFactory.at(ENSFactoryDeployedAddress)
  } catch (error) {
    console.log('Got factory error: ', error)
  }

  log('Got factory, factory address is: ', factory.address)
  log('Create a ENS instance for owner: ', owner)
  await logDeploy(factory, { verbose })
  let receipt
  try {
    receipt = await factory.newENS(owner)
  } catch (error) {
    console.log('newENS error: ', error)
  }

  // const ensAddr = receipt.logs.filter(l => l.event == 'DeployENS')[0].args.ens

  log('====================')
  log('Deployed ENS:', ensAddr, ', owner: ', owner)

  if (typeof truffleExecCallback === 'function') {
    // Called directly via `truffle exec`
    truffleExecCallback()
  } else {
    return {
      ens: ENS.at(ensAddr),
      ensFactory: factory,
    }
  }
}

