type Ref;
type ContractName;
const unique null: Ref;
const unique Ownable: ContractName;
const unique DepositLockerInterface: ContractName;
const unique DepositLocker: ContractName;
const unique ValidatorAuction: ContractName;
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
var M_Ref_bool: [Ref][Ref]bool;
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

axiom(forall  __i__0_0:int, __i__0_1:int :: {ConstantToRef(__i__0_0), ConstantToRef(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((ConstantToRef(__i__0_0)) != (ConstantToRef(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {keccak256(__i__0_0), keccak256(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((keccak256(__i__0_0)) != (keccak256(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {abiEncodePacked1(__i__0_0), abiEncodePacked1(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1(__i__0_0)) != (abiEncodePacked1(__i__0_1)))));

axiom(forall  __i__0_0:[Ref]int ::  ((exists __i__0_1:Ref ::  ((__i__0_0[__i__0_1]) != (0))) || ((_SumMapping_VeriSol(__i__0_0)) == (0))));

axiom(forall  __i__0_0:[Ref]int, __i__0_1:Ref, __i__0_2:int ::  ((_SumMapping_VeriSol(__i__0_0[__i__0_1 := __i__0_2])) == (((_SumMapping_VeriSol(__i__0_0)) - (__i__0_0[__i__0_1])) + (__i__0_2))));

axiom(forall  __i__0_0:int, __i__0_1:int, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2(__i__0_0, __i__1_0), abiEncodePacked2(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2(__i__0_0, __i__1_0)) != (abiEncodePacked2(__i__0_1, __i__1_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref :: {abiEncodePacked1R(__i__0_0), abiEncodePacked1R(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1R(__i__0_0)) != (abiEncodePacked1R(__i__0_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2R(__i__0_0, __i__1_0), abiEncodePacked2R(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2R(__i__0_0, __i__1_0)) != (abiEncodePacked2R(__i__0_1, __i__1_1)))));
var owner_Ownable: [Ref]Ref;
procedure {:inline 1} Ownable_Ownable_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Ownable_Ownable_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
owner_Ownable[this] := null;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 12} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 13} (true);
owner_Ownable[this] := msgsender_MSG;
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_Ownable[this]);
}

procedure {:constructor} {:public} {:inline 1} Ownable_Ownable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Ownable_Ownable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Ownable_Ownable_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} transferOwnership_Ownable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, newOwner_s43: Ref);
implementation transferOwnership_Ownable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, newOwner_s43: Ref)
{
var __var_1: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "newOwner"} boogie_si_record_sol2Bpl_ref(newOwner_s43);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call onlyOwner_pre(this, msgsender_MSG, msgvalue_MSG);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 24} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 25} (true);
__var_1 := null;
if ((newOwner_s43) != (null)) {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 25} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 26} (true);
owner_Ownable[this] := newOwner_s43;
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_Ownable[this]);
}
}

procedure {:inline 1} DepositLockerInterface_DepositLockerInterface_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation DepositLockerInterface_DepositLockerInterface_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} DepositLockerInterface_DepositLockerInterface(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation DepositLockerInterface_DepositLockerInterface(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 31} (true);
call DepositLockerInterface_DepositLockerInterface_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} slash_DepositLockerInterface(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _depositorToBeSlashed_s49: Ref);
procedure {:inline 1} DepositLocker_DepositLocker_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation DepositLocker_DepositLocker_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_2: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
initialized_DepositLocker[this] := false;
deposited_DepositLocker[this] := false;
slasher_DepositLocker[this] := null;
depositorsProxy_DepositLocker[this] := null;
releaseTimestamp_DepositLocker[this] := 0;
// Make array/mapping vars distinct for canWithdraw
call __var_2 := FreshRefGenerator();
canWithdraw_DepositLocker[this] := __var_2;
// Initialize Boolean mapping canWithdraw
assume (forall  __i__0_0:Ref ::  (!(M_Ref_bool[canWithdraw_DepositLocker[this]][__i__0_0])));
numberOfDepositors_DepositLocker[this] := 0;
valuePerDepositor_DepositLocker[this] := 0;
// end of initialization
}

procedure {:inline 1} DepositLocker_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation DepositLocker_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 36} (true);
call DepositLockerInterface_DepositLockerInterface(this, msgsender_MSG, msgvalue_MSG);
call Ownable_Ownable(this, msgsender_MSG, msgvalue_MSG);
call DepositLocker_DepositLocker_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

var initialized_DepositLocker: [Ref]bool;
var deposited_DepositLocker: [Ref]bool;
var slasher_DepositLocker: [Ref]Ref;
var depositorsProxy_DepositLocker: [Ref]Ref;
var releaseTimestamp_DepositLocker: [Ref]int;
var canWithdraw_DepositLocker: [Ref]Ref;
var numberOfDepositors_DepositLocker: [Ref]int;
var valuePerDepositor_DepositLocker: [Ref]int;
procedure {:inline 1} FallbackMethod_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation FallbackMethod_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 90} (true);
}

procedure {:public} {:inline 1} init_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _releaseTimestamp_s192: int, _slasher_s192: Ref, _depositorsProxy_s192: Ref);
implementation init_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _releaseTimestamp_s192: int, _slasher_s192: Ref, _depositorsProxy_s192: Ref)
{
var __var_3: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_releaseTimestamp"} boogie_si_record_sol2Bpl_int(_releaseTimestamp_s192);
call  {:cexpr "_slasher"} boogie_si_record_sol2Bpl_ref(_slasher_s192);
call  {:cexpr "_depositorsProxy"} boogie_si_record_sol2Bpl_ref(_depositorsProxy_s192);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call onlyOwner_pre(this, msgsender_MSG, msgvalue_MSG);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 96} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 97} (true);
assume (!(initialized_DepositLocker[this]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 98} (true);
assume ((_releaseTimestamp_s192) >= (0));
assume ((now) >= (0));
assume ((_releaseTimestamp_s192) > (now));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 103} (true);
assume ((releaseTimestamp_DepositLocker[this]) >= (0));
assume ((_releaseTimestamp_s192) >= (0));
releaseTimestamp_DepositLocker[this] := _releaseTimestamp_s192;
call  {:cexpr "releaseTimestamp"} boogie_si_record_sol2Bpl_int(releaseTimestamp_DepositLocker[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 104} (true);
slasher_DepositLocker[this] := _slasher_s192;
call  {:cexpr "slasher"} boogie_si_record_sol2Bpl_ref(slasher_DepositLocker[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 105} (true);
depositorsProxy_DepositLocker[this] := _depositorsProxy_s192;
call  {:cexpr "depositorsProxy"} boogie_si_record_sol2Bpl_ref(depositorsProxy_DepositLocker[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 106} (true);
initialized_DepositLocker[this] := true;
call  {:cexpr "initialized"} boogie_si_record_sol2Bpl_bool(initialized_DepositLocker[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 107} (true);
__var_3 := null;
owner_Ownable[this] := __var_3;
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_Ownable[this]);
}

procedure {:public} {:inline 1} registerDepositor_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _depositor_s228: Ref);
implementation registerDepositor_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _depositor_s228: Ref)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_depositor"} boogie_si_record_sol2Bpl_ref(_depositor_s228);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call isInitialised_pre(this, msgsender_MSG, msgvalue_MSG);
call isNotDeposited_pre(this, msgsender_MSG, msgvalue_MSG);
call onlyDepositorsProxy_pre(this, msgsender_MSG, msgvalue_MSG);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 115} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 116} (true);
assume ((M_Ref_bool[canWithdraw_DepositLocker[this]][_depositor_s228]) == (false));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 120} (true);
M_Ref_bool[canWithdraw_DepositLocker[this]][_depositor_s228] := true;
call  {:cexpr "canWithdraw[_depositor]"} boogie_si_record_sol2Bpl_bool(M_Ref_bool[canWithdraw_DepositLocker[this]][_depositor_s228]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 121} (true);
assume ((numberOfDepositors_DepositLocker[this]) >= (0));
numberOfDepositors_DepositLocker[this] := (numberOfDepositors_DepositLocker[this]) + (1);
call  {:cexpr "numberOfDepositors"} boogie_si_record_sol2Bpl_int(numberOfDepositors_DepositLocker[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 122} (true);
assert {:EventEmitted "DepositorRegistered_DepositLocker"} (true);
}

procedure {:public} {:inline 1} deposit_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _valuePerDepositor_s292: int);
implementation deposit_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _valuePerDepositor_s292: int)
{
var depositAmount_s291: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_valuePerDepositor"} boogie_si_record_sol2Bpl_int(_valuePerDepositor_s292);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
// ---- Logic for payable function START 
assume ((Balance[msgsender_MSG]) >= (msgvalue_MSG));
Balance[msgsender_MSG] := (Balance[msgsender_MSG]) - (msgvalue_MSG);
Balance[this] := (Balance[this]) + (msgvalue_MSG);
// ---- Logic for payable function END 
call isInitialised_pre(this, msgsender_MSG, msgvalue_MSG);
call isNotDeposited_pre(this, msgsender_MSG, msgvalue_MSG);
call onlyDepositorsProxy_pre(this, msgsender_MSG, msgvalue_MSG);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 131} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 132} (true);
assume ((numberOfDepositors_DepositLocker[this]) >= (0));
assume ((numberOfDepositors_DepositLocker[this]) > (0));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 133} (true);
assume ((_valuePerDepositor_s292) >= (0));
assume ((_valuePerDepositor_s292) > (0));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 135} (true);
assume ((depositAmount_s291) >= (0));
assume ((numberOfDepositors_DepositLocker[this]) >= (0));
assume ((_valuePerDepositor_s292) >= (0));
assume (((numberOfDepositors_DepositLocker[this]) * (_valuePerDepositor_s292)) >= (0));
depositAmount_s291 := (numberOfDepositors_DepositLocker[this]) * (_valuePerDepositor_s292);
call  {:cexpr "depositAmount"} boogie_si_record_sol2Bpl_int(depositAmount_s291);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 136} (true);
assume ((_valuePerDepositor_s292) >= (0));
assume ((depositAmount_s291) >= (0));
assume ((numberOfDepositors_DepositLocker[this]) >= (0));
assume (((depositAmount_s291) div (numberOfDepositors_DepositLocker[this])) >= (0));
assume ((_valuePerDepositor_s292) == ((depositAmount_s291) div (numberOfDepositors_DepositLocker[this])));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 140} (true);
assume ((msgvalue_MSG) >= (0));
assume ((depositAmount_s291) >= (0));
assume ((msgvalue_MSG) == (depositAmount_s291));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 145} (true);
assume ((valuePerDepositor_DepositLocker[this]) >= (0));
assume ((_valuePerDepositor_s292) >= (0));
valuePerDepositor_DepositLocker[this] := _valuePerDepositor_s292;
call  {:cexpr "valuePerDepositor"} boogie_si_record_sol2Bpl_int(valuePerDepositor_DepositLocker[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 146} (true);
deposited_DepositLocker[this] := true;
call  {:cexpr "deposited"} boogie_si_record_sol2Bpl_bool(deposited_DepositLocker[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 147} (true);
assert {:EventEmitted "Deposit_DepositLocker"} (true);
}

procedure {:public} {:inline 1} withdraw_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation withdraw_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call isInitialised_pre(this, msgsender_MSG, msgvalue_MSG);
call isDeposited_pre(this, msgsender_MSG, msgvalue_MSG);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 150} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 151} (true);
assume ((now) >= (0));
assume ((releaseTimestamp_DepositLocker[this]) >= (0));
assume ((now) >= (releaseTimestamp_DepositLocker[this]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 155} (true);
assume (M_Ref_bool[canWithdraw_DepositLocker[this]][msgsender_MSG]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 157} (true);
M_Ref_bool[canWithdraw_DepositLocker[this]][msgsender_MSG] := false;
call  {:cexpr "canWithdraw[msg.sender]"} boogie_si_record_sol2Bpl_bool(M_Ref_bool[canWithdraw_DepositLocker[this]][msgsender_MSG]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 159} (true);
assert {:EventEmitted "Withdraw_DepositLocker"} (true);
}

procedure {:public} {:inline 1} slash_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _depositorToBeSlashed_s364: Ref);
implementation slash_DepositLocker(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _depositorToBeSlashed_s364: Ref)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_depositorToBeSlashed"} boogie_si_record_sol2Bpl_ref(_depositorToBeSlashed_s364);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call isInitialised_pre(this, msgsender_MSG, msgvalue_MSG);
call isDeposited_pre(this, msgsender_MSG, msgvalue_MSG);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 166} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 167} (true);
assume ((msgsender_MSG) == (slasher_DepositLocker[this]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 171} (true);
assume (M_Ref_bool[canWithdraw_DepositLocker[this]][_depositorToBeSlashed_s364]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 172} (true);
M_Ref_bool[canWithdraw_DepositLocker[this]][_depositorToBeSlashed_s364] := false;
call  {:cexpr "canWithdraw[_depositorToBeSlashed]"} boogie_si_record_sol2Bpl_bool(M_Ref_bool[canWithdraw_DepositLocker[this]][_depositorToBeSlashed_s364]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 174} (true);
assert {:EventEmitted "Slash_DepositLocker"} (true);
}

procedure {:public} {:inline 1} vc0x0x0_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s510: Ref);
procedure {:public} {:inline 1} vc0x0x2_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s624: Ref);
procedure {:public} {:inline 1} vc0x0x3_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s745: Ref);
procedure {:public} {:inline 1} vc0x0x4_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s860: Ref);
procedure {:public} {:inline 1} vc0x0x6_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s980: Ref);
procedure {:public} {:inline 1} vc0x0x7_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s1100: Ref);
procedure {:public} {:inline 1} vc0x0x8_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s1214: Ref);
procedure {:public} {:inline 1} vc0x0x9_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s1328: Ref);
procedure {:public} {:inline 1} vc0x1x0_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s1469: Ref);
procedure {:public} {:inline 1} vc0x1x2_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s1581: Ref);
procedure {:public} {:inline 1} vc0x1x3_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s1700: Ref);
procedure {:public} {:inline 1} vc0x1x4_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s1813: Ref);
procedure {:public} {:inline 1} vc0x1x6_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s1931: Ref);
procedure {:public} {:inline 1} vc0x1x7_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2049: Ref);
procedure {:public} {:inline 1} vc0x1x8_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2161: Ref);
procedure {:public} {:inline 1} vc0x1x9_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2273: Ref);
procedure {:public} {:inline 1} vc0x2x0_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2412: Ref);
procedure {:public} {:inline 1} vc0x2x2_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2522: Ref);
procedure {:public} {:inline 1} vc0x2x3_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2639: Ref);
procedure {:public} {:inline 1} vc0x2x4_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2750: Ref);
procedure {:public} {:inline 1} vc0x2x6_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2866: Ref);
procedure {:public} {:inline 1} vc0x2x7_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s2982: Ref);
procedure {:public} {:inline 1} vc0x2x8_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s3092: Ref);
procedure {:public} {:inline 1} vc0x2x9_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s3202: Ref);
implementation vc0x2x9_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s3202: Ref)
{
var __var_4: bool;
var __var_5: int;
var __var_6: bool;
var __var_7: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
// ---- Logic for payable function START 
assume ((Balance[msgsender_MSG]) >= (msgvalue_MSG));
Balance[msgsender_MSG] := (Balance[msgsender_MSG]) - (msgvalue_MSG);
Balance[this] := (Balance[this]) + (msgvalue_MSG);
// ---- Logic for payable function END 
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 340} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 341} (true);
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume ((maximalNumberOfParticipants_ValidatorAuction[this]) >= (0));
assume ((DType[depositLocker_ValidatorAuction[this]]) == (DepositLocker));
__var_4 := initialized_DepositLocker[depositLocker_ValidatorAuction[this]];
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume ((maximalNumberOfParticipants_ValidatorAuction[this]) >= (0));
assume ((((((((((((Length[bidders_ValidatorAuction[this]]) < (maximalNumberOfParticipants_ValidatorAuction[this]))) && (!((__var_4)))) && (true)) && (((Length[bidders_ValidatorAuction[this]]) < (maximalNumberOfParticipants_ValidatorAuction[this])))) && (true)) && (!((((auctionState_ValidatorAuction[this]) == (3)) || ((auctionState_ValidatorAuction[this]) == (4)))))) && (true)) && (true)) && (true)) && (true));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 342} (true);
assume (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 343} (true);
assume (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 344} (true);
call transitionToAuctionFailed_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 345} (true);
assume (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 346} (true);
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume ((maximalNumberOfParticipants_ValidatorAuction[this]) >= (0));
assume ((DType[depositLocker_ValidatorAuction[this]]) == (DepositLocker));
__var_6 := initialized_DepositLocker[depositLocker_ValidatorAuction[this]];
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume ((maximalNumberOfParticipants_ValidatorAuction[this]) >= (0));
assert (!(((((((((((((Length[bidders_ValidatorAuction[this]]) < (maximalNumberOfParticipants_ValidatorAuction[this]))) && (__var_6)) && (true)) && (((Length[bidders_ValidatorAuction[this]]) < (maximalNumberOfParticipants_ValidatorAuction[this])))) && (true)) && ((((auctionState_ValidatorAuction[this]) == (3)) || ((auctionState_ValidatorAuction[this]) == (4))))) && (true)) && (true)) && (true)) && (true))));
}

var auctionDurationInDays_ValidatorAuction: [Ref]int;
var startPrice_ValidatorAuction: [Ref]int;
var minimalNumberOfParticipants_ValidatorAuction: [Ref]int;
var maximalNumberOfParticipants_ValidatorAuction: [Ref]int;
var auctionState_ValidatorAuction: [Ref]int;
var depositLocker_ValidatorAuction: [Ref]Ref;
var whitelist_ValidatorAuction: [Ref]Ref;
var bids_ValidatorAuction: [Ref]Ref;
var bidders_ValidatorAuction: [Ref]Ref;
var startTime_ValidatorAuction: [Ref]int;
var closeTime_ValidatorAuction: [Ref]int;
var lowestSlotPrice_ValidatorAuction: [Ref]int;
procedure {:inline 1} ValidatorAuction_ValidatorAuction_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _startPriceInWei_s3396: int, _auctionDurationInDays_s3396: int, _minimalNumberOfParticipants_s3396: int, _maximalNumberOfParticipants_s3396: int, _depositLocker_s3396: Ref);
implementation ValidatorAuction_ValidatorAuction_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _startPriceInWei_s3396: int, _auctionDurationInDays_s3396: int, _minimalNumberOfParticipants_s3396: int, _maximalNumberOfParticipants_s3396: int, _depositLocker_s3396: Ref)
{
var __var_8: int;
var __var_9: Ref;
var __var_10: Ref;
var __var_11: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
auctionDurationInDays_ValidatorAuction[this] := 0;
startPrice_ValidatorAuction[this] := 0;
minimalNumberOfParticipants_ValidatorAuction[this] := 0;
maximalNumberOfParticipants_ValidatorAuction[this] := 0;
// Make array/mapping vars distinct for whitelist
call __var_9 := FreshRefGenerator();
whitelist_ValidatorAuction[this] := __var_9;
// Initialize Boolean mapping whitelist
assume (forall  __i__0_0:Ref ::  (!(M_Ref_bool[whitelist_ValidatorAuction[this]][__i__0_0])));
// Make array/mapping vars distinct for bids
call __var_10 := FreshRefGenerator();
bids_ValidatorAuction[this] := __var_10;
// Initialize Integer mapping bids
assume (forall  __i__0_0:Ref ::  ((M_Ref_int[bids_ValidatorAuction[this]][__i__0_0]) == (0)));
// Make array/mapping vars distinct for bidders
call __var_11 := FreshRefGenerator();
bidders_ValidatorAuction[this] := __var_11;
assume ((Length[bidders_ValidatorAuction[this]]) == (0));
startTime_ValidatorAuction[this] := 0;
closeTime_ValidatorAuction[this] := 0;
lowestSlotPrice_ValidatorAuction[this] := 0;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_startPriceInWei"} boogie_si_record_sol2Bpl_int(_startPriceInWei_s3396);
call  {:cexpr "_auctionDurationInDays"} boogie_si_record_sol2Bpl_int(_auctionDurationInDays_s3396);
call  {:cexpr "_minimalNumberOfParticipants"} boogie_si_record_sol2Bpl_int(_minimalNumberOfParticipants_s3396);
call  {:cexpr "_maximalNumberOfParticipants"} boogie_si_record_sol2Bpl_int(_maximalNumberOfParticipants_s3396);
call  {:cexpr "_depositLocker"} boogie_si_record_sol2Bpl_ref(_depositLocker_s3396);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 410} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 411} (true);
assume ((_auctionDurationInDays_s3396) >= (0));
assume ((_auctionDurationInDays_s3396) > (0));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 415} (true);
assume ((_auctionDurationInDays_s3396) >= (0));
assume ((_auctionDurationInDays_s3396) < ((100) * (365)));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 419} (true);
assume ((_minimalNumberOfParticipants_s3396) >= (0));
assume ((_minimalNumberOfParticipants_s3396) > (0));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 423} (true);
assume ((_maximalNumberOfParticipants_s3396) >= (0));
assume ((_maximalNumberOfParticipants_s3396) > (0));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 427} (true);
assume ((_minimalNumberOfParticipants_s3396) >= (0));
assume ((_maximalNumberOfParticipants_s3396) >= (0));
assume ((_minimalNumberOfParticipants_s3396) <= (_maximalNumberOfParticipants_s3396));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 431} (true);
assume ((_startPriceInWei_s3396) >= (0));
assume ((_startPriceInWei_s3396) < (10000000000000000000000000000000));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 437} (true);
assume ((startPrice_ValidatorAuction[this]) >= (0));
assume ((_startPriceInWei_s3396) >= (0));
startPrice_ValidatorAuction[this] := _startPriceInWei_s3396;
call  {:cexpr "startPrice"} boogie_si_record_sol2Bpl_int(startPrice_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 438} (true);
assume ((auctionDurationInDays_ValidatorAuction[this]) >= (0));
assume ((_auctionDurationInDays_s3396) >= (0));
auctionDurationInDays_ValidatorAuction[this] := _auctionDurationInDays_s3396;
call  {:cexpr "auctionDurationInDays"} boogie_si_record_sol2Bpl_int(auctionDurationInDays_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 439} (true);
assume ((maximalNumberOfParticipants_ValidatorAuction[this]) >= (0));
assume ((_maximalNumberOfParticipants_s3396) >= (0));
maximalNumberOfParticipants_ValidatorAuction[this] := _maximalNumberOfParticipants_s3396;
call  {:cexpr "maximalNumberOfParticipants"} boogie_si_record_sol2Bpl_int(maximalNumberOfParticipants_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 440} (true);
assume ((minimalNumberOfParticipants_ValidatorAuction[this]) >= (0));
assume ((_minimalNumberOfParticipants_s3396) >= (0));
minimalNumberOfParticipants_ValidatorAuction[this] := _minimalNumberOfParticipants_s3396;
call  {:cexpr "minimalNumberOfParticipants"} boogie_si_record_sol2Bpl_int(minimalNumberOfParticipants_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 441} (true);
depositLocker_ValidatorAuction[this] := _depositLocker_s3396;
call  {:cexpr "depositLocker"} boogie_si_record_sol2Bpl_ref(depositLocker_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 443} (true);
assume ((lowestSlotPrice_ValidatorAuction[this]) >= (0));
__var_8 := 115792089237316195423570985008687907853269984665640564039457584007913129639935;
lowestSlotPrice_ValidatorAuction[this] := __var_8;
assume ((__var_8) >= (0));
call  {:cexpr "lowestSlotPrice"} boogie_si_record_sol2Bpl_int(lowestSlotPrice_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 445} (true);
assert {:EventEmitted "AuctionDeployed_ValidatorAuction"} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 451} (true);
auctionState_ValidatorAuction[this] := 0;
}

procedure {:constructor} {:public} {:inline 1} ValidatorAuction_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _startPriceInWei_s3396: int, _auctionDurationInDays_s3396: int, _minimalNumberOfParticipants_s3396: int, _maximalNumberOfParticipants_s3396: int, _depositLocker_s3396: Ref);
implementation ValidatorAuction_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _startPriceInWei_s3396: int, _auctionDurationInDays_s3396: int, _minimalNumberOfParticipants_s3396: int, _maximalNumberOfParticipants_s3396: int, _depositLocker_s3396: Ref)
{
var __var_8: int;
var __var_9: Ref;
var __var_10: Ref;
var __var_11: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_startPriceInWei"} boogie_si_record_sol2Bpl_int(_startPriceInWei_s3396);
call  {:cexpr "_auctionDurationInDays"} boogie_si_record_sol2Bpl_int(_auctionDurationInDays_s3396);
call  {:cexpr "_minimalNumberOfParticipants"} boogie_si_record_sol2Bpl_int(_minimalNumberOfParticipants_s3396);
call  {:cexpr "_maximalNumberOfParticipants"} boogie_si_record_sol2Bpl_int(_maximalNumberOfParticipants_s3396);
call  {:cexpr "_depositLocker"} boogie_si_record_sol2Bpl_ref(_depositLocker_s3396);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Ownable_Ownable(this, msgsender_MSG, msgvalue_MSG);
call ValidatorAuction_ValidatorAuction_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, _startPriceInWei_s3396, _auctionDurationInDays_s3396, _minimalNumberOfParticipants_s3396, _maximalNumberOfParticipants_s3396, _depositLocker_s3396);
}

procedure {:inline 1} FallbackMethod_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation FallbackMethod_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
// ---- Logic for payable function START 
assume ((Balance[msgsender_MSG]) >= (msgvalue_MSG));
Balance[msgsender_MSG] := (Balance[msgsender_MSG]) - (msgvalue_MSG);
Balance[this] := (Balance[this]) + (msgvalue_MSG);
// ---- Logic for payable function END 
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 1);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 454} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 455} (true);
call bid_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} bid_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation bid_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var slotPrice_s3527: int;
var __var_12: bool;
var __var_13: int;
var __var_14: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
// ---- Logic for payable function START 
assume ((Balance[msgsender_MSG]) >= (msgvalue_MSG));
Balance[msgsender_MSG] := (Balance[msgsender_MSG]) - (msgvalue_MSG);
Balance[this] := (Balance[this]) + (msgvalue_MSG);
// ---- Logic for payable function END 
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 1);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 458} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 459} (true);
assume ((now) >= (0));
assume ((startTime_ValidatorAuction[this]) >= (0));
assume ((now) > (startTime_ValidatorAuction[this]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 460} (true);
assume ((now) >= (0));
assume ((startTime_ValidatorAuction[this]) >= (0));
assume ((auctionDurationInDays_ValidatorAuction[this]) >= (0));
assume (((auctionDurationInDays_ValidatorAuction[this]) * (1)) >= (0));
assume (((startTime_ValidatorAuction[this]) + ((auctionDurationInDays_ValidatorAuction[this]) * (1))) >= (0));
assume ((now) <= ((startTime_ValidatorAuction[this]) + ((auctionDurationInDays_ValidatorAuction[this]) * (1))));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 464} (true);
assume ((slotPrice_s3527) >= (0));
call slotPrice_s3527 := currentPrice_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
slotPrice_s3527 := slotPrice_s3527;
call  {:cexpr "slotPrice"} boogie_si_record_sol2Bpl_int(slotPrice_s3527);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 465} (true);
assume ((msgvalue_MSG) >= (0));
assume ((slotPrice_s3527) >= (0));
assume ((msgvalue_MSG) >= (slotPrice_s3527));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 469} (true);
assume (M_Ref_bool[whitelist_ValidatorAuction[this]][msgsender_MSG]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 470} (true);
call __var_12 := isSenderContract_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
assume (!(__var_12));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 471} (true);
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume ((maximalNumberOfParticipants_ValidatorAuction[this]) >= (0));
assume ((Length[bidders_ValidatorAuction[this]]) < (maximalNumberOfParticipants_ValidatorAuction[this]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 475} (true);
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) == (0));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 477} (true);
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
assume ((msgvalue_MSG) >= (0));
M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG] := msgvalue_MSG;
call  {:cexpr "bids[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 478} (true);
__var_13 := Length[bidders_ValidatorAuction[this]];
M_int_Ref[bidders_ValidatorAuction[this]][__var_13] := msgsender_MSG;
Length[bidders_ValidatorAuction[this]] := (__var_13) + (1);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 479} (true);
assume ((slotPrice_s3527) >= (0));
assume ((lowestSlotPrice_ValidatorAuction[this]) >= (0));
if ((slotPrice_s3527) < (lowestSlotPrice_ValidatorAuction[this])) {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 479} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 480} (true);
assume ((lowestSlotPrice_ValidatorAuction[this]) >= (0));
assume ((slotPrice_s3527) >= (0));
lowestSlotPrice_ValidatorAuction[this] := slotPrice_s3527;
call  {:cexpr "lowestSlotPrice"} boogie_si_record_sol2Bpl_int(lowestSlotPrice_ValidatorAuction[this]);
}
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 483} (true);
call registerDepositor_DepositLocker(depositLocker_ValidatorAuction[this], this, __var_14, msgsender_MSG);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 484} (true);
assert {:EventEmitted "BidSubmitted_ValidatorAuction"} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 486} (true);
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume ((maximalNumberOfParticipants_ValidatorAuction[this]) >= (0));
if ((Length[bidders_ValidatorAuction[this]]) == (maximalNumberOfParticipants_ValidatorAuction[this])) {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 486} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 487} (true);
call transitionToDepositPending_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
}
}

procedure {:public} {:inline 1} startAuction_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation startAuction_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_15: bool;
var __var_16: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call onlyOwner_pre(this, msgsender_MSG, msgvalue_MSG);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 0);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 491} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 492} (true);
assume ((DType[depositLocker_ValidatorAuction[this]]) == (DepositLocker));
__var_15 := initialized_DepositLocker[depositLocker_ValidatorAuction[this]];
assume (__var_15);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 497} (true);
auctionState_ValidatorAuction[this] := 1;
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 498} (true);
assume ((startTime_ValidatorAuction[this]) >= (0));
assume ((now) >= (0));
startTime_ValidatorAuction[this] := now;
call  {:cexpr "startTime"} boogie_si_record_sol2Bpl_int(startTime_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 500} (true);
assert {:EventEmitted "AuctionStarted_ValidatorAuction"} (true);
}

procedure {:public} {:inline 1} depositBids_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation depositBids_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 2);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 503} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 504} (true);
auctionState_ValidatorAuction[this] := 3;
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 505} (true);
assume ((lowestSlotPrice_ValidatorAuction[this]) >= (0));
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume (((lowestSlotPrice_ValidatorAuction[this]) * (Length[bidders_ValidatorAuction[this]])) >= (0));
assume ((lowestSlotPrice_ValidatorAuction[this]) >= (0));
call deposit_DepositLocker(depositLocker_ValidatorAuction[this], this, (lowestSlotPrice_ValidatorAuction[this]) * (Length[bidders_ValidatorAuction[this]]), lowestSlotPrice_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 508} (true);
assert {:EventEmitted "AuctionEnded_ValidatorAuction"} (true);
}

procedure {:public} {:inline 1} closeAuction_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation closeAuction_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 1);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 511} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 512} (true);
assume ((now) >= (0));
assume ((startTime_ValidatorAuction[this]) >= (0));
assume ((auctionDurationInDays_ValidatorAuction[this]) >= (0));
assume (((auctionDurationInDays_ValidatorAuction[this]) * (1)) >= (0));
assume (((startTime_ValidatorAuction[this]) + ((auctionDurationInDays_ValidatorAuction[this]) * (1))) >= (0));
assume ((now) > ((startTime_ValidatorAuction[this]) + ((auctionDurationInDays_ValidatorAuction[this]) * (1))));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 516} (true);
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume ((maximalNumberOfParticipants_ValidatorAuction[this]) >= (0));
assume ((Length[bidders_ValidatorAuction[this]]) < (maximalNumberOfParticipants_ValidatorAuction[this]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 518} (true);
assume ((Length[bidders_ValidatorAuction[this]]) >= (0));
assume ((minimalNumberOfParticipants_ValidatorAuction[this]) >= (0));
if ((Length[bidders_ValidatorAuction[this]]) >= (minimalNumberOfParticipants_ValidatorAuction[this])) {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 518} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 519} (true);
call transitionToDepositPending_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 520} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 521} (true);
call transitionToAuctionFailed_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
}
}

procedure {:public} {:inline 1} addToWhitelist_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s3670: Ref);
implementation addToWhitelist_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, addressesToWhitelist_s3670: Ref)
{
var i_s3668: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call onlyOwner_pre(this, msgsender_MSG, msgvalue_MSG);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 0);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 529} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 530} (true);
assume ((i_s3668) >= (0));
assume ((Length[addressesToWhitelist_s3670]) >= (0));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 530} (true);
assume ((i_s3668) >= (0));
i_s3668 := 0;
call  {:cexpr "i"} boogie_si_record_sol2Bpl_int(i_s3668);
while ((i_s3668) < (Length[addressesToWhitelist_s3670]))
{
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 530} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 531} (true);
assume ((i_s3668) >= (0));
M_Ref_bool[whitelist_ValidatorAuction[this]][M_int_Ref[addressesToWhitelist_s3670][i_s3668]] := true;
call  {:cexpr "whitelist[addressesToWhitelist[i]]"} boogie_si_record_sol2Bpl_bool(M_Ref_bool[whitelist_ValidatorAuction[this]][M_int_Ref[addressesToWhitelist_s3670][i_s3668]]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 532} (true);
assert {:EventEmitted "AddressWhitelisted_ValidatorAuction"} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 530} (true);
assume ((i_s3668) >= (0));
i_s3668 := (i_s3668) + (1);
call  {:cexpr "i"} boogie_si_record_sol2Bpl_int(i_s3668);
assume ((i_s3668) >= (0));
}
}

procedure {:public} {:inline 1} withdraw_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation withdraw_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 536} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 537} (true);
assume (((auctionState_ValidatorAuction[this]) == (3)) || ((auctionState_ValidatorAuction[this]) == (4)));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 543} (true);
if ((auctionState_ValidatorAuction[this]) == (3)) {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 543} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 544} (true);
call withdrawAfterAuctionEnded_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 545} (true);
if ((auctionState_ValidatorAuction[this]) == (4)) {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 545} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 546} (true);
call withdrawAfterAuctionFailed_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else {
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 547} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 548} (true);
assume (false);
}
}
}

procedure {:public} {:inline 1} currentPrice_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
implementation currentPrice_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{
var secondsSinceStart_s3736: int;
var __var_17: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 1);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 557} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 558} (true);
assume ((now) >= (0));
assume ((startTime_ValidatorAuction[this]) >= (0));
assume ((now) >= (startTime_ValidatorAuction[this]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 559} (true);
assume ((secondsSinceStart_s3736) >= (0));
assume ((now) >= (0));
assume ((startTime_ValidatorAuction[this]) >= (0));
assume ((((now) - (startTime_ValidatorAuction[this]))) >= (0));
secondsSinceStart_s3736 := ((now) - (startTime_ValidatorAuction[this]));
call  {:cexpr "secondsSinceStart"} boogie_si_record_sol2Bpl_int(secondsSinceStart_s3736);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 560} (true);
assume ((__var_17) >= (0));
assume ((secondsSinceStart_s3736) >= (0));
call __var_17 := priceAtElapsedTime_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, secondsSinceStart_s3736);
assume ((__var_17) >= (0));
__ret_0_ := __var_17;
return;
}

procedure {:public} {:inline 1} priceAtElapsedTime_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, secondsSinceStart_s3798: int) returns (__ret_0_: int);
implementation priceAtElapsedTime_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, secondsSinceStart_s3798: int) returns (__ret_0_: int)
{
var msSinceStart_s3797: int;
var relativeAuctionTime_s3797: int;
var decayDivisor_s3797: int;
var decay_s3797: int;
var price_s3797: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "secondsSinceStart"} boogie_si_record_sol2Bpl_int(secondsSinceStart_s3798);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 567} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 569} (true);
assume ((secondsSinceStart_s3798) >= (0));
assume ((secondsSinceStart_s3798) < ((100) * (365)));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 573} (true);
assume ((msSinceStart_s3797) >= (0));
assume ((secondsSinceStart_s3798) >= (0));
assume (((1000) * (secondsSinceStart_s3798)) >= (0));
msSinceStart_s3797 := (1000) * (secondsSinceStart_s3798);
call  {:cexpr "msSinceStart"} boogie_si_record_sol2Bpl_int(msSinceStart_s3797);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 574} (true);
assume ((relativeAuctionTime_s3797) >= (0));
assume ((msSinceStart_s3797) >= (0));
assume ((auctionDurationInDays_ValidatorAuction[this]) >= (0));
assume (((msSinceStart_s3797) div (auctionDurationInDays_ValidatorAuction[this])) >= (0));
relativeAuctionTime_s3797 := (msSinceStart_s3797) div (auctionDurationInDays_ValidatorAuction[this]);
call  {:cexpr "relativeAuctionTime"} boogie_si_record_sol2Bpl_int(relativeAuctionTime_s3797);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 575} (true);
assume ((decayDivisor_s3797) >= (0));
decayDivisor_s3797 := 746571428571;
call  {:cexpr "decayDivisor"} boogie_si_record_sol2Bpl_int(decayDivisor_s3797);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 576} (true);
assume ((decay_s3797) >= (0));
assume ((relativeAuctionTime_s3797) >= (0));
assume ((relativeAuctionTime_s3797) >= (0));
assume (((relativeAuctionTime_s3797) * (relativeAuctionTime_s3797)) >= (0));
assume ((relativeAuctionTime_s3797) >= (0));
assume ((((relativeAuctionTime_s3797) * (relativeAuctionTime_s3797)) * (relativeAuctionTime_s3797)) >= (0));
assume ((decayDivisor_s3797) >= (0));
assume (((((relativeAuctionTime_s3797) * (relativeAuctionTime_s3797)) * (relativeAuctionTime_s3797)) div (decayDivisor_s3797)) >= (0));
decay_s3797 := (((relativeAuctionTime_s3797) * (relativeAuctionTime_s3797)) * (relativeAuctionTime_s3797)) div (decayDivisor_s3797);
call  {:cexpr "decay"} boogie_si_record_sol2Bpl_int(decay_s3797);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 577} (true);
assume ((price_s3797) >= (0));
assume ((startPrice_ValidatorAuction[this]) >= (0));
assume ((relativeAuctionTime_s3797) >= (0));
assume ((((1) + (relativeAuctionTime_s3797))) >= (0));
assume (((startPrice_ValidatorAuction[this]) * (((1) + (relativeAuctionTime_s3797)))) >= (0));
assume ((relativeAuctionTime_s3797) >= (0));
assume (((1) + (relativeAuctionTime_s3797)) >= (0));
assume ((decay_s3797) >= (0));
assume (((((1) + (relativeAuctionTime_s3797)) + (decay_s3797))) >= (0));
assume ((((startPrice_ValidatorAuction[this]) * (((1) + (relativeAuctionTime_s3797)))) div ((((1) + (relativeAuctionTime_s3797)) + (decay_s3797)))) >= (0));
price_s3797 := ((startPrice_ValidatorAuction[this]) * (((1) + (relativeAuctionTime_s3797)))) div ((((1) + (relativeAuctionTime_s3797)) + (decay_s3797)));
call  {:cexpr "price"} boogie_si_record_sol2Bpl_int(price_s3797);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 580} (true);
assume ((price_s3797) >= (0));
__ret_0_ := price_s3797;
return;
}

procedure {:inline 1} withdrawAfterAuctionEnded_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation withdrawAfterAuctionEnded_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var valueToWithdraw_s3840: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 3);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 583} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 584} (true);
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
assume ((lowestSlotPrice_ValidatorAuction[this]) >= (0));
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) > (lowestSlotPrice_ValidatorAuction[this]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 589} (true);
assume ((valueToWithdraw_s3840) >= (0));
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
assume ((lowestSlotPrice_ValidatorAuction[this]) >= (0));
assume (((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) - (lowestSlotPrice_ValidatorAuction[this])) >= (0));
valueToWithdraw_s3840 := (M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) - (lowestSlotPrice_ValidatorAuction[this]);
call  {:cexpr "valueToWithdraw"} boogie_si_record_sol2Bpl_int(valueToWithdraw_s3840);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 590} (true);
assume ((valueToWithdraw_s3840) >= (0));
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
assume ((valueToWithdraw_s3840) <= (M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 592} (true);
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
assume ((lowestSlotPrice_ValidatorAuction[this]) >= (0));
M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG] := lowestSlotPrice_ValidatorAuction[this];
call  {:cexpr "bids[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]);
}

procedure {:inline 1} withdrawAfterAuctionFailed_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation withdrawAfterAuctionFailed_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var valueToWithdraw_s3872: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 4);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 600} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 601} (true);
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) > (0));
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 603} (true);
assume ((valueToWithdraw_s3872) >= (0));
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
valueToWithdraw_s3872 := M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG];
call  {:cexpr "valueToWithdraw"} boogie_si_record_sol2Bpl_int(valueToWithdraw_s3872);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 605} (true);
assume ((M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]) >= (0));
M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG] := 0;
call  {:cexpr "bids[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[bids_ValidatorAuction[this]][msgsender_MSG]);
}

procedure {:inline 1} transitionToDepositPending_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation transitionToDepositPending_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 1);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 613} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 614} (true);
auctionState_ValidatorAuction[this] := 2;
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 615} (true);
assume ((closeTime_ValidatorAuction[this]) >= (0));
assume ((now) >= (0));
closeTime_ValidatorAuction[this] := now;
call  {:cexpr "closeTime"} boogie_si_record_sol2Bpl_int(closeTime_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 616} (true);
assert {:EventEmitted "AuctionDepositPending_ValidatorAuction"} (true);
}

procedure {:inline 1} transitionToAuctionFailed_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation transitionToAuctionFailed_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call stateIs_pre(this, msgsender_MSG, msgvalue_MSG, 1);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 622} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 623} (true);
auctionState_ValidatorAuction[this] := 4;
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 624} (true);
assume ((closeTime_ValidatorAuction[this]) >= (0));
assume ((now) >= (0));
closeTime_ValidatorAuction[this] := now;
call  {:cexpr "closeTime"} boogie_si_record_sol2Bpl_int(closeTime_ValidatorAuction[this]);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 625} (true);
assert {:EventEmitted "AuctionFailed_ValidatorAuction"} (true);
}

procedure {:inline 1} isSenderContract_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (isContract_s3940: bool);
implementation isSenderContract_ValidatorAuction(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (isContract_s3940: bool)
{
var size_s3939: int;
var sender_s3939: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 628} (true);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 629} (true);
assume ((size_s3939) >= (0));
size_s3939 := 1;
call  {:cexpr "size"} boogie_si_record_sol2Bpl_int(size_s3939);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 630} (true);
sender_s3939 := msgsender_MSG;
call  {:cexpr "sender"} boogie_si_record_sol2Bpl_ref(sender_s3939);
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 635} (true);
assume ((size_s3939) >= (0));
isContract_s3940 := (size_s3939) > (0);
return;
}

procedure {:inline 1} FallbackDispatch(from: Ref, to: Ref, amount: int);
implementation FallbackDispatch(from: Ref, to: Ref, amount: int)
{
if ((DType[to]) == (ValidatorAuction)) {
call FallbackMethod_ValidatorAuction(to, from, amount);
} else if ((DType[to]) == (DepositLocker)) {
call FallbackMethod_DepositLocker(to, from, amount);
} else if ((DType[to]) == (DepositLockerInterface)) {
assume ((amount) == (0));
} else if ((DType[to]) == (Ownable)) {
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

const {:existential true} HoudiniB1_Ownable: bool;
const {:existential true} HoudiniB2_Ownable: bool;
procedure BoogieEntry_Ownable();
implementation BoogieEntry_Ownable()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var newOwner_s43: Ref;
var tmpNow: int;
assume ((now) >= (0));
assume ((((DType[this]) == (Ownable)) || ((DType[this]) == (DepositLocker))) || ((DType[this]) == (ValidatorAuction)));
call Ownable_Ownable(this, msgsender_MSG, msgvalue_MSG);
while (true)
  invariant (HoudiniB1_Ownable) ==> ((owner_Ownable[this]) == (null));
  invariant (HoudiniB2_Ownable) ==> ((owner_Ownable[this]) != (null));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc newOwner_s43;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Ownable));
assume ((DType[msgsender_MSG]) != (DepositLockerInterface));
assume ((DType[msgsender_MSG]) != (DepositLocker));
assume ((DType[msgsender_MSG]) != (ValidatorAuction));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call transferOwnership_Ownable(this, msgsender_MSG, msgvalue_MSG, newOwner_s43);
}
}
}

procedure BoogieEntry_DepositLockerInterface();
implementation BoogieEntry_DepositLockerInterface()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var _depositorToBeSlashed_s49: Ref;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (DepositLockerInterface)) || ((DType[this]) == (DepositLocker)));
call DepositLockerInterface_DepositLockerInterface(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc _depositorToBeSlashed_s49;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Ownable));
assume ((DType[msgsender_MSG]) != (DepositLockerInterface));
assume ((DType[msgsender_MSG]) != (DepositLocker));
assume ((DType[msgsender_MSG]) != (ValidatorAuction));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call slash_DepositLockerInterface(this, msgsender_MSG, msgvalue_MSG, _depositorToBeSlashed_s49);
}
}
}

const {:existential true} HoudiniB1_DepositLocker: bool;
const {:existential true} HoudiniB2_DepositLocker: bool;
const {:existential true} HoudiniB3_DepositLocker: bool;
const {:existential true} HoudiniB4_DepositLocker: bool;
const {:existential true} HoudiniB5_DepositLocker: bool;
const {:existential true} HoudiniB6_DepositLocker: bool;
const {:existential true} HoudiniB7_DepositLocker: bool;
const {:existential true} HoudiniB8_DepositLocker: bool;
const {:existential true} HoudiniB9_DepositLocker: bool;
const {:existential true} HoudiniB10_DepositLocker: bool;
const {:existential true} HoudiniB11_DepositLocker: bool;
const {:existential true} HoudiniB12_DepositLocker: bool;
procedure BoogieEntry_DepositLocker();
implementation BoogieEntry_DepositLocker()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var newOwner_s43: Ref;
var _depositorToBeSlashed_s364: Ref;
var _releaseTimestamp_s192: int;
var _slasher_s192: Ref;
var _depositorsProxy_s192: Ref;
var _depositor_s228: Ref;
var _valuePerDepositor_s292: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (DepositLocker));
call DepositLocker_DepositLocker(this, msgsender_MSG, msgvalue_MSG);
while (true)
  invariant (HoudiniB1_DepositLocker) ==> ((owner_Ownable[this]) == (null));
  invariant (HoudiniB2_DepositLocker) ==> ((owner_Ownable[this]) != (null));
  invariant (HoudiniB3_DepositLocker) ==> ((slasher_DepositLocker[this]) == (null));
  invariant (HoudiniB4_DepositLocker) ==> ((slasher_DepositLocker[this]) != (null));
  invariant (HoudiniB5_DepositLocker) ==> ((depositorsProxy_DepositLocker[this]) == (null));
  invariant (HoudiniB6_DepositLocker) ==> ((depositorsProxy_DepositLocker[this]) != (null));
  invariant (HoudiniB7_DepositLocker) ==> ((owner_Ownable[this]) == (slasher_DepositLocker[this]));
  invariant (HoudiniB8_DepositLocker) ==> ((owner_Ownable[this]) != (slasher_DepositLocker[this]));
  invariant (HoudiniB9_DepositLocker) ==> ((owner_Ownable[this]) == (depositorsProxy_DepositLocker[this]));
  invariant (HoudiniB10_DepositLocker) ==> ((owner_Ownable[this]) != (depositorsProxy_DepositLocker[this]));
  invariant (HoudiniB11_DepositLocker) ==> ((slasher_DepositLocker[this]) == (depositorsProxy_DepositLocker[this]));
  invariant (HoudiniB12_DepositLocker) ==> ((slasher_DepositLocker[this]) != (depositorsProxy_DepositLocker[this]));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc newOwner_s43;
havoc _depositorToBeSlashed_s364;
havoc _releaseTimestamp_s192;
havoc _slasher_s192;
havoc _depositorsProxy_s192;
havoc _depositor_s228;
havoc _valuePerDepositor_s292;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Ownable));
assume ((DType[msgsender_MSG]) != (DepositLockerInterface));
assume ((DType[msgsender_MSG]) != (DepositLocker));
assume ((DType[msgsender_MSG]) != (ValidatorAuction));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call transferOwnership_Ownable(this, msgsender_MSG, msgvalue_MSG, newOwner_s43);
} else if ((choice) == (5)) {
call slash_DepositLocker(this, msgsender_MSG, msgvalue_MSG, _depositorToBeSlashed_s364);
} else if ((choice) == (4)) {
call init_DepositLocker(this, msgsender_MSG, msgvalue_MSG, _releaseTimestamp_s192, _slasher_s192, _depositorsProxy_s192);
} else if ((choice) == (3)) {
call registerDepositor_DepositLocker(this, msgsender_MSG, msgvalue_MSG, _depositor_s228);
} else if ((choice) == (2)) {
call deposit_DepositLocker(this, msgsender_MSG, msgvalue_MSG, _valuePerDepositor_s292);
} else if ((choice) == (1)) {
call withdraw_DepositLocker(this, msgsender_MSG, msgvalue_MSG);
}
}
}

const {:existential true} HoudiniB1_ValidatorAuction: bool;
const {:existential true} HoudiniB2_ValidatorAuction: bool;
procedure BoogieEntry_ValidatorAuction();
implementation BoogieEntry_ValidatorAuction()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var newOwner_s43: Ref;
var addressesToWhitelist_s510: Ref;
var addressesToWhitelist_s624: Ref;
var addressesToWhitelist_s745: Ref;
var addressesToWhitelist_s860: Ref;
var addressesToWhitelist_s980: Ref;
var addressesToWhitelist_s1100: Ref;
var addressesToWhitelist_s1214: Ref;
var addressesToWhitelist_s1328: Ref;
var addressesToWhitelist_s1469: Ref;
var addressesToWhitelist_s1581: Ref;
var addressesToWhitelist_s1700: Ref;
var addressesToWhitelist_s1813: Ref;
var addressesToWhitelist_s1931: Ref;
var addressesToWhitelist_s2049: Ref;
var addressesToWhitelist_s2161: Ref;
var addressesToWhitelist_s2273: Ref;
var addressesToWhitelist_s2412: Ref;
var addressesToWhitelist_s2522: Ref;
var addressesToWhitelist_s2639: Ref;
var addressesToWhitelist_s2750: Ref;
var addressesToWhitelist_s2866: Ref;
var addressesToWhitelist_s2982: Ref;
var addressesToWhitelist_s3092: Ref;
var addressesToWhitelist_s3202: Ref;
var _startPriceInWei_s3396: int;
var _auctionDurationInDays_s3396: int;
var _minimalNumberOfParticipants_s3396: int;
var _maximalNumberOfParticipants_s3396: int;
var _depositLocker_s3396: Ref;
var addressesToWhitelist_s3670: Ref;
var __ret_0_currentPrice: int;
var secondsSinceStart_s3798: int;
var __ret_0_priceAtElapsedTime: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (ValidatorAuction));
call ValidatorAuction_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, _startPriceInWei_s3396, _auctionDurationInDays_s3396, _minimalNumberOfParticipants_s3396, _maximalNumberOfParticipants_s3396, _depositLocker_s3396);
while (true)
  invariant (HoudiniB1_ValidatorAuction) ==> ((owner_Ownable[this]) == (null));
  invariant (HoudiniB2_ValidatorAuction) ==> ((owner_Ownable[this]) != (null));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc newOwner_s43;
havoc addressesToWhitelist_s510;
havoc addressesToWhitelist_s624;
havoc addressesToWhitelist_s745;
havoc addressesToWhitelist_s860;
havoc addressesToWhitelist_s980;
havoc addressesToWhitelist_s1100;
havoc addressesToWhitelist_s1214;
havoc addressesToWhitelist_s1328;
havoc addressesToWhitelist_s1469;
havoc addressesToWhitelist_s1581;
havoc addressesToWhitelist_s1700;
havoc addressesToWhitelist_s1813;
havoc addressesToWhitelist_s1931;
havoc addressesToWhitelist_s2049;
havoc addressesToWhitelist_s2161;
havoc addressesToWhitelist_s2273;
havoc addressesToWhitelist_s2412;
havoc addressesToWhitelist_s2522;
havoc addressesToWhitelist_s2639;
havoc addressesToWhitelist_s2750;
havoc addressesToWhitelist_s2866;
havoc addressesToWhitelist_s2982;
havoc addressesToWhitelist_s3092;
havoc addressesToWhitelist_s3202;
havoc _startPriceInWei_s3396;
havoc _auctionDurationInDays_s3396;
havoc _minimalNumberOfParticipants_s3396;
havoc _maximalNumberOfParticipants_s3396;
havoc _depositLocker_s3396;
havoc addressesToWhitelist_s3670;
havoc __ret_0_currentPrice;
havoc secondsSinceStart_s3798;
havoc __ret_0_priceAtElapsedTime;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Ownable));
assume ((DType[msgsender_MSG]) != (DepositLockerInterface));
assume ((DType[msgsender_MSG]) != (DepositLocker));
assume ((DType[msgsender_MSG]) != (ValidatorAuction));
Alloc[msgsender_MSG] := true;
if ((choice) == (33)) {
call transferOwnership_Ownable(this, msgsender_MSG, msgvalue_MSG, newOwner_s43);
} else if ((choice) == (32)) {
call withdraw_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (31)) {
call addressesToWhitelist_s510 := FreshRefGenerator();
call vc0x0x0_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s510);
} else if ((choice) == (30)) {
call addressesToWhitelist_s624 := FreshRefGenerator();
call vc0x0x2_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s624);
} else if ((choice) == (29)) {
call addressesToWhitelist_s745 := FreshRefGenerator();
call vc0x0x3_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s745);
} else if ((choice) == (28)) {
call addressesToWhitelist_s860 := FreshRefGenerator();
call vc0x0x4_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s860);
} else if ((choice) == (27)) {
call addressesToWhitelist_s980 := FreshRefGenerator();
call vc0x0x6_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s980);
} else if ((choice) == (26)) {
call addressesToWhitelist_s1100 := FreshRefGenerator();
call vc0x0x7_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1100);
} else if ((choice) == (25)) {
call addressesToWhitelist_s1214 := FreshRefGenerator();
call vc0x0x8_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1214);
} else if ((choice) == (24)) {
call addressesToWhitelist_s1328 := FreshRefGenerator();
call vc0x0x9_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1328);
} else if ((choice) == (23)) {
call addressesToWhitelist_s1469 := FreshRefGenerator();
call vc0x1x0_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1469);
} else if ((choice) == (22)) {
call addressesToWhitelist_s1581 := FreshRefGenerator();
call vc0x1x2_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1581);
} else if ((choice) == (21)) {
call addressesToWhitelist_s1700 := FreshRefGenerator();
call vc0x1x3_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1700);
} else if ((choice) == (20)) {
call addressesToWhitelist_s1813 := FreshRefGenerator();
call vc0x1x4_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1813);
} else if ((choice) == (19)) {
call addressesToWhitelist_s1931 := FreshRefGenerator();
call vc0x1x6_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1931);
} else if ((choice) == (18)) {
call addressesToWhitelist_s2049 := FreshRefGenerator();
call vc0x1x7_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2049);
} else if ((choice) == (17)) {
call addressesToWhitelist_s2161 := FreshRefGenerator();
call vc0x1x8_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2161);
} else if ((choice) == (16)) {
call addressesToWhitelist_s2273 := FreshRefGenerator();
call vc0x1x9_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2273);
} else if ((choice) == (15)) {
call addressesToWhitelist_s2412 := FreshRefGenerator();
call vc0x2x0_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2412);
} else if ((choice) == (14)) {
call addressesToWhitelist_s2522 := FreshRefGenerator();
call vc0x2x2_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2522);
} else if ((choice) == (13)) {
call addressesToWhitelist_s2639 := FreshRefGenerator();
call vc0x2x3_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2639);
} else if ((choice) == (12)) {
call addressesToWhitelist_s2750 := FreshRefGenerator();
call vc0x2x4_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2750);
} else if ((choice) == (11)) {
call addressesToWhitelist_s2866 := FreshRefGenerator();
call vc0x2x6_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2866);
} else if ((choice) == (10)) {
call addressesToWhitelist_s2982 := FreshRefGenerator();
call vc0x2x7_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2982);
} else if ((choice) == (9)) {
call addressesToWhitelist_s3092 := FreshRefGenerator();
call vc0x2x8_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s3092);
} else if ((choice) == (8)) {
call addressesToWhitelist_s3202 := FreshRefGenerator();
call vc0x2x9_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s3202);
} else if ((choice) == (7)) {
call bid_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (6)) {
call startAuction_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (5)) {
call depositBids_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (4)) {
call closeAuction_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call addressesToWhitelist_s3670 := FreshRefGenerator();
call addToWhitelist_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s3670);
} else if ((choice) == (2)) {
call __ret_0_currentPrice := currentPrice_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (1)) {
call __ret_0_priceAtElapsedTime := priceAtElapsedTime_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, secondsSinceStart_s3798);
}
}
}

procedure {:inline 1} onlyOwner_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation onlyOwner_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 17} (true);
assume ((msgsender_MSG) == (owner_Ownable[this]));
}

procedure {:inline 1} isInitialised_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation isInitialised_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 68} (true);
assume (initialized_DepositLocker[this]);
}

procedure {:inline 1} isDeposited_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation isDeposited_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 73} (true);
assume (deposited_DepositLocker[this]);
}

procedure {:inline 1} isNotDeposited_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation isNotDeposited_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 78} (true);
assume (!(deposited_DepositLocker[this]));
}

procedure {:inline 1} onlyDepositorsProxy_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation onlyDepositorsProxy_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 83} (true);
assume ((msgsender_MSG) == (depositorsProxy_DepositLocker[this]));
}

procedure {:inline 1} stateIs_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, state_s3300: int);
implementation stateIs_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, state_s3300: int)
{
assert {:first} {:sourceFile "/Users/etorres/Proyectos/verisol-test/output0/OutputTemp0.sol"} {:sourceLine 397} (true);
assume ((auctionState_ValidatorAuction[this]) == (state_s3300));
}

procedure CorralChoice_Ownable(this: Ref);
implementation CorralChoice_Ownable(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var newOwner_s43: Ref;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc newOwner_s43;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Ownable));
assume ((DType[msgsender_MSG]) != (DepositLockerInterface));
assume ((DType[msgsender_MSG]) != (DepositLocker));
assume ((DType[msgsender_MSG]) != (ValidatorAuction));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call transferOwnership_Ownable(this, msgsender_MSG, msgvalue_MSG, newOwner_s43);
}
}

procedure CorralEntry_Ownable();
implementation CorralEntry_Ownable()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((((DType[this]) == (Ownable)) || ((DType[this]) == (DepositLocker))) || ((DType[this]) == (ValidatorAuction)));
call Ownable_Ownable(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_Ownable(this);
}
}

procedure CorralChoice_DepositLockerInterface(this: Ref);
implementation CorralChoice_DepositLockerInterface(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var _depositorToBeSlashed_s49: Ref;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc _depositorToBeSlashed_s49;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Ownable));
assume ((DType[msgsender_MSG]) != (DepositLockerInterface));
assume ((DType[msgsender_MSG]) != (DepositLocker));
assume ((DType[msgsender_MSG]) != (ValidatorAuction));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call slash_DepositLockerInterface(this, msgsender_MSG, msgvalue_MSG, _depositorToBeSlashed_s49);
}
}

procedure CorralEntry_DepositLockerInterface();
implementation CorralEntry_DepositLockerInterface()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume (((DType[this]) == (DepositLockerInterface)) || ((DType[this]) == (DepositLocker)));
call DepositLockerInterface_DepositLockerInterface(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_DepositLockerInterface(this);
}
}

procedure CorralChoice_DepositLocker(this: Ref);
implementation CorralChoice_DepositLocker(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var newOwner_s43: Ref;
var _depositorToBeSlashed_s364: Ref;
var _releaseTimestamp_s192: int;
var _slasher_s192: Ref;
var _depositorsProxy_s192: Ref;
var _depositor_s228: Ref;
var _valuePerDepositor_s292: int;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc newOwner_s43;
havoc _depositorToBeSlashed_s364;
havoc _releaseTimestamp_s192;
havoc _slasher_s192;
havoc _depositorsProxy_s192;
havoc _depositor_s228;
havoc _valuePerDepositor_s292;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Ownable));
assume ((DType[msgsender_MSG]) != (DepositLockerInterface));
assume ((DType[msgsender_MSG]) != (DepositLocker));
assume ((DType[msgsender_MSG]) != (ValidatorAuction));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call transferOwnership_Ownable(this, msgsender_MSG, msgvalue_MSG, newOwner_s43);
} else if ((choice) == (5)) {
call slash_DepositLocker(this, msgsender_MSG, msgvalue_MSG, _depositorToBeSlashed_s364);
} else if ((choice) == (4)) {
call init_DepositLocker(this, msgsender_MSG, msgvalue_MSG, _releaseTimestamp_s192, _slasher_s192, _depositorsProxy_s192);
} else if ((choice) == (3)) {
call registerDepositor_DepositLocker(this, msgsender_MSG, msgvalue_MSG, _depositor_s228);
} else if ((choice) == (2)) {
call deposit_DepositLocker(this, msgsender_MSG, msgvalue_MSG, _valuePerDepositor_s292);
} else if ((choice) == (1)) {
call withdraw_DepositLocker(this, msgsender_MSG, msgvalue_MSG);
}
}

procedure CorralEntry_DepositLocker();
implementation CorralEntry_DepositLocker()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (DepositLocker));
call DepositLocker_DepositLocker(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_DepositLocker(this);
}
}

procedure CorralChoice_ValidatorAuction(this: Ref);
implementation CorralChoice_ValidatorAuction(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var newOwner_s43: Ref;
var addressesToWhitelist_s510: Ref;
var addressesToWhitelist_s624: Ref;
var addressesToWhitelist_s745: Ref;
var addressesToWhitelist_s860: Ref;
var addressesToWhitelist_s980: Ref;
var addressesToWhitelist_s1100: Ref;
var addressesToWhitelist_s1214: Ref;
var addressesToWhitelist_s1328: Ref;
var addressesToWhitelist_s1469: Ref;
var addressesToWhitelist_s1581: Ref;
var addressesToWhitelist_s1700: Ref;
var addressesToWhitelist_s1813: Ref;
var addressesToWhitelist_s1931: Ref;
var addressesToWhitelist_s2049: Ref;
var addressesToWhitelist_s2161: Ref;
var addressesToWhitelist_s2273: Ref;
var addressesToWhitelist_s2412: Ref;
var addressesToWhitelist_s2522: Ref;
var addressesToWhitelist_s2639: Ref;
var addressesToWhitelist_s2750: Ref;
var addressesToWhitelist_s2866: Ref;
var addressesToWhitelist_s2982: Ref;
var addressesToWhitelist_s3092: Ref;
var addressesToWhitelist_s3202: Ref;
var _startPriceInWei_s3396: int;
var _auctionDurationInDays_s3396: int;
var _minimalNumberOfParticipants_s3396: int;
var _maximalNumberOfParticipants_s3396: int;
var _depositLocker_s3396: Ref;
var addressesToWhitelist_s3670: Ref;
var __ret_0_currentPrice: int;
var secondsSinceStart_s3798: int;
var __ret_0_priceAtElapsedTime: int;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc newOwner_s43;
havoc addressesToWhitelist_s510;
havoc addressesToWhitelist_s624;
havoc addressesToWhitelist_s745;
havoc addressesToWhitelist_s860;
havoc addressesToWhitelist_s980;
havoc addressesToWhitelist_s1100;
havoc addressesToWhitelist_s1214;
havoc addressesToWhitelist_s1328;
havoc addressesToWhitelist_s1469;
havoc addressesToWhitelist_s1581;
havoc addressesToWhitelist_s1700;
havoc addressesToWhitelist_s1813;
havoc addressesToWhitelist_s1931;
havoc addressesToWhitelist_s2049;
havoc addressesToWhitelist_s2161;
havoc addressesToWhitelist_s2273;
havoc addressesToWhitelist_s2412;
havoc addressesToWhitelist_s2522;
havoc addressesToWhitelist_s2639;
havoc addressesToWhitelist_s2750;
havoc addressesToWhitelist_s2866;
havoc addressesToWhitelist_s2982;
havoc addressesToWhitelist_s3092;
havoc addressesToWhitelist_s3202;
havoc _startPriceInWei_s3396;
havoc _auctionDurationInDays_s3396;
havoc _minimalNumberOfParticipants_s3396;
havoc _maximalNumberOfParticipants_s3396;
havoc _depositLocker_s3396;
havoc addressesToWhitelist_s3670;
havoc __ret_0_currentPrice;
havoc secondsSinceStart_s3798;
havoc __ret_0_priceAtElapsedTime;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Ownable));
assume ((DType[msgsender_MSG]) != (DepositLockerInterface));
assume ((DType[msgsender_MSG]) != (DepositLocker));
assume ((DType[msgsender_MSG]) != (ValidatorAuction));
Alloc[msgsender_MSG] := true;
if ((choice) == (33)) {
call transferOwnership_Ownable(this, msgsender_MSG, msgvalue_MSG, newOwner_s43);
} else if ((choice) == (32)) {
call withdraw_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (31)) {
call addressesToWhitelist_s510 := FreshRefGenerator();
call vc0x0x0_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s510);
} else if ((choice) == (30)) {
call addressesToWhitelist_s624 := FreshRefGenerator();
call vc0x0x2_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s624);
} else if ((choice) == (29)) {
call addressesToWhitelist_s745 := FreshRefGenerator();
call vc0x0x3_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s745);
} else if ((choice) == (28)) {
call addressesToWhitelist_s860 := FreshRefGenerator();
call vc0x0x4_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s860);
} else if ((choice) == (27)) {
call addressesToWhitelist_s980 := FreshRefGenerator();
call vc0x0x6_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s980);
} else if ((choice) == (26)) {
call addressesToWhitelist_s1100 := FreshRefGenerator();
call vc0x0x7_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1100);
} else if ((choice) == (25)) {
call addressesToWhitelist_s1214 := FreshRefGenerator();
call vc0x0x8_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1214);
} else if ((choice) == (24)) {
call addressesToWhitelist_s1328 := FreshRefGenerator();
call vc0x0x9_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1328);
} else if ((choice) == (23)) {
call addressesToWhitelist_s1469 := FreshRefGenerator();
call vc0x1x0_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1469);
} else if ((choice) == (22)) {
call addressesToWhitelist_s1581 := FreshRefGenerator();
call vc0x1x2_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1581);
} else if ((choice) == (21)) {
call addressesToWhitelist_s1700 := FreshRefGenerator();
call vc0x1x3_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1700);
} else if ((choice) == (20)) {
call addressesToWhitelist_s1813 := FreshRefGenerator();
call vc0x1x4_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1813);
} else if ((choice) == (19)) {
call addressesToWhitelist_s1931 := FreshRefGenerator();
call vc0x1x6_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s1931);
} else if ((choice) == (18)) {
call addressesToWhitelist_s2049 := FreshRefGenerator();
call vc0x1x7_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2049);
} else if ((choice) == (17)) {
call addressesToWhitelist_s2161 := FreshRefGenerator();
call vc0x1x8_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2161);
} else if ((choice) == (16)) {
call addressesToWhitelist_s2273 := FreshRefGenerator();
call vc0x1x9_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2273);
} else if ((choice) == (15)) {
call addressesToWhitelist_s2412 := FreshRefGenerator();
call vc0x2x0_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2412);
} else if ((choice) == (14)) {
call addressesToWhitelist_s2522 := FreshRefGenerator();
call vc0x2x2_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2522);
} else if ((choice) == (13)) {
call addressesToWhitelist_s2639 := FreshRefGenerator();
call vc0x2x3_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2639);
} else if ((choice) == (12)) {
call addressesToWhitelist_s2750 := FreshRefGenerator();
call vc0x2x4_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2750);
} else if ((choice) == (11)) {
call addressesToWhitelist_s2866 := FreshRefGenerator();
call vc0x2x6_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2866);
} else if ((choice) == (10)) {
call addressesToWhitelist_s2982 := FreshRefGenerator();
call vc0x2x7_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s2982);
} else if ((choice) == (9)) {
call addressesToWhitelist_s3092 := FreshRefGenerator();
call vc0x2x8_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s3092);
} else if ((choice) == (8)) {
call addressesToWhitelist_s3202 := FreshRefGenerator();
call vc0x2x9_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s3202);
} else if ((choice) == (7)) {
call bid_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (6)) {
call startAuction_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (5)) {
call depositBids_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (4)) {
call closeAuction_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call addressesToWhitelist_s3670 := FreshRefGenerator();
call addToWhitelist_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, addressesToWhitelist_s3670);
} else if ((choice) == (2)) {
call __ret_0_currentPrice := currentPrice_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (1)) {
call __ret_0_priceAtElapsedTime := priceAtElapsedTime_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, secondsSinceStart_s3798);
}
}

procedure CorralEntry_ValidatorAuction();
implementation CorralEntry_ValidatorAuction()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var _startPriceInWei_s3396: int;
var _auctionDurationInDays_s3396: int;
var _minimalNumberOfParticipants_s3396: int;
var _maximalNumberOfParticipants_s3396: int;
var _depositLocker_s3396: Ref;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (ValidatorAuction));
call ValidatorAuction_ValidatorAuction(this, msgsender_MSG, msgvalue_MSG, _startPriceInWei_s3396, _auctionDurationInDays_s3396, _minimalNumberOfParticipants_s3396, _maximalNumberOfParticipants_s3396, _depositLocker_s3396);
while (true)
{
call CorralChoice_ValidatorAuction(this);
}
}


