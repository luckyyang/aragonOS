pragma solidity 0.4.24;


library UnstructuredStorage {
    function getStorageBool(bytes32 position) internal view returns (bool data) {
        assembly { data := sload(position) }
    }

    function getStorageAddress(bytes32 position) internal view returns (address data) {
        assembly { data := sload(position) }
    }

    function getStorageBytes32(bytes32 position) internal view returns (bytes32 data) {
        assembly { data := sload(position) }
    }

    function getStorageUint256(bytes32 position) internal view returns (uint256 data) {
        assembly { data := sload(position) }
    }

    function setStorageBool(bytes32 position, bool data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageAddress(bytes32 position, address data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageBytes32(bytes32 position, bytes32 data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageUint256(bytes32 position, uint256 data) internal {
        assembly { sstore(position, data) }
    }
}

interface IACL {
    function initialize(address permissionsCreator) external;

    
    
    function hasPermission(address who, address where, bytes32 what, bytes how) public view returns (bool);
}

interface IVaultRecoverable {
    event RecoverToVault(address indexed vault, address indexed token, uint256 amount);

    function transferToVault(address token) external;

    function allowRecoverability(address token) external view returns (bool);
    function getRecoveryVault() external view returns (address);
}

interface IKernelEvents {
    event SetApp(bytes32 indexed namespace, bytes32 indexed appId, address app);
}

contract IKernel is IKernelEvents, IVaultRecoverable {
    function acl() public view returns (IACL);
    function hasPermission(address who, address where, bytes32 what, bytes how) public view returns (bool);

    function setApp(bytes32 namespace, bytes32 appId, address app) public;
    function getApp(bytes32 namespace, bytes32 appId) public view returns (address);
}

contract AppStorage {
    using UnstructuredStorage for bytes32;

    
    bytes32 internal constant KERNEL_POSITION = 0x4172f0f7d2289153072b0a6ca36959e0cbe2efc3afe50fc81636caa96338137b;
    bytes32 internal constant APP_ID_POSITION = 0xd625496217aa6a3453eecb9c3489dc5a53e6c67b444329ea2b2cbc9ff547639b;

    function kernel() public view returns (IKernel) {
        return IKernel(KERNEL_POSITION.getStorageAddress());
    }

    function appId() public view returns (bytes32) {
        return APP_ID_POSITION.getStorageBytes32();
    }

    function setKernel(IKernel _kernel) internal {
        KERNEL_POSITION.setStorageAddress(address(_kernel));
    }

    function setAppId(bytes32 _appId) internal {
        APP_ID_POSITION.setStorageBytes32(_appId);
    }
}

contract ACLSyntaxSugar {
    function arr() internal pure returns (uint256[]) {
        return new uint256[](0);
    }

    function arr(bytes32 _a) internal pure returns (uint256[] r) {
        return arr(uint256(_a));
    }

    function arr(bytes32 _a, bytes32 _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a) internal pure returns (uint256[] r) {
        return arr(uint256(_a));
    }

    function arr(address _a, address _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a, uint256 _b, uint256 _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), _b, _c);
    }

    function arr(address _a, uint256 _b, uint256 _c, uint256 _d) internal pure returns (uint256[] r) {
        return arr(uint256(_a), _b, _c, _d);
    }

    function arr(address _a, uint256 _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a, address _b, uint256 _c, uint256 _d, uint256 _e) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), _c, _d, _e);
    }

    function arr(address _a, address _b, address _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), uint256(_c));
    }

    function arr(address _a, address _b, uint256 _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), uint256(_c));
    }

    function arr(uint256 _a) internal pure returns (uint256[] r) {
        r = new uint256[](1);
        r[0] = _a;
    }

    function arr(uint256 _a, uint256 _b) internal pure returns (uint256[] r) {
        r = new uint256[](2);
        r[0] = _a;
        r[1] = _b;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c) internal pure returns (uint256[] r) {
        r = new uint256[](3);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c, uint256 _d) internal pure returns (uint256[] r) {
        r = new uint256[](4);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
        r[3] = _d;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c, uint256 _d, uint256 _e) internal pure returns (uint256[] r) {
        r = new uint256[](5);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
        r[3] = _d;
        r[4] = _e;
    }
}

contract ACLHelpers {
    function decodeParamOp(uint256 _x) internal pure returns (uint8 b) {
        return uint8(_x >> (8 * 30));
    }

    function decodeParamId(uint256 _x) internal pure returns (uint8 b) {
        return uint8(_x >> (8 * 31));
    }

    function decodeParamsList(uint256 _x) internal pure returns (uint32 a, uint32 b, uint32 c) {
        a = uint32(_x);
        b = uint32(_x >> (8 * 4));
        c = uint32(_x >> (8 * 8));
    }
}

library Uint256Helpers {
    uint256 private constant MAX_UINT64 = uint64(-1);

    string private constant ERROR_NUMBER_TOO_BIG = "UINT64_NUMBER_TOO_BIG";

    function toUint64(uint256 a) internal pure returns (uint64) {
        require(a <= MAX_UINT64, ERROR_NUMBER_TOO_BIG);
        return uint64(a);
    }
}

contract TimeHelpers {
    using Uint256Helpers for uint256;

    
    function getBlockNumber() internal view returns (uint256) {
        return block.number;
    }

    
    function getBlockNumber64() internal view returns (uint64) {
        return getBlockNumber().toUint64();
    }

    
    function getTimestamp() internal view returns (uint256) {
        return block.timestamp; 
    }

    
    function getTimestamp64() internal view returns (uint64) {
        return getTimestamp().toUint64();
    }
}

contract Initializable is TimeHelpers {
    using UnstructuredStorage for bytes32;

    
    bytes32 internal constant INITIALIZATION_BLOCK_POSITION = 0xebb05b386a8d34882b8711d156f463690983dc47815980fb82aeeff1aa43579e;

    string private constant ERROR_ALREADY_INITIALIZED = "INIT_ALREADY_INITIALIZED";
    string private constant ERROR_NOT_INITIALIZED = "INIT_NOT_INITIALIZED";

    modifier onlyInit {
        require(getInitializationBlock() == 0, ERROR_ALREADY_INITIALIZED);
        _;
    }

    modifier isInitialized {
        require(hasInitialized(), ERROR_NOT_INITIALIZED);
        _;
    }

    
    function getInitializationBlock() public view returns (uint256) {
        return INITIALIZATION_BLOCK_POSITION.getStorageUint256();
    }

    
    function hasInitialized() public view returns (bool) {
        uint256 initializationBlock = getInitializationBlock();
        return initializationBlock != 0 && getBlockNumber() >= initializationBlock;
    }

    
    function initialized() internal onlyInit {
        INITIALIZATION_BLOCK_POSITION.setStorageUint256(getBlockNumber());
    }

    
    function initializedAt(uint256 _blockNumber) internal onlyInit {
        INITIALIZATION_BLOCK_POSITION.setStorageUint256(_blockNumber);
    }
}

contract Petrifiable is Initializable {
    
    uint256 internal constant PETRIFIED_BLOCK = uint256(-1);

    function isPetrified() public view returns (bool) {
        return getInitializationBlock() == PETRIFIED_BLOCK;
    }

    
    function petrify() internal onlyInit {
        initializedAt(PETRIFIED_BLOCK);
    }
}

contract Autopetrified is Petrifiable {
    constructor() public {
        
        
        petrify();
    }
}

library ConversionHelpers {
    string private constant ERROR_IMPROPER_LENGTH = "CONVERSION_IMPROPER_LENGTH";

    function dangerouslyCastUintArrayToBytes(uint256[] memory _input) internal pure returns (bytes memory output) {
        
        
        
        uint256 byteLength = _input.length * 32;
        assembly {
            output := _input
            mstore(output, byteLength)
        }
    }

    function dangerouslyCastBytesToUintArray(bytes memory _input) internal pure returns (uint256[] memory output) {
        
        
        
        uint256 intsLength = _input.length / 32;
        require(_input.length == intsLength * 32, ERROR_IMPROPER_LENGTH);

        assembly {
            output := _input
            mstore(output, intsLength)
        }
    }
}

contract ReentrancyGuard {
    using UnstructuredStorage for bytes32;

    
    bytes32 private constant REENTRANCY_MUTEX_POSITION = 0xe855346402235fdd185c890e68d2c4ecad599b88587635ee285bce2fda58dacb;

    string private constant ERROR_REENTRANT = "REENTRANCY_REENTRANT_CALL";

    modifier nonReentrant() {
        
        require(!REENTRANCY_MUTEX_POSITION.getStorageBool(), ERROR_REENTRANT);

        
        REENTRANCY_MUTEX_POSITION.setStorageBool(true);

        
        _;

        
        REENTRANCY_MUTEX_POSITION.setStorageBool(false);
    }
}

contract ERC20 {
    function totalSupply() public view returns (uint256);

    function balanceOf(address _who) public view returns (uint256);

    function allowance(address _owner, address _spender)
        public view returns (uint256);

    function transfer(address _to, uint256 _value) public returns (bool);

    function approve(address _spender, uint256 _value)
        public returns (bool);

    function transferFrom(address _from, address _to, uint256 _value)
        public returns (bool);

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract EtherTokenConstant {
    address internal constant ETH = address(0);
}

contract IsContract {
    
    function isContract(address _target) internal view returns (bool) {
        if (_target == address(0)) {
            return false;
        }

        uint256 size;
        assembly { size := extcodesize(_target) }
        return size > 0;
    }
}

library SafeERC20 {
    
    
    bytes4 private constant TRANSFER_SELECTOR = 0xa9059cbb;

    string private constant ERROR_TOKEN_BALANCE_REVERTED = "SAFE_ERC_20_BALANCE_REVERTED";
    string private constant ERROR_TOKEN_ALLOWANCE_REVERTED = "SAFE_ERC_20_ALLOWANCE_REVERTED";

    function invokeAndCheckSuccess(address _addr, bytes memory _calldata)
        private
        returns (bool)
    {
        bool ret;
        assembly {
            let ptr := mload(0x40)    

            let success := call(
                gas,                  
                _addr,                
                0,                    
                add(_calldata, 0x20), 
                mload(_calldata),     
                ptr,                  
                0x20                  
            )

            if gt(success, 0) {
                
                switch returndatasize

                
                case 0 {
                    ret := 1
                }

                
                case 0x20 {
                    
                    
                    ret := eq(mload(ptr), 1)
                }

                
                default { }
            }
        }
        return ret;
    }

    function staticInvoke(address _addr, bytes memory _calldata)
        private
        view
        returns (bool, uint256)
    {
        bool success;
        uint256 ret;
        assembly {
            let ptr := mload(0x40)    

            success := staticcall(
                gas,                  
                _addr,                
                add(_calldata, 0x20), 
                mload(_calldata),     
                ptr,                  
                0x20                  
            )

            if gt(success, 0) {
                ret := mload(ptr)
            }
        }
        return (success, ret);
    }

    
    function safeTransfer(ERC20 _token, address _to, uint256 _amount) internal returns (bool) {
        bytes memory transferCallData = abi.encodeWithSelector(
            TRANSFER_SELECTOR,
            _to,
            _amount
        );
        return invokeAndCheckSuccess(_token, transferCallData);
    }

    
    function safeTransferFrom(ERC20 _token, address _from, address _to, uint256 _amount) internal returns (bool) {
        bytes memory transferFromCallData = abi.encodeWithSelector(
            _token.transferFrom.selector,
            _from,
            _to,
            _amount
        );
        return invokeAndCheckSuccess(_token, transferFromCallData);
    }

    
    function safeApprove(ERC20 _token, address _spender, uint256 _amount) internal returns (bool) {
        bytes memory approveCallData = abi.encodeWithSelector(
            _token.approve.selector,
            _spender,
            _amount
        );
        return invokeAndCheckSuccess(_token, approveCallData);
    }

    
    function staticBalanceOf(ERC20 _token, address _owner) internal view returns (uint256) {
        bytes memory balanceOfCallData = abi.encodeWithSelector(
            _token.balanceOf.selector,
            _owner
        );

        (bool success, uint256 tokenBalance) = staticInvoke(_token, balanceOfCallData);
        require(success, ERROR_TOKEN_BALANCE_REVERTED);

        return tokenBalance;
    }

    
    function staticAllowance(ERC20 _token, address _owner, address _spender) internal view returns (uint256) {
        bytes memory allowanceCallData = abi.encodeWithSelector(
            _token.allowance.selector,
            _owner,
            _spender
        );

        (bool success, uint256 allowance) = staticInvoke(_token, allowanceCallData);
        require(success, ERROR_TOKEN_ALLOWANCE_REVERTED);

        return allowance;
    }

    
    function staticTotalSupply(ERC20 _token) internal view returns (uint256) {
        bytes memory totalSupplyCallData = abi.encodeWithSelector(_token.totalSupply.selector);

        (bool success, uint256 totalSupply) = staticInvoke(_token, totalSupplyCallData);
        require(success, ERROR_TOKEN_ALLOWANCE_REVERTED);

        return totalSupply;
    }
}

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

contract KernelAppIds {
    
    bytes32 internal constant KERNEL_CORE_APP_ID = 0x3b4bf6bf3ad5000ecf0f989d5befde585c6860fea3e574a4fab4c49d1c177d9c;
    bytes32 internal constant KERNEL_DEFAULT_ACL_APP_ID = 0xe3262375f45a6e2026b7e7b18c2b807434f2508fe1a2a3dfb493c7df8f4aad6a;
    bytes32 internal constant KERNEL_DEFAULT_VAULT_APP_ID = 0x7e852e0fcfce6551c13800f1e7476f982525c2b5277ba14b24339c68416336d1;
}

contract KernelNamespaceConstants {
    
    bytes32 internal constant KERNEL_CORE_NAMESPACE = 0xc681a85306374a5ab27f0bbc385296a54bcd314a1948b6cf61c4ea1bc44bb9f8;
    bytes32 internal constant KERNEL_APP_BASES_NAMESPACE = 0xf1f3eb40f5bc1ad1344716ced8b8a0431d840b5783aea1fd01786bc26f35ac0f;
    bytes32 internal constant KERNEL_APP_ADDR_NAMESPACE = 0xd6f028ca0e8edb4a8c9757ca4fdccab25fa1e0317da1188108f7d2dee14902fb;
}

interface IACLOracle {
    function canPerform(address who, address where, bytes32 what, uint256[] how) external view returns (bool);
}

library Assert {

    
    
    address constant ADDRESS_NULL = 0x0000000000000000000000000000000000000000;
    
    
    bytes32 constant BYTES32_NULL = 0x0;
    
    
    string constant STRING_NULL = "";

    uint8 constant ZERO = uint8(byte('0'));
    uint8 constant A = uint8(byte('a'));

    byte constant MINUS = byte('-');

    
    event TestEvent(bool indexed result, string message);

    

    
    function fail(string message) public returns (bool result) {
        _report(false, message);
        return false;
    }

    

    
    function equal(string a, string b, string message) public returns (bool result) {
        result = _stringsEqual(a, b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function notEqual(string a, string b, string message) public returns (bool result) {
        result = !_stringsEqual(a, b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isEmpty(string str, string message) public returns (bool result) {
        result = _stringsEqual(str, STRING_NULL);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(str, "Tested"), message));
    }

    
    function isNotEmpty(string str, string message) public returns (bool result) {
        result = !_stringsEqual(str, STRING_NULL);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(str, "Tested"), message));
    }

    

    
    function equal(bytes32 a, bytes32 b, string message) public returns (bool result) {
        result = (a == b);
        _report(result, message);
    }

    
    function notEqual(bytes32 a, bytes32 b, string message) public returns (bool result) {
        result = (a != b);
        _report(result, message);
    }

    
    function isZero(bytes32 bts, string message) public returns (bool result) {
        result = (bts == BYTES32_NULL);
        _report(result, message);
    }

    
    function isNotZero(bytes32 bts, string message) public returns (bool result) {
        result = (bts != BYTES32_NULL);
        _report(result, message);
    }

    

    
    function equal(address a, address b, string message) public returns (bool result) {
        result = (a == b);
        _report(result, message);
    }
    
    function notEqual(address a, address b, string message) public returns (bool result) {
        result = (a != b);
         _report(result, message);
    }

    
    function isZero(address addr, string message) public returns (bool result) {
        result = (addr == ADDRESS_NULL);
        _report(result, message);
    }

    
    function isNotZero(address addr, string message) public returns (bool result) {
        result = (addr != ADDRESS_NULL);
        _report(result, message);
    }

    

    
    function isTrue(bool b, string message) public returns (bool result) {
        result = b;
        _report(result, message);
    }

    
    function isFalse(bool b, string message) public returns (bool result) {
        result = !b;
        _report(result, message);
    }

    
    function equal(bool a, bool b, string message) public returns (bool result) {
        result = (a == b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function notEqual(bool a, bool b, string message) public returns (bool result) {
        result = (a != b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    

    
    function equal(uint a, uint b, string message) public returns (bool result) {
        result = (a == b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function notEqual(uint a, uint b, string message) public returns (bool result) {
        result = (a != b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isAbove(uint a, uint b, string message) public returns (bool result) {
        result = (a > b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isAtLeast(uint a, uint b, string message) public returns (bool result) {
        result = (a >= b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isBelow(uint a, uint b, string message) public returns (bool result) {
        result = (a < b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isAtMost(uint a, uint b, string message) public returns (bool result) {
        result = (a <= b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isZero(uint number, string message) public returns (bool result) {
        result = (number == 0);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(number, "Tested"), message));
    }

    
    function isNotZero(uint number, string message) public returns (bool result) {
        result = (number != 0);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(number, "Tested"), message));
    }

    

    
    function equal(int a, int b, string message) public returns (bool result) {
        result = (a == b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function notEqual(int a, int b, string message) public returns (bool result) {
        result = (a != b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isAbove(int a, int b, string message) public returns (bool result) {
        result = (a > b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isAtLeast(int a, int b, string message) public returns (bool result) {
        result = (a >= b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isBelow(int a, int b, string message) public returns (bool result) {
        result = (a < b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isAtMost(int a, int b, string message) public returns (bool result) {
        result = (a <= b);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(a, "Tested"), _tag(b, "Against"), message));
    }

    
    function isZero(int number, string message) public returns (bool result) {
        result = (number == 0);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(number, "Tested"), message));
    }

    
    function isNotZero(int number, string message) public returns (bool result) {
        result = (number != 0);
        if (result)
            _report(result, message);
        else
            _report(result, _appendTagged(_tag(number, "Tested"), message));
    }

    

    
    function equal(uint[] arrA, uint[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        _report(result, message);
    }

    
    function notEqual(uint[] arrA, uint[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        result = !result;
        _report(result, message);
    }

    
    function lengthEqual(uint[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength == length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    
    function lengthNotEqual(uint[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength != arr.length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    

    
    function equal(int[] arrA, int[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        _report(result, message);
    }

    
    function notEqual(int[] arrA, int[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        result = !result;
        _report(result, message);
    }

    
    function lengthEqual(int[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength == length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    
    function lengthNotEqual(int[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength != arr.length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    

    
    function equal(address[] arrA, address[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        _report(result, message);
    }

    
    function notEqual(address[] arrA, address[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        result = !result;
        _report(result, message);
    }

    
    function lengthEqual(address[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength == length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    
    function lengthNotEqual(address[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength != arr.length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    

    
    function equal(bytes32[] arrA, bytes32[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        _report(result, message);
    }

    
    function notEqual(bytes32[] arrA, bytes32[] arrB, string message) public returns (bool result) {
        result = arrA.length == arrB.length;
        if (result) {
            for (uint i = 0; i < arrA.length; i++) {
                if (arrA[i] != arrB[i]) {
                    result = false;
                    break;
                }
            }
        }
        result = !result;
        _report(result, message);
    }

    
    function lengthEqual(bytes32[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength == length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    
    function lengthNotEqual(bytes32[] arr, uint length, string message) public returns (bool result) {
        uint arrLength = arr.length;
        if (arrLength != arr.length)
            _report(result, "");
        else
            _report(result, _appendTagged(_tag(arrLength, "Tested"), _tag(length, "Against"), message));
    }

    

    
    function balanceEqual(address a, uint b, string message) public returns (bool result) {
        result = (a.balance == b);
        _report(result, message);
    }

    
    function balanceNotEqual(address a, uint b, string message) public returns (bool result) {
        result = (a.balance != b);
        _report(result, message);
    }

    
    function balanceIsZero(address a, string message) public returns (bool result) {
        result = (a.balance == 0);
        _report(result, message);
    }

    
    function balanceIsNotZero(address a, string message) public returns (bool result) {
        result = (a.balance != 0);
        _report(result, message);
    }

    

        
    function _report(bool result, string message) internal {
        if(result)
            emit TestEvent(true, "");
        else
            emit TestEvent(false, message);
    }

    
    function _stringsEqual(string a, string b) internal pure returns (bool result) {
        bytes memory ba = bytes(a);
        bytes memory bb = bytes(b);

        if (ba.length != bb.length)
            return false;
        for (uint i = 0; i < ba.length; i ++) {
            if (ba[i] != bb[i])
                return false;
        }
        return true;
    }

    
    function _itoa(int n, uint8 radix) internal pure returns (string) {
        if (n == 0 || radix < 2 || radix > 16)
            return '0';
        bytes memory bts = new bytes(256);
        uint i;
        bool neg = false;
        if (n < 0) {
            n = -n;
            neg = true;
        }
        while (n > 0) {
            bts[i++] = _utoa(uint8(n % radix)); 
            n /= radix;
        }
        
        uint size = i;
        uint j = 0;
        bytes memory rev;
        if (neg) {
            size++;
            j = 1;
            rev = new bytes(size);
            rev[0] = MINUS;
        }
        else
            rev = new bytes(size);

        for (; j < size; j++)
            rev[j] = bts[size - j - 1];
        return string(rev);
    }

    
    function _utoa(uint n, uint8 radix) internal pure returns (string) {
        if (n == 0 || radix < 2 || radix > 16)
            return '0';
        bytes memory bts = new bytes(256);
        uint i;
        while (n > 0) {
            bts[i++] = _utoa(uint8(n % radix)); 
            n /= radix;
        }
        
        bytes memory rev = new bytes(i);
        for (uint j = 0; j < i; j++)
            rev[j] = bts[i - j - 1];
        return string(rev);
    }

    
    function _utoa(uint8 u) internal pure returns (byte) {
        if (u < 10)
            return byte(u + ZERO);
        else if (u < 16)
            return byte(u - 10 + A);
        else
            return 0;
    }

    
    function _ltoa(bool val) internal pure returns (string) {
        bytes memory b;
        if (val) {
            b = new bytes(4);
            b[0] = 't';
            b[1] = 'r';
            b[2] = 'u';
            b[3] = 'e';
            return string(b);
        }
        else {
            b = new bytes(5);
            b[0] = 'f';
            b[1] = 'a';
            b[2] = 'l';
            b[3] = 's';
            b[4] = 'e';
            return string(b);
        }
    }

    

    
    function _tag(string value, string tag) internal pure returns (string) {

        bytes memory valueB = bytes(value);
        bytes memory tagB = bytes(tag);

        uint vl = valueB.length;
        uint tl = tagB.length;

        bytes memory newB = new bytes(vl + tl + 2);

        uint i;
        uint j;

        for (i = 0; i < tl; i++)
            newB[j++] = tagB[i];
        newB[j++] = ':';
        newB[j++] = ' ';
        for (i = 0; i < vl; i++)
            newB[j++] = valueB[i];

        return string(newB);
    }

    
    function _tag(int value, string tag) internal pure returns (string) {
        string memory nstr = _itoa(value, 10);
        return _tag(nstr, tag);
    }

    
    function _tag(uint value, string tag) internal pure returns (string) {
        string memory nstr = _utoa(value, 10);
        return _tag(nstr, tag);
    }

    
    function _tag(bool value, string tag) internal pure returns (string) {
        string memory nstr = _ltoa(value);
        return _tag(nstr, tag);
    }

    
    function _appendTagged(string tagged, string str) internal pure returns (string) {

        bytes memory taggedB = bytes(tagged);
        bytes memory strB = bytes(str);

        uint sl = strB.length;
        uint tl = taggedB.length;

        bytes memory newB = new bytes(sl + tl + 3);

        uint i;
        uint j;

        for (i = 0; i < sl; i++)
            newB[j++] = strB[i];
        newB[j++] = ' ';
        newB[j++] = '(';
        for (i = 0; i < tl; i++)
            newB[j++] = taggedB[i];
        newB[j++] = ')';

        return string(newB);
    }

    
    function _appendTagged(string tagged0, string tagged1, string str) internal pure returns (string) {

        bytes memory tagged0B = bytes(tagged0);
        bytes memory tagged1B = bytes(tagged1);
        bytes memory strB = bytes(str);

        uint sl = strB.length;
        uint t0l = tagged0B.length;
        uint t1l = tagged1B.length;

        bytes memory newB = new bytes(sl + t0l + t1l + 5);

        uint i;
        uint j;

        for (i = 0; i < sl; i++)
            newB[j++] = strB[i];
        newB[j++] = ' ';
        newB[j++] = '(';
        for (i = 0; i < t0l; i++)
            newB[j++] = tagged0B[i];
        newB[j++] = ',';
        newB[j++] = ' ';
        for (i = 0; i < t1l; i++)
            newB[j++] = tagged1B[i];
        newB[j++] = ')';

        return string(newB);
    }

}

contract ACLHelper {
    function encodeOperator(uint256 param1, uint256 param2) internal pure returns (uint240) {
        return encodeIfElse(param1, param2, 0);
    }

    function encodeIfElse(uint256 condition, uint256 successParam, uint256 failureParam) internal pure returns (uint240) {
        return uint240(condition + (successParam << 32) + (failureParam << 64));
    }
}

contract AcceptOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        return true;
    }
}

contract RejectOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        return false;
    }
}

contract RevertOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        revert();
    }
}

contract StateModifyingOracle {
    bool modifyState;

    function canPerform(address, address, bytes32, uint256[]) external returns (bool) {
        modifyState = true;
        return true;
    }
}

contract EmptyDataReturnOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        assembly {
            return(0, 0)
        }
    }
}

contract ConditionalOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[] how) external view returns (bool) {
        return how[0] > 0;
    }
}

contract TestACLInterpreter is ACL, ACLHelper {
    function testEqualityUint() public {
        
        assertEval(arr(uint256(10), 11), 0, Op.EQ, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.EQ, 10, false);
        assertEval(arr(uint256(10), 11), 1, Op.EQ, 11, true);
    }

    function testEqualityAddr() public {
        assertEval(arr(msg.sender), 0, Op.EQ, uint256(msg.sender), true);
        assertEval(arr(msg.sender), 0, Op.EQ, uint256(this), false);
    }

    function testEqualityBytes() public {
        assertEval(arr(keccak256("hi")), 0, Op.EQ, uint256(keccak256("hi")), true);
        assertEval(arr(keccak256("hi")), 0, Op.EQ, uint256(keccak256("bye")), false);
    }

    function testInequalityUint() public {
        assertEval(arr(uint256(10), 11), 0, Op.NEQ, 10, false);
        assertEval(arr(uint256(10), 11), 1, Op.NEQ, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.NEQ, 11, false);
    }

    function testInequalityBytes() public {
        assertEval(arr(keccak256("hi")), 0, Op.NEQ, uint256(keccak256("hi")), false);
        assertEval(arr(keccak256("hi")), 0, Op.NEQ, uint256(keccak256("bye")), true);
    }

    function testInequalityAddr() public {
        assertEval(arr(msg.sender), 0, Op.NEQ, uint256(msg.sender), false);
        assertEval(arr(msg.sender), 0, Op.NEQ, uint256(this), true);
    }

    function testGreatherThan() public {
        assertEval(arr(uint256(10), 11), 0, Op.GT, 9, true);
        assertEval(arr(uint256(10), 11), 0, Op.GT, 10, false);
        assertEval(arr(uint256(10), 11), 1, Op.GT, 10, true);
    }

    function testLessThan() public {
        assertEval(arr(uint256(10), 11), 0, Op.LT, 9, false);
        assertEval(arr(uint256(9), 11), 0, Op.LT, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.LT, 10, false);
    }

    function testGreatherThanOrEqual() public {
        assertEval(arr(uint256(10), 11), 0, Op.GTE, 9, true);
        assertEval(arr(uint256(10), 11), 0, Op.GTE, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.GTE, 12, false);
    }

    function testLessThanOrEqual() public {
        assertEval(arr(uint256(10), 11), 0, Op.LTE, 9, false);
        assertEval(arr(uint256(9), 11), 0, Op.LTE, 10, true);
        assertEval(arr(uint256(10), 11), 1, Op.LTE, 11, true);
    }

    function testTimestamp() public {
        assertEval(arr(), TIMESTAMP_PARAM_ID, Op.EQ, uint256(block.timestamp), true);
        assertEval(arr(), TIMESTAMP_PARAM_ID, Op.EQ, uint256(1), false);
        assertEval(arr(), TIMESTAMP_PARAM_ID, Op.GT, uint256(1), true);
    }

    function testBlockNumber() public {
        assertEval(arr(), BLOCK_NUMBER_PARAM_ID, Op.EQ, uint256(block.number), true);
        assertEval(arr(), BLOCK_NUMBER_PARAM_ID, Op.EQ, uint256(1), false);
        assertEval(arr(), BLOCK_NUMBER_PARAM_ID, Op.GT, uint256(block.number - 1), true);
    }

    function testOracle() public {
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new AcceptOracle()), true);
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new RejectOracle()), false);
        assertEval(arr(), ORACLE_PARAM_ID, Op.NEQ, uint256(new RejectOracle()), true);

        
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new RevertOracle()), false);
        
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new StateModifyingOracle()), false);
        
        assertEval(arr(), ORACLE_PARAM_ID, Op.EQ, uint256(new EmptyDataReturnOracle()), false);

        
        ConditionalOracle conditionalOracle = new ConditionalOracle();

        assertEval(arr(uint256(1)), ORACLE_PARAM_ID, Op.EQ, uint256(conditionalOracle), true);
        assertEval(arr(uint256(0), uint256(1)), ORACLE_PARAM_ID, Op.EQ, uint256(conditionalOracle), false);
    }

    function testReturn() public {
        assertEval(arr(), PARAM_VALUE_PARAM_ID, Op.RET, uint256(1), true);
        assertEval(arr(), PARAM_VALUE_PARAM_ID, Op.RET, uint256(0), false);
        assertEval(arr(), PARAM_VALUE_PARAM_ID, Op.RET, uint256(100), true);
        assertEval(arr(), TIMESTAMP_PARAM_ID, Op.RET, uint256(0), true);
    }

    function testNot() public {
        Param memory retTrue = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 1);
        Param memory retFalse = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 0);

        Param memory notOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.NOT), encodeOperator(1, 0));
        Param[] memory params = new Param[](2);

        
        params[0] = notOp;
        params[1] = retTrue;
        assertEval(params, false);

        
        params[1] = retFalse;
        assertEval(params, true);
    }

    function testComplexCombination() public {
        
        Param[] memory params = new Param[](7);
        params[0] = Param(LOGIC_OP_PARAM_ID, uint8(Op.IF_ELSE), encodeIfElse(1, 4, 6));
        params[1] = Param(LOGIC_OP_PARAM_ID, uint8(Op.AND), encodeOperator(2, 3));
        params[2] = Param(ORACLE_PARAM_ID, uint8(Op.EQ), uint240(new AcceptOracle()));
        params[3] = Param(BLOCK_NUMBER_PARAM_ID, uint8(Op.GT), uint240(block.number - 1));
        params[4] = Param(LOGIC_OP_PARAM_ID, uint8(Op.OR), encodeOperator(5, 2));
        params[5] = Param(0, uint8(Op.LT), uint240(10));
        params[6] = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 0);

        assertEval(params, arr(uint256(10)), true);

        params[4] = Param(LOGIC_OP_PARAM_ID, uint8(Op.AND), encodeOperator(5, 2));
        assertEval(params, arr(uint256(10)), false);
    }

    function testParamOutOfBoundsFail() public {
        Param[] memory params = new Param[](2);

        params[1] = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 1);
        assertEval(params, arr(uint256(10)), false);

        params[0] = Param(LOGIC_OP_PARAM_ID, uint8(Op.IF_ELSE), encodeIfElse(2, 2, 2));
        assertEval(params, arr(uint256(10)), false);
    }

    function testArgOutOfBoundsFail() public {
        assertEval(arr(uint256(10), 11), 3, Op.EQ, 10, false);
    }

    function testIfElse() public {
        Param memory retTrue = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 1);
        Param memory retFalse = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 0);

        
        Param memory ifOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.IF_ELSE), encodeIfElse(1, 2, 3));
        Param[] memory params = new Param[](4);

        
        params[0] = ifOp;
        params[1] = retTrue;
        params[2] = retTrue;
        params[3] = retFalse;
        assertEval(params, true);

        
        params[1] = retFalse;
        assertEval(params, false);
    }

    function testCombinators() public {
        Param memory retTrue = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 1);
        Param memory retFalse = Param(PARAM_VALUE_PARAM_ID, uint8(Op.RET), 0);

        
        Param memory orOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.OR), encodeOperator(1, 2));
        Param memory andOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.AND), encodeOperator(1, 2));
        Param memory xorOp = Param(LOGIC_OP_PARAM_ID, uint8(Op.XOR), encodeOperator(1, 2));

        Param[] memory params = new Param[](3);

        
        params[0] = orOp;
        params[1] = retTrue;
        params[2] = retTrue;
        assertEval(params, true);

        
        params[1] = retFalse;
        assertEval(params, true);

        
        params[1] = retTrue;
        params[2] = retFalse;
        assertEval(params, true);

        
        params[1] = retFalse;
        assertEval(params, false);

        
        params[0] = andOp;
        assertEval(params, false);

        
        params[1] = retTrue;
        assertEval(params, false);

        
        params[1] = retFalse;
        params[2] = retTrue;
        assertEval(params, false);

        
        params[1] = retTrue;
        params[2] = retTrue;
        assertEval(params, true);

        
        params[0] = xorOp;
        assertEval(params, false);

        
        params[1] = retFalse;
        assertEval(params, true);

        
        params[1] = retTrue;
        params[2] = retFalse;
        assertEval(params, true);

        
        params[1] = retFalse;
        assertEval(params, false);
    }


    function assertEval(uint256[] memory args, uint8 argId, Op op, uint256 value, bool expected) internal {
        Param[] memory params = new Param[](1);
        params[0] = Param(argId, uint8(op), uint240(value));
        assertEval(params, args, expected);
    }

    function assertEval(Param[] memory params, bool expected) internal {
        assertEval(params, new uint256[](0), expected);
    }

    function assertEval(Param[] memory params, uint256[] memory args, bool expected) internal {
        bytes32 paramHash = encodeAndSaveParams(params);
        bool allow = _evalParam(paramHash, 0, address(0), address(0), bytes32(0), args);

        Assert.equal(allow, expected, "eval got unexpected result");
    }

    event LogParam(bytes32 param);
    function encodeAndSaveParams(Param[] memory params) internal returns (bytes32) {
        uint256[] memory encodedParams = new uint256[](params.length);

        for (uint256 i = 0; i < params.length; i++) {
            Param memory param = params[i];
            encodedParams[i] = (uint256(param.id) << 248) + (uint256(param.op) << 240) + param.value;
            emit LogParam(bytes32(encodedParams[i]));
        }

        return _saveParams(encodedParams);
    }
}