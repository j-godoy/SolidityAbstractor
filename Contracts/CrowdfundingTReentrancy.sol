pragma solidity ^0.5.0;
// import "./Libraries/VeriSolContracts.sol"; 

contract CrowdfundingR {
    address payable owner;
    uint max_block;
    uint goal;
    uint blockNumber;
    
    mapping ( address => uint ) backers;
    // address[] backersArray = new address[](0);
    // address[] auxArray;
    bool funded = false;
    uint balance = 0;
    // uint _cont = 0;
    address _last;
    uint countBackers = 0;
    address[] donadores_reentrada = new address[](0);
    // uint LIMIT = 3;

    // function contractInvariant() private view {
    //     VeriSol.ContractInvariant(backersArray.length <= LIMIT);
    // }

    constructor ( address payable _owner , uint _max_block , uint _goal, uint _blockNumber ) public {
        owner = _owner;
        max_block = _max_block;
        goal = _goal;
        balance = 0;
        blockNumber = _blockNumber;
    }

    function Donate () public payable {
        // require (_donadores < LIMIT);
        require ( max_block > blockNumber);
        require ( backers [msg.sender] == 0);
        backers [msg.sender] = msg.value;
        if (msg.value > 0) {
            // backersArray.push(msg.sender);
            balance = balance + msg.value;
            countBackers += 1;
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

    function Claim_Init () public {
        require (max_block < blockNumber);
        require (backers[msg.sender] > 0 && !funded);
        require (goal > balance);
        require (countBackers > 0);
        uint val = backers[msg.sender];
        // msg.sender.call.value(val)("");
        balance = balance - val;
        donadores_reentrada.push(msg.sender);
        // backers[msg.sender] = 0;
    }

    function Claim_End () public {
        require (donadores_reentrada.length > 0);
        require (donadores_reentrada[donadores_reentrada.length-1] == msg.sender);
        // uint antes = donadores_reentrada.length;
        donadores_reentrada.length--;
        // uint despues = donadores_reentrada.length;
        // assert (antes == despues+1);
        
        if (backers[msg.sender] > 0) {
            countBackers -= 1;
            backers[msg.sender] = 0;
        }
    }

    // function remove(address _valueToFindAndRemove, address[] memory _array) public  returns(address[] memory) {
    //     auxArray = new address[3](0); 
    //     for (uint i = 0; i < _array.length; i++){
    //         if(_array[i] != _valueToFindAndRemove)
    //             auxArray.push(_array[i]);
    //     }
    //     return auxArray;
    // }

    function t() public {
        require(donadores_reentrada.length == 0);
        blockNumber = blockNumber + 1;
    }

    function dummy_balanceGTZero() public { }
    // function dummy_balanceIsZero() public { }

    // function vc1x0x0() payable public {

    //     // Donate
    //     // bool pre_donate = (max_block > blockNumber);

    //     // // Funds
    //     // bool pre_funds = (max_block < blockNumber) && (goal <= balance);

    //     // // Claim init
    //     // // bool pre_claiminit = (max_block < blockNumber) && (!funded) && (goal > balance);// && balance >= VeriSol.SumMapping(backers);
    //     // bool pre_claiminit = (max_block < blockNumber) && (!funded) && (goal > balance) && countBackers > 0;

    //     // // Claim end
    //     // // bool pre_claimend = (_cont > 0);
    //     // bool pre_claimend = (donadores_reentrada.length > 0);

    //     // // tau
    //     // bool pre_tau = (donadores_reentrada.length == 0);

    //     // bool balance_positivo = balance > 0;

    //     // require((!pre_donate && !pre_funds && pre_claiminit && pre_claimend && !pre_tau && balance_positivo));
        
    //     Claim_End();

        

    //     bool pre_donate1 = (max_block > blockNumber);
    //     // Funds
    //     bool pre_funds1 = (max_block < blockNumber) && (goal <= balance);

    //     // Claim init
    //     // bool pre_claiminit1 = (max_block < blockNumber) && (!funded) && (goal > balance) /*&& balance >= VeriSol.SumMapping(backers)*/;
    //     bool pre_claiminit1 = (max_block < blockNumber) && (!funded) && (goal > balance) && countBackers > 0;
    //     // Claim end
    //     bool pre_claimend1 = (donadores_reentrada.length > 0);
    //     // tau
    //     bool pre_tau1 = (donadores_reentrada.length == 0);

    //     bool balance_positivo1 = balance > 0;

    //     assert(!(!pre_donate1 && !pre_funds1 && !pre_claiminit1 && !pre_claimend1 && pre_tau1 && balance_positivo1));
    //     // require(!pre_donate1 && !pre_funds1 && pre_claiminit1 && pre_claimend1 && !pre_tau1 && balance_positivo1);


    //     // Claim_Init();


    //     // bool pre_donate2 = (max_block > blockNumber);
    //     // // Funds
    //     // bool pre_funds2 = (max_block < blockNumber) && (goal <= balance);

    //     // // Claim init
    //     // bool pre_claiminit2 = (max_block < blockNumber) && (!funded) && (goal > balance) && (countBackers > 0);
    //     // // Claim end
    //     // bool pre_claimend2 = (donadores_reentrada.length > 0);
    //     // // tau
    //     // bool pre_tau2 = (donadores_reentrada.length == 0);

    //     // bool balance_positivo2 = balance > 0;

    //     // require((!pre_donate2 && !pre_funds2 && pre_claiminit2 && pre_claimend2 && !pre_tau2 && !balance_positivo2));

    //     // Claim_End();


    //     // bool pre_donate3 = (max_block > blockNumber);
    //     // // Funds
    //     // bool pre_funds3 = (max_block < blockNumber) && (goal <= balance);

    //     // // Claim init
    //     // bool pre_claiminit3 = (max_block < blockNumber) && (!funded) && (goal > balance) && (countBackers > 0);
    //     // // Claim end
    //     // bool pre_claimend3 = (donadores_reentrada.length > 0);
    //     // // tau
    //     // bool pre_tau3 = (donadores_reentrada.length == 0);

    //     // bool balance_positivo3 = balance > 0;

    //     // require((!pre_donate3 && !pre_funds3 && pre_claiminit3 && pre_claimend3 && !pre_tau3 && !balance_positivo3));

    //     // Claim_End();


    //     // bool pre_donate4 = (max_block > blockNumber);
    //     // // Funds
    //     // bool pre_funds4 = (max_block < blockNumber) && (goal <= balance);

    //     // // Claim init
    //     // bool pre_claiminit4 = (max_block < blockNumber) && (!funded) && (goal > balance) && (countBackers > 0);
    //     // // Claim end
    //     // bool pre_claimend4 = (donadores_reentrada.length > 0);
    //     // // tau
    //     // bool pre_tau4 = (donadores_reentrada.length == 0);

    //     // bool balance_positivo4 = balance > 0;

    //     // assert(!(!pre_donate4 && !pre_funds4 && pre_claiminit4 && !pre_claimend4 && pre_tau4 && !balance_positivo4));
    // }
 }