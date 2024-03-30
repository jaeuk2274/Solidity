var readline = require('readline');
var namehash = require('eth-ens-namehash');


var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});


rl.question('Enter an ENS address: ', function(ethereum_name) {
    var hash = namehash.hash(ethereum_name);
    var decimalHash = BigInt('0x' + hash.slice(2)).toString();
    console.log(`
[${ethereum_name}]
* Hex => ${hash}
* Decimal => ${decimalHash}
    `);
    rl.close();
});

