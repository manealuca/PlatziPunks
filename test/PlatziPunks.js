const {expect} = require("chai");
const { ethers } = require("hardhat");



describe('Plati Punks Contract',()=>{
    const setup = async ({ maxSupply = 10000}) => {
        const [owner] = await ethers.getSigners();
        const PlatiPunks = await ethers.getContractFactory("PlatziPunks");
        const deployed = await PlatiPunks.deploy(maxSupply);
        return{owner,deployed}
    }
    
    describe('Deployment',()=>{
        it('Sets max supply to passed params', async() =>{
            const maxSupply = 4000;
            const {deployed} = await setup({maxSupply});

            const returnedMaxSupply  = await deployed.maxSupply();
            expect(maxSupply).to.equal(returnedMaxSupply);
        })
    })

    describe("Minting", () => {
        it('Mints a new token assing it owner', async() =>{
            const {owner,deployed} = await setup({});
            await deployed.mint();

            const ownerOOfMinted = await deployed.ownerOf(0);
            expect(ownerOOfMinted).to.equal(owner.address)
            
        });
        it('Has a minting limit', async ()=>{
            const maxSupply = 2;
            const {deployed} = await setup({maxSupply})
            //MintAll
            await Promise.all()
            deployed.mint();
            deployed.mint();

            //Assert the last minting
            await expect(deployed.mint()).to.be.revertedWith("No platzi punks left :(");
        })
    })
    escribe("tokenURI",()=>{
        it('returns valid metadata',()=>{
            const {deployed}  = await setup({});
            await deployed.mint();
            const tokenURI = await deployed.tokenURI(0);
            const stringifiedTokenURI = await tokenURI.toString();
            const [, base64JSON] = stringifiedTokenURI.split(
                "data:application/json;base64,"
            );
            const stringifietMetadata = await Buffer.from(base64JSON,"base64").toString("ascii")
                expect(metadata) = JSON.parse(stringifietMetadata);
                expect(metadata).to.have.all.keys("name","description","image");
        })
    })
})