terraform {
  required_version = "~> 0.11.8"
}

provider "aws" {
  version = "~> 1.40.0"
  region = "${var.region}"
}


resource "aws_instance" "dummy_cloud_agency" {
  ami = "${var.source-ami}"
  instance_type = "${var.instance-type}"
  key_name = "${var.keypair-name}"
  availability_zone = "${var.availability-zone}"
  tags = {
    Name = "terraformed-dummy-agency"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file(var.private-key-path)}"
  }

  provisioner "file" {
    source = "${path.module}/scripts"
    destination = "$HOME"
  }
}

data "template_file" "agency_config" {
  template = "${file("${path.module}/dummy_config.tpl")}"
  vars = {
    dummy_endpoint = "http://${aws_instance.dummy_cloud_agency.public_ip}:8080"
    wallet_id = "${var.agency_name}"
    workers = "[ \\\"0.0.0.0:8080\\\", \\\"0.0.0.0:8081\\\" ]"
    did = "VsKV7grR1BUE29mG2Fm2kX"
    did_seed = "0000000000000000000000000Forward"
  }
}

resource "null_resource" "provision" {

  connection {
    type = "ssh"
    host = "${aws_instance.dummy_cloud_agency.public_ip}"
    user = "ubuntu"
    private_key = "${file(var.private-key-path)}"
  }

  provisioner "remote-exec" {
    inline = [
      // problem with current ubuntu-indysdk image is that nvm and node are only available in interactive shell. Not when I ssh to the machine.
      // also INDY_SDK_SRC is not available
      // could solve by setting variables on top of .bashrc file, which by default returns on its top if the shell is not interactive
      // The scripts executed in terraform are:
      // Not sure whether it first establishes actual login connection, however, the code inside the
      // remote-exec is executed in "interactive/non-login" mode.
      "set -x",
      "export INDY_SDK_SRC=$HOME/indy-sdk",
      "ijump ${var.ijprovision}",
      "cargo build --manifest-path=\"$INDY_SDK_SRC\"/vcx/dummy-cloud-agent/Cargo.toml",
      "echo \"${data.template_file.agency_config.rendered}\" > \"$INDY_SDK_SRC\"/vcx/dummy-cloud-agent/config/${var.agency_name}.json",
      "cd \"$INDY_SDK_SRC\"/vcx/dummy-cloud-agent && cargo build",
      "echo 'cd \"$INDY_SDK_SRC\"/vcx/dummy-cloud-agent; RUST_LOG=\"indy=${var.log_level_indy},vcx=${var.log_level_vcx},indy_dummy_agent=${var.log_level_dummy}\" pm2 start cargo --name dummy -- run config/${var.agency_name}.json' > \"$HOME/startagent.sh\"",
      "chmod +x \"$HOME/startagent.sh\""
    ]
  }
}