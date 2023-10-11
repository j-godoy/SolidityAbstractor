pragma solidity ^0.5.0;

// bugs:
// 1. Auction can never end
// 2. highest bidder can never be refunded their highest bid

contract Auction {
    uint auctionStart;
    uint biddingTime;
    address payable beneficiary;

    bool ended = false;
    address payable highestBidder = address(0x0);
    uint highestBid = 0;
    mapping(address => uint) pendingReturns;
    uint pendingReturnsCount = 0;
    uint blockNumber;
    address A;
    bool hasA = false;

    constructor(uint _auctionStart, uint _biddingTime, address payable _beneficiary,  uint _blockNumber, address _A) public {
        auctionStart = _auctionStart;
        biddingTime = _biddingTime;
        beneficiary = _beneficiary;
        blockNumber = _blockNumber;
        // require(_A == address(0x0));
        A = _A;
    }

    function BidA() public payable {
        require(msg.sender == A);
        uint end = auctionStart + biddingTime;
        if(end < blockNumber || ended) {
            revert();
        }
        else {
            if(msg.value <= highestBid) {
                revert();
            }
            else {
                if (highestBidder != address(0x0) && pendingReturns[highestBidder] == 0) {
                    pendingReturnsCount += 1;
                }
                pendingReturns[highestBidder] += highestBid;
                highestBidder = msg.sender;
                highestBid = msg.value;
                hasA = true;
            }
        }
    }

    function BidNotA() public payable {
        require(msg.sender != A);
        uint end = auctionStart + biddingTime;
        if(end < blockNumber || ended) {
            revert();
        }
        else {
            if(msg.value <= highestBid) {
                revert();
            }
            else {
                if (highestBidder != address(0x0) && pendingReturns[highestBidder] == 0) {
                    pendingReturnsCount += 1;
                }
                pendingReturns[highestBidder] += highestBid;
                highestBidder = msg.sender;
                highestBid = msg.value;
            }
        }
    }

    function WithdrawA() public {
        uint end = auctionStart + biddingTime;
        require(blockNumber > end);
        require(hasA && msg.sender == A);
        require(!ended);
        if(pendingReturns[msg.sender] != 0 && pendingReturnsCount > 0) {
            uint pr = pendingReturns[msg.sender];
            pendingReturns[msg.sender] = 0;
            pendingReturnsCount -= 1;
            //msg.sender.transfer(pr);
            hasA = false;
        }
        else {
            revert();
        }
        
    }

    function WithdrawNotA() public {
        uint end = auctionStart + biddingTime;
        require(blockNumber > end);
        require(!ended);
        require(A != msg.sender && (!hasA || pendingReturnsCount > 1));
        if(pendingReturns[msg.sender] != 0 && pendingReturnsCount > 0) {
            uint pr = pendingReturns[msg.sender];
            pendingReturns[msg.sender] = 0;
            pendingReturnsCount -= 1;
            //msg.sender.transfer(pr);
        }
        else {
            revert();
        }
        
    }

    function AuctionEnd() public {
        uint end = auctionStart + biddingTime;

        //!ended is a bug
        //if(blockNumber <= end || !ended) {
        if(blockNumber <= end || ended) {//FIXED

            revert();
        }
        else {
            ended = true;
            //beneficiary.transfer(highestBid);
        }
    }

    function t() public {
        blockNumber = blockNumber + 1;
    }

    // function query_auctionEnd() public {
    //     bool pre_BidA = (!ended && (auctionStart + biddingTime) >= blockNumber);
    //     bool pre_BidNotA = (!ended && (auctionStart + biddingTime) >= blockNumber);
    //     bool pre_WithdrawA = !ended && pendingReturnsCount > 0 && hasA && blockNumber > (auctionStart + biddingTime);
    //     bool pre_WithdrawNotA = !ended && pendingReturnsCount > 0 && (!hasA || pendingReturnsCount > 1) && blockNumber > (auctionStart + biddingTime);
    //     bool pre_AuctionEnd = (!ended && blockNumber > (auctionStart + biddingTime));
    //     bool pre_t = true;
    //     require(!pre_BidA && !pre_BidNotA && !pre_WithdrawA  && pre_WithdrawNotA && pre_AuctionEnd && pre_t);

    //     WithdrawNotA();

    //     bool pre_BidA2 = (!ended && (auctionStart + biddingTime) >= blockNumber);
    //     bool pre_BidNotA2 = (!ended && (auctionStart + biddingTime) >= blockNumber);
    //     bool pre_WithdrawA2 = !ended && pendingReturnsCount > 0 && hasA && blockNumber > (auctionStart + biddingTime);
    //     bool pre_WithdrawNotA2 = !ended && pendingReturnsCount > 0 && (!hasA || pendingReturnsCount > 1) && blockNumber > (auctionStart + biddingTime);
    //     bool pre_AuctionEnd2 = (!ended && blockNumber > (auctionStart + biddingTime));
    //     bool pre_t2 = true;
        
    //     assert((!pre_BidA2 && !pre_BidNotA2 && !pre_WithdrawA2  && pre_WithdrawNotA2 && pre_AuctionEnd2 && pre_t2));
    // }
}