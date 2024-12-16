/*
 * @source: http://blockchain.unica.it/projects/ethereum-survey/attacks.html#simpledao
 * @author: -
 * @vulnerable_at_lines: 19
 */

pragma solidity ^0.5.1;

contract SimpleDAO {
  mapping (address => uint) public credit;

  uint balance;
  uint senders_in_mapping = 0;
	address A;

  // Re-entrancy analysis
	address _last;
	struct ReentrantSender {
      address sender;
      uint value;
  }
  ReentrantSender[] senders_reentrant;
  bool lock = false;

  constructor(address _A) public {
      A = _A;
  }

  function donate(address to) public payable {
    if (msg.value > 0) {
        balance = balance + msg.value;
        if (credit[to] == 0) {
            senders_in_mapping += 1;
        }
    }
    credit[to] += msg.value;
  }

  function withdraw_Init(uint amount) public  {
    require(senders_in_mapping > 0);
    require (!lock);
    lock = true;
    if (credit[msg.sender]>= amount) {
      // <yes> <report> REENTRANCY
      // bool res = msg.sender.call.value(amount)();
      balance -= amount;//added
      senders_reentrant.push(ReentrantSender(msg.sender, amount));
    }
  }

  function withdraw_End() public  {
    require (senders_reentrant.length > 0);
    require (true);
		uint256 value = senders_reentrant[senders_reentrant.length-1].value;
    senders_reentrant.length --;

    if (credit[msg.sender]> 0) {
      credit[msg.sender] -= value;
      if (value > 0 && credit[msg.sender] == 0) {
        senders_in_mapping -= 1;
      }
    }
    lock = false;
  }

  function queryCredit(address to) public view returns (uint){
    return credit[to];
  }

  function dummy_balanceGTZero() public view { require(balance > 0); }
  function dummy_balanceAGTZero() public view { require(credit[A] > 0); }
}
