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

contract ReentrantActor {
    bool reenterNonReentrant;

    constructor(bool _reenterNonReentrant) public {
        reenterNonReentrant = _reenterNonReentrant;
    }

    function reenter(ReentrancyGuardMock _mock) public {
        
        ReentrantActor reentrancyTarget = ReentrantActor(0);

        if (reenterNonReentrant) {
            _mock.nonReentrantCall(reentrancyTarget);
        } else {
            _mock.reentrantCall(reentrancyTarget);
        }
    }
}

contract ReentrancyGuardMock is ReentrancyGuard {
    using UnstructuredStorage for bytes32;

    uint256 public callCounter;

    function nonReentrantCall(ReentrantActor _target) public nonReentrant {
        callCounter++;
        if (_target != address(0)) {
            _target.reenter(this);
        }
    }

    function reentrantCall(ReentrantActor _target) public {
        callCounter++;
        if (_target != address(0)) {
            _target.reenter(this);
        }
    }

    function setReentrancyMutex(bool _mutex) public {
        getReentrancyMutexPosition().setStorageBool(_mutex);
    }

    function getReentrancyMutexPosition() public pure returns (bytes32) {
        return keccak256("aragonOS.reentrancyGuard.mutex");
    }
}