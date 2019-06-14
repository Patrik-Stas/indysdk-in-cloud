{
  \"app\": {
    \"prefix\": \"/agency\"
  },
  \"forward_agent\": {
    \"did\": \"${did}\",
    \"did_seed\": \"${did_seed}\",
    \"endpoint\": \"${dummy_endpoint}\",
    \"wallet_id\": \"${wallet_id}\",
    \"wallet_passphrase\": \"key\"
  },
  \"server\": {
    \"addresses\": ${workers},
    \"workers\": 2
  },
  \"wallet_storage\": {
    \"config\": null,
    \"credentials\": null,
    \"type\": null
  },
  \"protocol_type\": \"1.0\"
}