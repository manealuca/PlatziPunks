const { ethers } = require("hardhat");

//llena automaticamenta el proyecto con la configuracion realizada para el proyecto
const deploy = async() =>{
    const [deployer] = await ethers.getSigners();    
    console.log("Deploying contract with the account: ",deployer.address);
    const PlatziPunks = await ethers.getContractFactory();//toma la informacion del contrato de la cache y nos trae la informacion apra generar los metodos y desplegar el contrato
    const deployed = await PlatziPunks.deploy(10000);
    console.log("Platzi Punks is deployed at: ",deploy.address);
};

deploy().then(()=>process.exit(0)).catch(error=> {
    console.log(error);
    process.exit(1);
});