# EC2 Ubuntu-IndySDK

Terraform automation to spin up Ubuntu 16.04 with precompiled [IndySDK](https://github.com/hyperledger/indy-sdk) 
binaries (libindy, libnullpay and libvcx).

Also includes [IndyJump](https://github.com/Patrik-Stas/indyjump) 
for easy management of the IndySDK binaries, and some extras (NVM, Node 8, Docker and Docker-Compose).

By default the instance is using `1.8.3 debug` version of all IndySDK binaries. Release version is precompiled on the 
system as well.  Use IndyJump to switch between IndySDK binaries version, or compile different versions. 