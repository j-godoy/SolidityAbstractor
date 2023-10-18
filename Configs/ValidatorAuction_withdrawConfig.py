fileName = "ValidatorAuction_withdraw.sol"
contractName = "ValidatorAuction_withdraw"
functions = [
"bid();",
"startAuction();",
"depositBids();",
"closeAuction();",
"addToWhitelist(addressToWhitelist);",
"withdrawA();",
"withdrawNoA();",
]
statePreconditions = [
"(countWhitelist > 0 && depositLocker.initialized() && !depositLocker.deposited() && (biddersTotal < maximalNumberOfParticipants) && ((time - startTime) < (100 * 365) && time > startTime && time <= (startTime + auctionDurationInDays * 1)) && auctionState == AuctionState.Started)",
"depositLocker.initialized() && auctionState == AuctionState.Deployed",
"auctionState == AuctionState.DepositPending",
"((biddersTotal < maximalNumberOfParticipants) && (time > (startTime + auctionDurationInDays * 1)) && auctionState == AuctionState.Started)",
"auctionState == AuctionState.Deployed",
"((auctionState == AuctionState.Ended || auctionState == AuctionState.Failed) && countBidders > 0 && hasA)",
"((auctionState == AuctionState.Ended || auctionState == AuctionState.Failed) && countBidders > 0 && (!hasA || countBidders > 1))",
]
functionPreconditions = [
"true",
"true",
"true",
"true",
"true",
"msg.sender == A && bids[msg.sender] > 0",
"msg.sender != A && bids[msg.sender] > 0", 
]
functionVariables = "address addressToWhitelist"
tool_output = "Found a counterexample"

statesModeState = []
statesNamesModeState = []
statePreconditionsModeState = []
txBound = 6