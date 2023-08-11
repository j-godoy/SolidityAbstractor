pragma solidity ^0.5.0;

contract CrowdfundingBase {
    address payable owner;
    uint max_block;
    uint goal;
    uint256 blockNumber;
    
    mapping ( address => uint ) backers;
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

    function Donate (uint256 n) public payable {
        require ( max_block > blockNumber);
        require ( backers [msg.sender] == 0);
        backers [msg.sender] = msg.value;
        if (msg.value > 0) {
            countBackers += 1;
            balance = balance + msg.value;
        }
        t(n);
    }

    function GetFunds (uint n) public {
        require (max_block < blockNumber);
        require (msg.sender == owner);
        require (goal <= balance);
        // owner.call.value(balance)("");
        funded = true;
        balance = 0;
        t(n);
    }

    function Claim (uint n) public {
        require (max_block < blockNumber);
        require (backers[msg.sender] > 0 && !funded);
        require (goal > balance);
        require (countBackers > 0);
        uint val = backers[msg.sender];
        // msg.sender.call.value(val)("");
        backers[msg.sender] = 0;
        countBackers -= 1;
        balance = balance - val;
        t(n);
    }

    function t(uint n) internal {
        require(n >= 0 && n <= 2);
        blockNumber = blockNumber + n;
    }

    // function Si_to_Se_from_f(uint n) public {
    // // Donate
    // bool pre_donate = (max_block > blockNumber);

    // // Funds
    // bool pre_funds = (max_block < blockNumber) && (goal <= balance);

    // // Claim
    // bool pre_claim = (max_block < blockNumber) && (!funded) && (goal > balance) && countBackers > 0;


    // // // tau
    // // bool pre_tau = true;

    // bool balance_positivo = balance > 0;

	// require(!pre_donate);
    // require(!pre_funds);
    // require(pre_claim);
    // // require(balance_positivo);
		
    // Claim(n);
	
    // //Donate
    // bool pre_donate1 = (max_block > blockNumber);
    // // Funds
    // bool pre_funds1 = (max_block < blockNumber) && (goal <= balance);
    // // Claim
    // bool pre_claim1 = (max_block < blockNumber) && (!funded) && (goal > balance) && countBackers > 0;

    // // bool balance_positivo1 = balance > 0;
    
    // bool final_state = !pre_donate1 && !pre_funds1 && !pre_claim1 && balance > 0;
    // assert(!final_state);
	// }

 }