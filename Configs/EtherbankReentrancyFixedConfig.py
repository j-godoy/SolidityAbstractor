fileName = "EtherbankReentrancyFixed.sol"
contractName = "EtherBank"
functions = [
"addToBalance();",
"withdrawBalance_Init();",
"withdrawBalance_End();",
"dummy_balanceGTZero();",
"dummy_balanceIsZero();"
]
statePreconditions = [
"true",
"balance > 0",
"senders_reentrant.length > 0",
"balance > 0",
"balance == 0"
]
functionPreconditions = [
"true",
"true",
"senders_reentrant[senders_reentrant.length-1] == msg.sender",
"true",
"true"
]
functionVariables = ""
# functionVariables = "uint n"
tool_output = "Found a counterexample"

statesModeState = []
statesNamesModeState = []
statePreconditionsModeState = []

# epaExtraConditions = "address(this).balance == 0"
txBound = 10