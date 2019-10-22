pragma solidity ^0.4.24;


library SafeMath8 {
    string private constant ERROR_ADD_OVERFLOW = "MATH8_ADD_OVERFLOW";
    string private constant ERROR_SUB_UNDERFLOW = "MATH8_SUB_UNDERFLOW";
    string private constant ERROR_MUL_OVERFLOW = "MATH8_MUL_OVERFLOW";
    string private constant ERROR_DIV_ZERO = "MATH8_DIV_ZERO";

    
    function mul(uint8 _a, uint8 _b) internal pure returns (uint8) {
        uint256 c = uint256(_a) * uint256(_b);
        require(c < 256, ERROR_MUL_OVERFLOW);

        return uint8(c);
    }

    
    function div(uint8 _a, uint8 _b) internal pure returns (uint8) {
        require(_b > 0, ERROR_DIV_ZERO); 
        uint8 c = _a / _b;
        

        return c;
    }

    
    function sub(uint8 _a, uint8 _b) internal pure returns (uint8) {
        require(_b <= _a, ERROR_SUB_UNDERFLOW);
        uint8 c = _a - _b;

        return c;
    }

    
    function add(uint8 _a, uint8 _b) internal pure returns (uint8) {
        uint8 c = _a + _b;
        require(c >= _a, ERROR_ADD_OVERFLOW);

        return c;
    }

    
    function mod(uint8 a, uint8 b) internal pure returns (uint8) {
        require(b != 0, ERROR_DIV_ZERO);
        return a % b;
    }
}