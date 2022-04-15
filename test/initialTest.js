const {ethers} = require('hardhat');
const {expect} = require('chai');

let Contract;
let contract;
let child;
describe('NFT Base', function() {
    beforeEach(async function() {
        Contract = await ethers.getContractFactory("NFTBaseFactory");
        contract = await upgrades.deployProxy(Contract, {kind: 'uups'});
        await contract.deployed()
        console.log(contract.address);
        child = await contract.deployNFT("NFTBase", "NFTB")
    })

    it('Testing ', async function() {    
        expect((await child.name) === "NFTBase");
    });
});