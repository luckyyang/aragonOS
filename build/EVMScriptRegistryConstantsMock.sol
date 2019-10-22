pragma solidity 0.4.24;


interface IEVMScriptExecutor {
    function execScript(bytes script, bytes input, address[] blacklist) external returns (bytes);
    function executorType() external pure returns (bytes32);
}

contract EVMScriptRegistryConstants {
    
    bytes32 internal constant EVMSCRIPT_REGISTRY_APP_ID = 0xddbcfd564f642ab5627cf68b9b7d374fb4f8a36e941a75d89c87998cef03bd61;
}

interface IEVMScriptRegistry {
    function addScriptExecutor(IEVMScriptExecutor executor) external returns (uint id);
    function disableScriptExecutor(uint256 executorId) external;

    
    
    function getScriptExecutor(bytes script) public view returns (IEVMScriptExecutor);
}

contract EVMScriptRegistryConstantsMock is EVMScriptRegistryConstants {
    function getEVMScriptRegistryAppId() external pure returns (bytes32) { return EVMSCRIPT_REGISTRY_APP_ID; }
}