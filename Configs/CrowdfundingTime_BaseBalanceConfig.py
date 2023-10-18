fileName = "CrowdfundingT_BaseBalance.sol"
contractName = "CrowdfundingBase"
functions = [
"Donate();",
"GetFunds();",
"Claim();",
"dummy_balanceGTZero();",
"dummy_balanceIsZero();",
"t(n);",
]
statePreconditions = [
"(max_block > blockNumber)",
"(max_block < blockNumber && goal <= balance)",
"(max_block < blockNumber && !funded && goal > balance && countBackers > 0)",
"balance > 0",
"balance == 0",
"true",
]
functionPreconditions = [
"true",
"true",
"true",
"true",
"true",
"true"
]
functionVariables = "uint n"
tool_output = "Found a counterexample"

statesModeState = []
statesNamesModeState = []
statePreconditionsModeState = []

# epaExtraConditions = "address(this).balance == 0"
txBound = 10