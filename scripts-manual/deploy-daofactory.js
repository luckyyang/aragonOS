const logDeploy = require('./helpers/deploy-logger')

const globalArtifacts = this.artifacts // Not injected unless called directly via truffle

const ZERO_ADDR = '0x0000000000000000000000000000000000000000'

const defaultKernelBase = process.env.KERNEL_BASE
const defaultAclBaseAddress = process.env.ACL_BASE

module.exports = async (
  truffleExecCallback,
  {
    artifacts = globalArtifacts,
    kernelBaseAddress = defaultKernelBase,
    aclBaseAddress = defaultAclBaseAddress,
    withEvmScriptRegistryFactory = true,
    verbose = true
  } = {}
) => {
  const log = (...args) => {
    if (verbose) { console.log(...args) }
  }

  const ACL = artifacts.require('ACL')
  const Kernel = artifacts.require('Kernel')

  const KernelDeployedAddress = '0xcc134b868679826efb850393B55b49DAAef2bc33'
  const ACLDeployedAddress = '0xB161ba006EabbD6DfD5001D00AD61f058739708F'
  const EVMScriptRegistryFactoryDeployedAddress = '0xF78a2f55284d74EB32a5E756BB70416995567396'

  // ==> NOTE <===: use above 3 params to deploy DAOFactory
  const DAOFactoryDeployedAddress = '0x839cB66c2C15207460D7E5466e866374588EDa9d'

  const DAOFactory = artifacts.require('DAOFactory')

  let kernelBase
  if (kernelBaseAddress) {
    kernelBase = Kernel.at(kernelBaseAddress)
    log(`Skipping deploying new Kernel base, using provided address: ${kernelBaseAddress}`)
  } else {
    kernelBase = await Kernel.at(KernelDeployedAddress) // immediately petrify
    await logDeploy(kernelBase, { verbose })
  }

  let aclBase
  if (aclBaseAddress) {
    aclBase = ACL.at(aclBaseAddress)
    log(`Skipping deploying new ACL base, using provided address: ${aclBaseAddress}`)
  } else {
    aclBase = await ACL.at(ACLDeployedAddress)
    await logDeploy(aclBase, { verbose })
  }

  let evmScriptRegistryFactory
  if (withEvmScriptRegistryFactory) {
    const EVMScriptRegistryFactory = artifacts.require('EVMScriptRegistryFactory')
    evmScriptRegistryFactory = await EVMScriptRegistryFactory.at(EVMScriptRegistryFactoryDeployedAddress)
    await logDeploy(evmScriptRegistryFactory, { verbose })
  }
  // const daoFactory = await DAOFactory.new(
  //   kernelBase.address,
  //   aclBase.address,
  //   evmScriptRegistryFactory ? evmScriptRegistryFactory.address : ZERO_ADDR
  // )
  const daoFactory = await DAOFactory.at(DAOFactoryDeployedAddress)

  await logDeploy(daoFactory, { verbose })

  if (typeof truffleExecCallback === 'function') {
    // Called directly via `truffle exec`
    truffleExecCallback()
  } else {
    return {
      aclBase,
      daoFactory,
      evmScriptRegistryFactory,
      kernelBase,
    }
  }
}
