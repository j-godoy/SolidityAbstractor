type Ref;
type ContractName;
const unique null: Ref;
const unique Reentrance: ContractName;
const unique Reentrance.ReentrantSender: ContractName;
function ConstantToRef(x: int) returns (ret: Ref);
function BoogieRefToInt(x: Ref) returns (ret: int);
function {:bvbuiltin "mod"} modBpl(x: int, y: int) returns (ret: int);
function keccak256(x: int) returns (ret: int);
function abiEncodePacked1(x: int) returns (ret: int);
function _SumMapping_VeriSol(x: [Ref]int) returns (ret: int);
function abiEncodePacked2(x: int, y: int) returns (ret: int);
function abiEncodePacked1R(x: Ref) returns (ret: int);
function abiEncodePacked2R(x: Ref, y: int) returns (ret: int);
var Balance: [Ref]int;
var DType: [Ref]ContractName;
var Alloc: [Ref]bool;
var balance_ADDR: [Ref]int;
var M_Ref_int: [Ref][Ref]int;
var M_int_Ref: [Ref][int]Ref;
var Length: [Ref]int;
var now: int;
procedure {:inline 1} FreshRefGenerator() returns (newRef: Ref);
implementation FreshRefGenerator() returns (newRef: Ref)
{
havoc newRef;
assume ((Alloc[newRef]) == (false));
Alloc[newRef] := true;
assume ((newRef) != (null));
}

procedure {:inline 1} HavocAllocMany();
implementation HavocAllocMany()
{
var oldAlloc: [Ref]bool;
oldAlloc := Alloc;
havoc Alloc;
assume (forall  __i__0_0:Ref ::  ((oldAlloc[__i__0_0]) ==> (Alloc[__i__0_0])));
}

procedure boogie_si_record_sol2Bpl_int(x: int);
procedure boogie_si_record_sol2Bpl_ref(x: Ref);
procedure boogie_si_record_sol2Bpl_bool(x: bool);
procedure {:inline 1} Reentrance.ReentrantSender_ctor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender: Ref, value: int);
implementation Reentrance.ReentrantSender_ctor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender: Ref, value: int)
{
sender_Reentrance.ReentrantSender[this] := sender;
value_Reentrance.ReentrantSender[this] := value;
}


axiom(forall  __i__0_0:int, __i__0_1:int :: {ConstantToRef(__i__0_0), ConstantToRef(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((ConstantToRef(__i__0_0)) != (ConstantToRef(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {keccak256(__i__0_0), keccak256(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((keccak256(__i__0_0)) != (keccak256(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {abiEncodePacked1(__i__0_0), abiEncodePacked1(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1(__i__0_0)) != (abiEncodePacked1(__i__0_1)))));

axiom(forall  __i__0_0:[Ref]int ::  ((exists __i__0_1:Ref ::  ((__i__0_0[__i__0_1]) != (0))) || ((_SumMapping_VeriSol(__i__0_0)) == (0))));

axiom(forall  __i__0_0:[Ref]int, __i__0_1:Ref, __i__0_2:int ::  ((_SumMapping_VeriSol(__i__0_0[__i__0_1 := __i__0_2])) == (((_SumMapping_VeriSol(__i__0_0)) - (__i__0_0[__i__0_1])) + (__i__0_2))));

axiom(forall  __i__0_0:int, __i__0_1:int, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2(__i__0_0, __i__1_0), abiEncodePacked2(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2(__i__0_0, __i__1_0)) != (abiEncodePacked2(__i__0_1, __i__1_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref :: {abiEncodePacked1R(__i__0_0), abiEncodePacked1R(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1R(__i__0_0)) != (abiEncodePacked1R(__i__0_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2R(__i__0_0, __i__1_0), abiEncodePacked2R(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2R(__i__0_0, __i__1_0)) != (abiEncodePacked2R(__i__0_1, __i__1_1)))));
var balances_Reentrance: [Ref]Ref;
var balance_Reentrance: [Ref]int;
var senders_in_mapping_Reentrance: [Ref]int;
var A_Reentrance: [Ref]Ref;
var _last_Reentrance: [Ref]Ref;
var sender_Reentrance.ReentrantSender: [Ref]Ref;
var value_Reentrance.ReentrantSender: [Ref]int;
var senders_reentrant_Reentrance: [Ref]Ref;
procedure {:inline 1} Reentrance_Reentrance_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _A_s33: Ref);
implementation Reentrance_Reentrance_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _A_s33: Ref)
{
var __var_1: Ref;
var __var_2: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// Make array/mapping vars distinct for balances
call __var_1 := FreshRefGenerator();
balances_Reentrance[this] := __var_1;
// Initialize Integer mapping balances
assume (forall  __i__0_0:Ref ::  ((M_Ref_int[balances_Reentrance[this]][__i__0_0]) == (0)));
balance_Reentrance[this] := 0;
senders_in_mapping_Reentrance[this] := 0;
A_Reentrance[this] := null;
_last_Reentrance[this] := null;
// Make array/mapping vars distinct for senders_reentrant
call __var_2 := FreshRefGenerator();
senders_reentrant_Reentrance[this] := __var_2;
assume ((Length[senders_reentrant_Reentrance[this]]) == (0));
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_A"} boogie_si_record_sol2Bpl_ref(_A_s33);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 25} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 26} (true);
A_Reentrance[this] := _A_s33;
call  {:cexpr "A"} boogie_si_record_sol2Bpl_ref(A_Reentrance[this]);
}

procedure {:constructor} {:public} {:inline 1} Reentrance_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _A_s33: Ref);
implementation Reentrance_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _A_s33: Ref)
{
var __var_1: Ref;
var __var_2: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_A"} boogie_si_record_sol2Bpl_ref(_A_s33);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Reentrance_Reentrance_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, _A_s33);
}

procedure {:public} {:inline 1} donate_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s70: Ref);
implementation donate_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s70: Ref)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s70);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
// ---- Logic for payable function START 
assume ((Balance[msgsender_MSG]) >= (msgvalue_MSG));
Balance[msgsender_MSG] := (Balance[msgsender_MSG]) - (msgvalue_MSG);
Balance[this] := (Balance[this]) + (msgvalue_MSG);
// ---- Logic for payable function END 
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 29} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 30} (true);
assume ((msgvalue_MSG) >= (0));
if ((msgvalue_MSG) > (0)) {
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 30} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 31} (true);
assume ((balance_Reentrance[this]) >= (0));
assume ((balance_Reentrance[this]) >= (0));
assume ((msgvalue_MSG) >= (0));
assume (((balance_Reentrance[this]) + (msgvalue_MSG)) >= (0));
balance_Reentrance[this] := (balance_Reentrance[this]) + (msgvalue_MSG);
call  {:cexpr "balance"} boogie_si_record_sol2Bpl_int(balance_Reentrance[this]);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 32} (true);
assume ((M_Ref_int[balances_Reentrance[this]][_to_s70]) >= (0));
if ((M_Ref_int[balances_Reentrance[this]][_to_s70]) == (0)) {
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 32} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 33} (true);
assume ((senders_in_mapping_Reentrance[this]) >= (0));
senders_in_mapping_Reentrance[this] := (senders_in_mapping_Reentrance[this]) + (1);
call  {:cexpr "senders_in_mapping"} boogie_si_record_sol2Bpl_int(senders_in_mapping_Reentrance[this]);
}
}
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 36} (true);
assume ((M_Ref_int[balances_Reentrance[this]][_to_s70]) >= (0));
assume ((msgvalue_MSG) >= (0));
M_Ref_int[balances_Reentrance[this]][_to_s70] := (M_Ref_int[balances_Reentrance[this]][_to_s70]) + (msgvalue_MSG);
call  {:cexpr "balances[_to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_Reentrance[this]][_to_s70]);
}

procedure {:public} {:inline 1} withdraw_Init_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _amount_s104: int);
implementation withdraw_Init_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _amount_s104: int)
{
var __var_3: Ref;
var __var_4: Ref;
var __var_5: int;
var __var_6: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_amount"} boogie_si_record_sol2Bpl_int(_amount_s104);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 43} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 44} (true);
assume ((senders_in_mapping_Reentrance[this]) >= (0));
assume ((senders_in_mapping_Reentrance[this]) > (0));
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 45} (true);
assume ((M_Ref_int[balances_Reentrance[this]][msgsender_MSG]) >= (0));
assume ((_amount_s104) >= (0));
if ((M_Ref_int[balances_Reentrance[this]][msgsender_MSG]) >= (_amount_s104)) {
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 45} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 50} (true);
assume ((balance_Reentrance[this]) >= (0));
assume ((_amount_s104) >= (0));
balance_Reentrance[this] := (balance_Reentrance[this]) - (_amount_s104);
call  {:cexpr "balance"} boogie_si_record_sol2Bpl_int(balance_Reentrance[this]);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 51} (true);
call __var_4 := FreshRefGenerator();
assume ((_amount_s104) >= (0));
assume ((DType[__var_4]) == (Reentrance.ReentrantSender));
call Reentrance.ReentrantSender_ctor(__var_4, this, 0, msgsender_MSG, _amount_s104);
__var_3 := __var_4;
__var_6 := Length[senders_reentrant_Reentrance[this]];
M_int_Ref[senders_reentrant_Reentrance[this]][__var_6] := __var_3;
Length[senders_reentrant_Reentrance[this]] := (__var_6) + (1);
}
}

procedure {:public} {:inline 1} withdraw_End_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation withdraw_End_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var value_s173: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 59} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 60} (true);
assume ((Length[senders_reentrant_Reentrance[this]]) >= (0));
assume ((Length[senders_reentrant_Reentrance[this]]) > (0));
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 61} (true);
assume ((Length[senders_reentrant_Reentrance[this]]) >= (0));
assume (((Length[senders_reentrant_Reentrance[this]]) - (1)) >= (0));
assume ((sender_Reentrance.ReentrantSender[M_int_Ref[senders_reentrant_Reentrance[this]][(Length[senders_reentrant_Reentrance[this]]) - (1)]]) == (msgsender_MSG));
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 62} (true);
assume ((value_s173) >= (0));
assume ((Length[senders_reentrant_Reentrance[this]]) >= (0));
assume (((Length[senders_reentrant_Reentrance[this]]) - (1)) >= (0));
assume ((value_Reentrance.ReentrantSender[M_int_Ref[senders_reentrant_Reentrance[this]][(Length[senders_reentrant_Reentrance[this]]) - (1)]]) >= (0));
value_s173 := value_Reentrance.ReentrantSender[M_int_Ref[senders_reentrant_Reentrance[this]][(Length[senders_reentrant_Reentrance[this]]) - (1)]];
call  {:cexpr "value"} boogie_si_record_sol2Bpl_int(value_s173);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 63} (true);
assume ((Length[senders_reentrant_Reentrance[this]]) >= (0));
Length[senders_reentrant_Reentrance[this]] := (Length[senders_reentrant_Reentrance[this]]) - (1);
call  {:cexpr "senders_reentrant.length"} boogie_si_record_sol2Bpl_int(Length[senders_reentrant_Reentrance[this]]);
assume ((Length[senders_reentrant_Reentrance[this]]) >= (0));
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 65} (true);
assume ((M_Ref_int[balances_Reentrance[this]][msgsender_MSG]) >= (0));
if ((M_Ref_int[balances_Reentrance[this]][msgsender_MSG]) > (0)) {
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 65} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 66} (true);
assume ((M_Ref_int[balances_Reentrance[this]][msgsender_MSG]) >= (0));
assume ((value_s173) >= (0));
M_Ref_int[balances_Reentrance[this]][msgsender_MSG] := (M_Ref_int[balances_Reentrance[this]][msgsender_MSG]) - (value_s173);
call  {:cexpr "balances[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_Reentrance[this]][msgsender_MSG]);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 67} (true);
assume ((value_s173) >= (0));
assume ((M_Ref_int[balances_Reentrance[this]][msgsender_MSG]) >= (0));
if (((value_s173) > (0)) && ((M_Ref_int[balances_Reentrance[this]][msgsender_MSG]) == (0))) {
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 67} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 68} (true);
assume ((senders_in_mapping_Reentrance[this]) >= (0));
senders_in_mapping_Reentrance[this] := (senders_in_mapping_Reentrance[this]) - (1);
call  {:cexpr "senders_in_mapping"} boogie_si_record_sol2Bpl_int(senders_in_mapping_Reentrance[this]);
}
}
}

procedure {:public} {:inline 1} vc1x0x0_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, A_s219: Ref, _amount_s219: int, _to_s219: Ref);
implementation vc1x0x0_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, A_s219: Ref, _amount_s219: int, _to_s219: Ref)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "A"} boogie_si_record_sol2Bpl_ref(A_s219);
call  {:cexpr "_amount"} boogie_si_record_sol2Bpl_int(_amount_s219);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s219);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
// ---- Logic for payable function START 
assume ((Balance[msgsender_MSG]) >= (msgvalue_MSG));
Balance[msgsender_MSG] := (Balance[msgsender_MSG]) - (msgvalue_MSG);
Balance[this] := (Balance[this]) + (msgvalue_MSG);
// ---- Logic for payable function END 
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 82} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 83} (true);
assume ((senders_in_mapping_Reentrance[this]) >= (0));
assume ((Length[senders_reentrant_Reentrance[this]]) >= (0));
assume ((balance_Reentrance[this]) >= (0));
assume ((M_Ref_int[balances_Reentrance[this]][A_s219]) >= (0));
assume (((((true) && ((senders_in_mapping_Reentrance[this]) > (0))) && (!(((Length[senders_reentrant_Reentrance[this]]) > (0))))) && (!(((balance_Reentrance[this]) > (0))))) && ((M_Ref_int[balances_Reentrance[this]][A_s219]) > (0)));
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 84} (true);
assume (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 85} (true);
assert (false);
}

procedure {:public} {:inline 1} dummy_balanceGTZero_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation dummy_balanceGTZero_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 88} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 88} (true);
assume ((balance_Reentrance[this]) >= (0));
assume ((balance_Reentrance[this]) > (0));
}

procedure {:public} {:inline 1} dummy_balanceAGTZero_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation dummy_balanceAGTZero_Reentrance(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 90} (true);
assert {:first} {:sourceFile "D:\Documentos\Git\SolidityAbstractor\Contracts\ReentranceReentrancy.sol"} {:sourceLine 90} (true);
assume ((M_Ref_int[balances_Reentrance[this]][A_Reentrance[this]]) >= (0));
assume ((M_Ref_int[balances_Reentrance[this]][A_Reentrance[this]]) > (0));
}

procedure {:inline 1} FallbackDispatch(from: Ref, to: Ref, amount: int);
implementation FallbackDispatch(from: Ref, to: Ref, amount: int)
{
if ((DType[to]) == (Reentrance)) {
assume ((amount) == (0));
} else {
call Fallback_UnknownType(from, to, amount);
}
}

procedure {:inline 1} Fallback_UnknownType(from: Ref, to: Ref, amount: int);
implementation Fallback_UnknownType(from: Ref, to: Ref, amount: int)
{
// ---- Logic for payable function START 
assume ((Balance[from]) >= (amount));
Balance[from] := (Balance[from]) - (amount);
Balance[to] := (Balance[to]) + (amount);
// ---- Logic for payable function END 
}

procedure {:inline 1} send(from: Ref, to: Ref, amount: int) returns (success: bool);
implementation send(from: Ref, to: Ref, amount: int) returns (success: bool)
{
if ((Balance[from]) >= (amount)) {
call FallbackDispatch(from, to, amount);
success := true;
} else {
success := false;
}
}

const {:existential true} HoudiniB1_Reentrance: bool;
const {:existential true} HoudiniB2_Reentrance: bool;
const {:existential true} HoudiniB3_Reentrance: bool;
const {:existential true} HoudiniB4_Reentrance: bool;
const {:existential true} HoudiniB5_Reentrance: bool;
const {:existential true} HoudiniB6_Reentrance: bool;
procedure BoogieEntry_Reentrance();
implementation BoogieEntry_Reentrance()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var _A_s33: Ref;
var _to_s70: Ref;
var _amount_s104: int;
var A_s219: Ref;
var _amount_s219: int;
var _to_s219: Ref;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (Reentrance));
call Reentrance_Reentrance(this, msgsender_MSG, msgvalue_MSG, _A_s33);
while (true)
  invariant (HoudiniB1_Reentrance) ==> ((A_Reentrance[this]) == (null));
  invariant (HoudiniB2_Reentrance) ==> ((A_Reentrance[this]) != (null));
  invariant (HoudiniB3_Reentrance) ==> ((_last_Reentrance[this]) == (null));
  invariant (HoudiniB4_Reentrance) ==> ((_last_Reentrance[this]) != (null));
  invariant (HoudiniB5_Reentrance) ==> ((A_Reentrance[this]) == (_last_Reentrance[this]));
  invariant (HoudiniB6_Reentrance) ==> ((A_Reentrance[this]) != (_last_Reentrance[this]));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc _A_s33;
havoc _to_s70;
havoc _amount_s104;
havoc A_s219;
havoc _amount_s219;
havoc _to_s219;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Reentrance));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call donate_Reentrance(this, msgsender_MSG, msgvalue_MSG, _to_s70);
} else if ((choice) == (5)) {
call withdraw_Init_Reentrance(this, msgsender_MSG, msgvalue_MSG, _amount_s104);
} else if ((choice) == (4)) {
call withdraw_End_Reentrance(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call vc1x0x0_Reentrance(this, msgsender_MSG, msgvalue_MSG, A_s219, _amount_s219, _to_s219);
} else if ((choice) == (2)) {
call dummy_balanceGTZero_Reentrance(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (1)) {
call dummy_balanceAGTZero_Reentrance(this, msgsender_MSG, msgvalue_MSG);
}
}
}

procedure CorralChoice_Reentrance(this: Ref);
implementation CorralChoice_Reentrance(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var _A_s33: Ref;
var _to_s70: Ref;
var _amount_s104: int;
var A_s219: Ref;
var _amount_s219: int;
var _to_s219: Ref;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc _A_s33;
havoc _to_s70;
havoc _amount_s104;
havoc A_s219;
havoc _amount_s219;
havoc _to_s219;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Reentrance));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call donate_Reentrance(this, msgsender_MSG, msgvalue_MSG, _to_s70);
} else if ((choice) == (5)) {
call withdraw_Init_Reentrance(this, msgsender_MSG, msgvalue_MSG, _amount_s104);
} else if ((choice) == (4)) {
call withdraw_End_Reentrance(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call vc1x0x0_Reentrance(this, msgsender_MSG, msgvalue_MSG, A_s219, _amount_s219, _to_s219);
} else if ((choice) == (2)) {
call dummy_balanceGTZero_Reentrance(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (1)) {
call dummy_balanceAGTZero_Reentrance(this, msgsender_MSG, msgvalue_MSG);
}
}

procedure CorralEntry_Reentrance();
implementation CorralEntry_Reentrance()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var _A_s33: Ref;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (Reentrance));
call Reentrance_Reentrance(this, msgsender_MSG, msgvalue_MSG, _A_s33);
while (true)
{
call CorralChoice_Reentrance(this);
}
}


