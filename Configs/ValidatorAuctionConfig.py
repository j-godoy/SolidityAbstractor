fileName = "ValidatorAuction.sol"
contractName = "ValidatorAuction"
functions = [
"bid();",
"startAuction();",
"depositBids();",
"closeAuction();",
"addToWhitelist(addressToWhitelist);",
"withdraw();",
]
statePreconditions = [
"(countWhitelist > 0 && depositLocker.initialized() && !depositLocker.deposited() && (biddersTotal < maximalNumberOfParticipants) && ((time - startTime) < (100 * 365) && time > startTime && time <= (startTime + auctionDurationInDays * 1)) && auctionState == AuctionState.Started)",
"depositLocker.initialized() && auctionState == AuctionState.Deployed",
"auctionState == AuctionState.DepositPending",
"((biddersTotal < maximalNumberOfParticipants) && (time > (startTime + auctionDurationInDays * 1)) && auctionState == AuctionState.Started)",
"auctionState == AuctionState.Deployed",
"countBidders > 0 && (auctionState == AuctionState.Ended || auctionState == AuctionState.Failed)",
]
functionPreconditions = [
"true",
"true",
"true",
"true",
"true",
"true",
]
functionVariables = "address addressToWhitelist"
tool_output = "Found a counterexample"

statesModeState = [[1,0,0,0,0,0,0,0,0,0], [0,2,0,0,0,0,0,0,0,0], [0,0,3,0,0,0,0,0,0,0], [0,0,0,4,0,0,0,0,0,0], [0,0,0,0,5,0,0,0,0,0], [0,0,0,0,0,6,0,0,0,0], [0,0,0,0,0,0,7,0,0,0], [0,0,0,0,0,0,0,8,0,0], [0,0,0,0,0,0,0,0,9,0], [0,0,0,0,0,0,0,0,0,10]]
statesNamesModeState = ["Active", "OfferPlaced", "PendingInspection", "Inspected", "Appraised", "NotionalAcceptance", "BuyerAccepted", "SellerAccepted", "Accepted", "Terminated"]
statePreconditionsModeState = ["State == StateType.Active", 
"State == StateType.OfferPlaced", 
"State == StateType.PendingInspection", 
"State == StateType.Inspected",
"State == StateType.Appraised",
"State == StateType.NotionalAcceptance",
"State == StateType.BuyerAccepted",
"State == StateType.SellerAccepted",
"State == StateType.Accepted",
"State == StateType.Terminated"]
txBound = 6