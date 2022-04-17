require("@nomiclabs/hardhat-waffle");
require('dotenv').config()

const RINKEBY_RPC_URL = process.env.INFURA;
const PRIVATE_KEY = process.env.PRIVATE_KEY;


module.exports = {
  solidity: "0.8.4",
  networks:{
    rinkeby: {
      url: `https://rinkerby.infura.io/v3/${RINKEBY_RPC_URL}`,
      accounts: [
        //Llave privada de la wallet Owner del proyecto
        [PRIVATE_KEY]
      ]
    }
  }
};
