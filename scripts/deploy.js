const hre = require("hardhat");

async function main() {
  const Event = await hre.ethers.getContractFactory("EventOrganizer");
  const event = await Event.deploy();

  await event.deployed();
  console.log(event.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
