pragma solidity 0.4.24;


contract EtherTokenConstant {
    address internal constant ETH = address(0);
}

contract EtherTokenConstantMock is EtherTokenConstant {
    function getETHConstant() external pure returns (address) { return ETH; }
}