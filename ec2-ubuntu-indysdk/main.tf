terraform {
  required_version = "~> 0.11.8"
}

provider "aws" {
  version = "~> 1.40.0"
  region = "${var.region}"
}


resource "aws_instance" "docker-ami-template" {
  ami = "${var.source-ami}"
  instance_type = "${var.instance-type}"
  key_name = "${var.keypair-name}"
  availability_zone = "${var.availability-zone}"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file(var.private-key-path)}"
    agent = "true"
  }

  tags {
    Name = "${var.instance-name}"
  }

  provisioner "file" {
    source = "${path.module}/scripts"
    destination = "$HOME"
  }

  provisioner "remote-exec" {
    inline = [
      "set -x",
      "set -e",

      "export TF_INSTALL_NODE_VERSION='v8.16.0'",
      "export TF_INSTALL_CARGO='0.36.0-0ubuntu1~16.04.1'",
      "export TF_INSTALL_INDYJUMP_VERSION='v1.1.0'",
      "export TF_INSTALL_INDYSDK='v1.8.3'",

      "echo 'Making custom scripts executable'",
      "chmod +x \"$HOME/scripts/\"*.sh",

      "echo 'Installing docker'",
      "$HOME/scripts/install-docker.sh",

      "echo 'Updating apt'",
      "sudo apt update",

      "echo 'Installing NVM and Node'",
      "\"$HOME\"/scripts/install-nvm-node.sh \"$TF_INSTALL_NODE_VERSION\"",

      "echo 'Installing libindy dependencies'",
      "sudo \"$HOME/scripts/install-dependencies.sh\"",

      "echo 'Installing libindy libsodium'",
      "sudo \"$HOME/scripts/install-libsodium.sh\"",

      "echo 'Installing cargo'",
      "sudo apt-get install -y cargo=\"$TF_INSTALL_CARGO\"",

      "echo 'Cloning indy-sdk, indyjump'",
      "git clone https://github.com/hyperledger/indy-sdk.git indy-sdk",
      "git clone https://github.com/Patrik-Stas/indyjump.git indyjump",
      "cd indy-sdk; git checkout \"$TF_INSTALL_INDYSDK\"; cd \"$HOME\"",
      "cd indyjump; git checkout \"$TF_INSTALL_INDYJUMP_VERSION\"; cd \"$HOME\"",

      "echo 'Installing indyjump'",
      "echo 'export INDY_SDK_SRC=$HOME/indy-sdk' >> \"$HOME\"/.bashrc",
      "export INDY_SDK_SRC=$HOME/indy-sdk",
      "sudo \"$HOME\"/indyjump/install.sh",

      "echo \"Indyjump provisioning indy-sdk at debug version $TF_INSTALL_INDYSDK\"",
      "ijcreate \"$TF_INSTALL_INDYSDK.debug\" debug",

      "echo \"Indyjump provisioning indy-sdk at release version $TF_INSTALL_INDYSDK\"",
      "ijcreate \"$TF_INSTALL_INDYSDK.release\" release",

      "rm \"$HOME/scripts/\"*",
      "rmdir \"$HOME/scripts\"",
    ]
  }
}