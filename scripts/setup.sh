#!/bin/bash
scripts/reset.sh

test_mnemonic="wage thunder live sense resemble foil apple course spin horse glass mansion midnight laundry acoustic rhythm loan scale talent push green direct brick please"

blackCore init test --chain-id test
echo $test_mnemonic | blackCore keys add test --recover --keyring-backend test
blackCore add-genesis-account test 100000000000000uxprt,100000000000000stake --keyring-backend test
blackCore gentx test 10000000stake --chain-id test --keyring-backend test
blackCore collect-gentxs