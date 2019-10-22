pragma solidity 0.4.24;


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

contract ThrowProxy {
  address public target;
  bytes data;

  constructor(address _target) public {
    target = _target;
  }

  
  function() public {
    data = msg.data;
  }

  function assertThrows(string _msg) public {
    Assert.isFalse(execute(), _msg);
  }

  function assertItDoesntThrow(string _msg) public {
    Assert.isTrue(execute(), _msg);
  }

  function execute() public returns (bool) {
    return target.call(data);
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

contract InvalidBytesLengthConversionThrows {
    function tryConvertLength(uint256 _badLength) public {
        bytes memory arr = new bytes(_badLength);

        
        uint256[] memory arrUint = ConversionHelpers.dangerouslyCastBytesToUintArray(arr);
    }
}

contract TestConversionHelpers {
    uint256 constant internal FIRST = uint256(keccak256("0"));
    uint256 constant internal SECOND = uint256(keccak256("1"));
    uint256 constant internal THIRD = uint256(keccak256("2"));

    function testUintArrayConvertedToBytes() public {
        uint256[] memory arr = new uint256[](3);
        arr[0] = FIRST;
        arr[1] = SECOND;
        arr[2] = THIRD;
        uint256 arrLength = arr.length;

        
        bytes memory arrBytes = ConversionHelpers.dangerouslyCastUintArrayToBytes(arr);

        
        Assert.equal(arrBytes.length, arrLength * 32, "should have correct length as bytes array");

        
        assertValues(arrBytes);

        
        uint256 arrMemLoc;
        uint256 arrBytesMemLoc;
        assembly {
            arrMemLoc := arr
            arrBytesMemLoc := arrBytes
        }
        Assert.equal(arrMemLoc, arrBytesMemLoc, "should have same memory location after conversion");
    }

    function testUintArrayIntactIfConvertedBack() public {
        uint256[] memory arr = new uint256[](3);
        arr[0] = FIRST;
        arr[1] = SECOND;
        arr[2] = THIRD;
        uint256 arrLength = arr.length;

        
        bytes memory arrBytes = ConversionHelpers.dangerouslyCastUintArrayToBytes(arr);
        uint256[] memory arrReconverted = ConversionHelpers.dangerouslyCastBytesToUintArray(arrBytes);

        
        Assert.equal(arrLength, arrReconverted.length, "should have correct length after reconverting");

        
        assertValues(arrReconverted);

        
        uint256 arrMemLoc;
        uint256 arrReconvertedMemLoc;
        assembly {
            arrMemLoc := arr
            arrReconvertedMemLoc := arrReconverted
        }
        Assert.equal(arrMemLoc, arrReconvertedMemLoc, "should have same memory location after reconverting");
    }

    function testBytesConvertedToUintArray() public {
        bytes memory arr = new bytes(96);

        
        uint256 first = FIRST;
        uint256 second = SECOND;
        uint256 third = THIRD;
        assembly {
            mstore(add(arr, 0x20), first)
            mstore(add(arr, 0x40), second)
            mstore(add(arr, 0x60), third)
        }
        uint256 arrLength = arr.length;

        
        uint256[] memory arrUint = ConversionHelpers.dangerouslyCastBytesToUintArray(arr);

        
        Assert.equal(arrUint.length, arrLength / 32, "should have correct length as uint256 array");

        
        assertValues(arrUint);

        
        uint256 arrMemLoc;
        uint256 arrUintMemLoc;
        assembly {
            arrMemLoc := arr
            arrUintMemLoc := arrUint
        }
        Assert.equal(arrMemLoc, arrUintMemLoc, "should have same memory location after conversion");
    }

    function testBytesIntactIfConvertedBack() public {
        bytes memory arr = new bytes(96);

        
        uint256 first = FIRST;
        uint256 second = SECOND;
        uint256 third = THIRD;
        assembly {
            mstore(add(arr, 0x20), first)
            mstore(add(arr, 0x40), second)
            mstore(add(arr, 0x60), third)
        }
        uint256 arrLength = arr.length;

        
        uint256[] memory arrUint = ConversionHelpers.dangerouslyCastBytesToUintArray(arr);
        bytes memory arrReconverted = ConversionHelpers.dangerouslyCastUintArrayToBytes(arrUint);

        
        Assert.equal(arrLength, arrReconverted.length, "should have correct length after reconverting");

        
        assertValues(arrReconverted);

        
        uint256 arrMemLoc;
        uint256 arrReconvertedMemLoc;
        assembly {
            arrMemLoc := arr
            arrReconvertedMemLoc := arrReconverted
        }
        Assert.equal(arrMemLoc, arrReconvertedMemLoc, "should have same memory location after reconverting");
    }

    function testBytesConversionThrowsOnInvalidLength() public {
        InvalidBytesLengthConversionThrows thrower = new InvalidBytesLengthConversionThrows();
        ThrowProxy throwProxy = new ThrowProxy(address(thrower));

        InvalidBytesLengthConversionThrows(throwProxy).tryConvertLength(15);
        throwProxy.assertThrows("should have reverted due to invalid length");

        InvalidBytesLengthConversionThrows(throwProxy).tryConvertLength(36);
        throwProxy.assertThrows("should have reverted due to invalid length");

        InvalidBytesLengthConversionThrows(throwProxy).tryConvertLength(61);
        throwProxy.assertThrows("should have reverted due to invalid length");

        InvalidBytesLengthConversionThrows(throwProxy).tryConvertLength(128);
        throwProxy.assertItDoesntThrow("should not have reverted as length was valid");
    }

    function assertValues(uint256[] memory _data) public {
        Assert.equal(_data[0], FIRST, "should have correct index value at 0");
        Assert.equal(_data[1], SECOND, "should have correct index value at 1");
        Assert.equal(_data[2], THIRD, "should have correct index value at 2");
    }

    function assertValues(bytes memory _data) public {
        uint256 first;
        uint256 second;
        uint256 third;
        assembly {
            first := mload(add(_data, 0x20))
            second := mload(add(_data, 0x40))
            third := mload(add(_data, 0x60))
        }
        Assert.equal(first, FIRST, "should have correct first value");
        Assert.equal(second, SECOND, "should have correct second value");
        Assert.equal(third, THIRD, "should have correct third value");
    }
}