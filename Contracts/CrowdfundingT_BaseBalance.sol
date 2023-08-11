pragma solidity ^0.5.0;

contract CrowdfundingBase {
    address payable owner;
    uint max_block;
    uint goal;
    uint blockNumber;
    
    mapping ( address => uint ) backers;
    // address[] backersArray = new address[](0);
    // address[] auxArray;
    uint countBackers = 0;
    bool funded = false;
    uint balance = 0;

    constructor ( address payable _owner , uint _max_block , uint _goal, uint _blockNumber) public {
        owner = _owner;
        max_block = _max_block;
        goal = _goal;
        balance = 0;
        blockNumber = _blockNumber;
    }

    function Donate () public payable {
        require ( max_block > blockNumber);
        require ( backers [msg.sender] == 0);
        backers [msg.sender] = msg.value;
        if (msg.value > 0) {
            // backersArray.push(msg.sender);
            countBackers += 1;
            balance = balance + msg.value;
        }
    }

    function GetFunds () public {
        require (max_block < blockNumber);
        require (msg.sender == owner);
        require (goal <= balance);
        // owner.call.value(balance)("");
        funded = true;
        balance = 0;
    }

    function Claim () public {
        require (max_block < blockNumber);
        require (backers[msg.sender] > 0 && !funded);
        require (goal > balance);
        // require (backersArray.length > 0);
        require (countBackers > 0);
        uint val = backers[msg.sender];
        // msg.sender.call.value(val)("");
        backers[msg.sender] = 0;
        countBackers -= 1;
        // backersArray = remove(msg.sender, backersArray);
        balance = balance - val;
    }

    // function remove(address _valueToFindAndRemove, address[] memory _array) public  returns(address[] memory) {
    //     auxArray = new address[](0); 
    //     for (uint i = 0; i < _array.length; i++){
    //         if(_array[i] != _valueToFindAndRemove)
    //             auxArray.push(_array[i]);
    //     }
    //     return auxArray;
    // }

    // function dummy_balanceGTZero() public { }
    // function dummy_balanceIsZero() public { }

    function t() public {
        blockNumber = blockNumber + 1;
    }
 }