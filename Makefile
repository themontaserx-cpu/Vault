-include .env

deploy:
	forge create Vault --private-key ${PRIVATE_KEY_ANVIL} --rpc-url ${RPC_URL_ANVIL} --broadcast