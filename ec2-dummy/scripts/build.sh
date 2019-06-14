#!/bin/bash

(cd indy-sdk/vcx/dummy-cloud-agent/; cargo build
npm install -g pm2
vi ~/indy-sdk/vcx/dummy-cloud-agent/config/sample-config.json
(cd ~/indy-sdk/vcx/dummy-cloud-agent; RUST_LOG='indy=warn,vcx=warn,indy_dummy_agent=warn'  pm2 start cargo --name dummy -- run config/sample-config.json)
curl -v localhost:8081/agency

