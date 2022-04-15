async function main() {
    const Factory = await ethers.getContractFactory("ApparelMarketplace");
    console.log("Deploying factory!");
    const factoryProxy = await upgrades.deployProxy(Factory, ['0xd7f9e8738fb40f39add65e502e577f2efec46bac'], {kind: 'uups'});
    console.log(factoryProxy.address);
} 

main()
    .then(() => process.exit(0))
    .catch((err) => {
        console.log(err);
        process.exit(1);
    })