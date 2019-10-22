pragma solidity 0.4.24;


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

contract TimeHelpersMock is TimeHelpers {
    function getBlockNumberDirect() public view returns (uint256) {
        return block.number;
    }

    function getBlockNumberExt() public view returns (uint256) {
        return getBlockNumber();
    }

    function getBlockNumber64Ext() public view returns (uint64) {
        return getBlockNumber64();
    }

    function getTimestampDirect() public view returns (uint256) {
        return now;
    }

    function getTimestampExt() public view returns (uint256) {
        return getTimestamp();
    }

    function getTimestamp64Ext() public view returns (uint64) {
        return getTimestamp64();
    }
}