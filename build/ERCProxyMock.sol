pragma solidity 0.4.24;


contract ERCProxy {
    uint256 internal constant FORWARDING = 1;
    uint256 internal constant UPGRADEABLE = 2;

    function proxyType() public pure returns (uint256 proxyTypeId);
    function implementation() public view returns (address codeAddr);
}

contract ERCProxyMock is ERCProxy {
    uint256 public constant FORWARDING = 1;
    uint256 public constant UPGRADEABLE = 2;

    function proxyType() public pure returns (uint256 proxyTypeId) {
        return 0;
    }

    function implementation() public view returns (address codeAddr) {
        return address(0);
    }
}