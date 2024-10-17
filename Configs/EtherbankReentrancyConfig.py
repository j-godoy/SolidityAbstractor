fileName = "EtherbankReentrancy.sol"
contractName = "EtherBank"
functions = [
"addToBalance();",
"withdrawBalance_Init();",
"withdrawBalance_End();",
"dummy_balanceGTZero();",
"dummy_balanceIsZero();",
"dummy_balanceAGTZero();",
"dummy_balanceAIsZero();",
"dummy_balanceNotAGTZero();",
"dummy_balanceNotAIsZero();"
]
statePreconditions = [
"true",
"true",
"senders_reentrant.length > 0",
"balance > 0",
"balance == 0",
"balance_A > 0",
"balance_A == 0",
"balance_NotA > 0",
"balance_NotA == 0"
]
functionPreconditions = [
"true",
"true",
"senders_reentrant[senders_reentrant.length-1] == msg.sender",
"true",
"true",
"true",
"true",
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