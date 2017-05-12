#!/bin/bash
set -u
set -e

echo "[*] Cleaning up temporary data directories"
rm -rf qdata
mkdir -p qdata/logs

echo "[*] Configuring node 1"
mkdir -p qdata/dd1/keystore
cp keys/key1 qdata/dd1/keystore
geth --datadir qdata/dd1 init genesis.json

echo "[*] Configuring node 2 as block maker and voter"
mkdir -p qdata/dd2/keystore
cp keys/key2 qdata/dd2/keystore
cp keys/key3 qdata/dd2/keystore
geth --datadir qdata/dd2 init genesis.json

echo "[*] Configuring node 3"
mkdir -p qdata/dd3/keystore
cp keys/key4 qdata/dd3/keystore
geth --datadir qdata/dd3 init genesis.json

echo "[*] Configuring node 4"
mkdir -p qdata/dd4/keystore
geth --datadir qdata/dd4 init genesis.json
