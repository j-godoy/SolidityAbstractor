/**
 *Submitted for verification at Etherscan.io on 2017-08-04
*/

pragma solidity ^0.5.0;

contract SimpleAuction {
    // 
    // This is an auction where UNICEF is the beneficiary 
    //
    // The highest bidder of this auction is entiteled to Poster Number one of the worlds first Ehtereum funded movie The-Pitt-Circus Movie. 
    // The Poster is a limited editions serigraphy (numbered and signed by the artist).
    // To claim the poster the highest bidder can get in touch with the-pitts-circus.com or send the address an data-field transation to the contract of the beneficiary = 0xb23397f97715118532c8c1207F5678Ed4FbaEA6c after the auction has ended
    // 
    // 
    //
    //Parameters of the auction. Times are either
    // absolute unix timestamps (seconds since 1970-01-01)
    // or time periods in seconds.
    // 
      
    uint public auctionStart;
    uint public biddingTime;

    // Current state of the auction.
    address public highestBidder = address(0x0);
    address public highestBidderA;
    uint public highestBid;
    uint time;

    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;
    uint pendingReturnsCount = 0;

    // Set to true at the end, disallows any change
    bool ended;

    // Events that will be fired on changes.
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    // The following is a so-called natspec comment,
    // recognizable by the three slashes.
    // It will be shown when the user is asked to
    // confirm a transaction.

    /// Create a simple auction with `_biddingTime`
    /// seconds bidding time on behalf of the
    /// beneficiary address `_beneficiary`.
    
    address payable _beneficiary = address(0xb23397f97715118532c8c1207F5678Ed4FbaEA6c);
    // UNICEF Multisig Wallet according to:
    // unicefstories.org/2017/08/04/unicef-ventures-exploring-smart-contracts/
    address payable beneficiary;
    
    constructor(uint _time, uint _biddingTime, uint _auctionStart, address _highestBidderA) public
    {
        time = _time;
        beneficiary = _beneficiary;
        auctionStart = _auctionStart;
        biddingTime = _biddingTime;
        highestBidderA = _highestBidderA;
    }

    /// Bid on the auction with the value sent
    /// together with this transaction.
    /// The value will only be refunded if the
    /// auction is not won.
    function bid() public payable {
        // No arguments are necessary, all
        // information is already part of
        // the transaction. The keyword payable
        // is required for the function to
        // be able to receive Ether.

        // Revert the call if the bidding
        // period is over.
        require(time <= (auctionStart + biddingTime));

        // If the bid is not higher, send the
        // money back.
        require(msg.value > highestBid);

        if (highestBidder != address(0x0)) {
            // Sending back the money by simply using
            // highestBidder.send(highestBid) is a security risk
            // because it can be prevented by the caller by e.g.
            // raising the call stack to 1023. It is always safer
            // to let the recipients withdraw their money themselves.
            if (pendingReturns[highestBidder] == 0){
                pendingReturnsCount += 1;
            }
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        // emit HighestBidIncreased(msg.sender, msg.value);
        t();
    }

    /// Withdraw a bid that was overbid.
    function withdraw() public returns (bool) {
        //time = time + 1;
        require(pendingReturnsCount > 0);
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // It is important to set this to zero because the recipient
            // can call this function again as part of the receiving call
            // before `send` returns.
            pendingReturns[msg.sender] = 0;
            pendingReturnsCount = pendingReturnsCount - 1;

            // if (!msg.sender.send(amount)) {
            //     // No need to call throw here, just reset the amount owing
            //     pendingReturns[msg.sender] = amount;
            //     return false;
            // }
        }
        t();
        return true;
    }
    // Users want to know when the auction ends, seconds from 1970-01-01
    function auctionEndTime() public view returns (uint256) {
        return auctionStart + biddingTime;
    }
    
    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd() public {
        // It is a good guideline to structure functions that interact
        // with other contracts (i.e. they call functions or send Ether)
        // into three phases:
        // 1. checking conditions
        // 2. performing actions (potentially changing conditions)
        // 3. interacting with other contracts
        // If these phases are mixed up, the other contract could call
        // back into the current contract and modify the state or cause
        // effects (ether payout) to be performed multiple times.
        // If functions called internally include interaction with external
        // contracts, they also have to be considered interaction with
        // external contracts.
        // 1. Conditions
        require(time >= (auctionStart + biddingTime)); // auction did not yet end
        require(!ended); // this function has already been called
        // 2. Effects
        ended = true;
        // emit AuctionEnded(highestBidder, highestBid);

        // 3. Interaction
        // beneficiary.transfer(highestBid);
        t();
    }

    function dummy_isEnded() view public {
        require(ended);
    }

    function t() internal {
        time = time + 1;
    }
}