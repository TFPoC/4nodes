 var initVal = 23 ;
 a = eth.accounts[0]
web3.eth.defaultAccount = a;
var ballot_sol_simplestorageContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"storedData","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"x","type":"uint256"}],"name":"set","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"retVal","type":"uint256"}],"payable":false,"type":"function"},{"inputs":[{"name":"initVal","type":"uint256"}],"payable":false,"type":"constructor"}]);
var ballot_sol_simplestorage = ballot_sol_simplestorageContract.new(
   initVal,
   {
     from: web3.eth.accounts[0], 
     data: '0x6060604052341561000c57fe5b60405160208061013a833981016040528080519060200190919050505b806000819055505b505b60f9806100416000396000f30060606040526000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632a1afcd914604e57806360fe47b11460715780636d4ce63c14608e575bfe5b3415605557fe5b605b60b1565b6040518082815260200191505060405180910390f35b3415607857fe5b608c600480803590602001909190505060b7565b005b3415609557fe5b609b60c2565b6040518082815260200191505060405180910390f35b60005481565b806000819055505b50565b600060005490505b905600a165627a7a72305820025adef1b244e98ef75f3f566c7bbadcbfdbf6c4ae7bec165e74d109966480600029', 
     gas: '4700000'
   }, function (e, contract){
    if (e) {
    console.log("err creating contract", e);
  } else {
    if (!contract.address) {
      console.log("Contract transaction send: TransactionHash: " + contract.transactionHash + " waiting to be mined...");
    } else {
      console.log("Contract mined! Address: " + contract.address);
      console.log(contract);
    }
  }
 })
