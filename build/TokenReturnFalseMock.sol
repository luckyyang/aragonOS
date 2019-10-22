pragma solidity 0.4.24;


contract TokenReturnFalseMock {
    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private allowed;
    uint256 private totalSupply_;
    bool private allowTransfer_;

    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    
    constructor(address initialAccount, uint256 initialBalance) public {
        balances[initialAccount] = initialBalance;
        totalSupply_ = initialBalance;
        allowTransfer_ = true;
    }

    function totalSupply() public view returns (uint256) { return totalSupply_; }

    
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }

    
    function setAllowTransfer(bool _allowTransfer) public {
        allowTransfer_ = _allowTransfer;
    }

    
    function transfer(address _to, uint256 _value) public returns (bool) {
        if (!allowTransfer_ || _to == address(0) || _value > balances[msg.sender]) {
            return false;
        }

        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    
    function approve(address _spender, uint256 _value) public returns (bool) {
        
        if (allowed[msg.sender][_spender] != 0) {
            return false;
        }

        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        if (!allowTransfer_ ||
            _to == address(0) ||
            _value > balances[_from] ||
            _value > allowed[_from][msg.sender]
        ) {
            return false;
        }

        balances[_from] = balances[_from] - _value;
        balances[_to] = balances[_to] + _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}