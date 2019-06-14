# Automate creation of Dummy Cloud Agent in AWS
- First create IndySDK capable instance following instructions [here](../ec2-ubuntu-indysdk)
- Once the EC2 instance is build, create AMI out of it
- Supply the AMI ID into `source-ami` of this project and build it
- SSH into the created machine and run `~/startagent.sh`. This will start up dummy cloud agent on public IP of 
the created EC2 instance. 
- You can test dummy cloud agent is running from the EC2 instance: `curl http://localhost:8080/agency`
 
