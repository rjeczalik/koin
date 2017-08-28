pragma solidity ^0.4.0;

contract koin {
	address public minter;
	mapping (address => uint) public balances;

	event Sent(address from, address to, uint amount);

	// Koin initializes DApp state setting the owner
	// of the koin.
	function koin(uint premined) {
		minter = msg.sender;
		balances[minter] += premined
	}

	// Mint gives the specified amount of koin to the given address.
	//
	// If the caller is not an owner, the function fails with code 1.
	//
	// If the call was successful, function returns 0.
	function mint(address receiver, uint amount) returns (uint code) {
		if (msg.sender != minter) {
			return 1;
		}

		balances[receiver] += amount;
		return 0;
	}

	// Send transfers the specified amount of koin from the caller
	// to the given address.
	//
	// If the caller has not enough koin, the method fails with code 2.
	//
	// If the call was successful, function returns 0.
	function send(address receiver, uint amount) returns (uint code) {
		if (balances[msg.sender] < amount) {
			return 2;
		}

		balances[msg.sender] -= amount;
		balances[receiver] += amount;

		Sent(msg.sender, receiver, amount);
		return 0;
	}
}
