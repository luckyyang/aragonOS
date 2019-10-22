pragma solidity ^0.4.0;


interface AbstractENS {
    function owner(bytes32 _node) public constant returns (address);
    function resolver(bytes32 _node) public constant returns (address);
    function ttl(bytes32 _node) public constant returns (uint64);
    function setOwner(bytes32 _node, address _owner) public;
    function setSubnodeOwner(bytes32 _node, bytes32 label, address _owner) public;
    function setResolver(bytes32 _node, address _resolver) public;
    function setTTL(bytes32 _node, uint64 _ttl) public;

    
    event NewOwner(bytes32 indexed _node, bytes32 indexed _label, address _owner);

    
    event Transfer(bytes32 indexed _node, address _owner);

    
    event NewResolver(bytes32 indexed _node, address _resolver);

    
    event NewTTL(bytes32 indexed _node, uint64 _ttl);
}

contract ENS is AbstractENS {
    struct Record {
        address owner;
        address resolver;
        uint64 ttl;
    }

    mapping(bytes32=>Record) records;

    
    modifier only_owner(bytes32 node) {
        if (records[node].owner != msg.sender) throw;
        _;
    }

    
    function ENS() public {
        records[0].owner = msg.sender;
    }

    
    function owner(bytes32 node) public constant returns (address) {
        return records[node].owner;
    }

    
    function resolver(bytes32 node) public constant returns (address) {
        return records[node].resolver;
    }

    
    function ttl(bytes32 node) public constant returns (uint64) {
        return records[node].ttl;
    }

    
    function setOwner(bytes32 node, address owner) only_owner(node) public {
        Transfer(node, owner);
        records[node].owner = owner;
    }

    
    function setSubnodeOwner(bytes32 node, bytes32 label, address owner) only_owner(node) public {
        var subnode = keccak256(node, label);
        NewOwner(node, label, owner);
        records[subnode].owner = owner;
    }

    
    function setResolver(bytes32 node, address resolver) only_owner(node) public {
        NewResolver(node, resolver);
        records[node].resolver = resolver;
    }

    
    function setTTL(bytes32 node, uint64 ttl) only_owner(node) public {
        NewTTL(node, ttl);
        records[node].ttl = ttl;
    }
}