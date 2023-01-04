// require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-waffle");


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  paths: {
    artifacts: "./frontend/src/artifacts"
  },
  networks:{
    ganache:{
    url:"HTTP://127.0.0.1:7545",
    account:"0x4402996c231846d9b11400846cb07c43f1ee810f2dbc323994108f454c08b34e"
  }}
};
