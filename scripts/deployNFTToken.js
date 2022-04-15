let NFTTokenAddress;

async function main() {
    const Factory = await ethers.getContractFactory("NFTBase");
    console.log("Deploying factory");
    const factoryProxy = await upgrades.deployProxy(Factory, {kind: 'uups'})
    console.log("factory proxy address: ", factoryProxy.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error  => {
      console.log(error);
      process.exit(1);
    })