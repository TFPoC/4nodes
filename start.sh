#!/bin/bash
set -u
set -e
NETID=1329417
BOOTNODE_KEYHEX=32b1004425c6ff69350235b963febe0134be083493b6ad038a16df614a58ff7d
BOOTNODE_ENODE=enode://a5791501ea72489d31f53bcce00a7f5ba18bd5540977cd3664e803d1e68cbba7b3608352c8e01bb023cf7d5f724751ddc6af695715e97d74065c2f0ae5d7713b@[127.0.0.1]:33445

GLOBAL_ARGS="--bootnodes $BOOTNODE_ENODE --networkid $NETID --rpccorsdomain="*" --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum"

echo "[*] Starting Constellation nodes"
nohup constellation-node tm1.conf 2>> qdata/logs/constellation1.log &
sleep 1
nohup constellation-node tm2.conf 2>> qdata/logs/constellation2.log &
nohup constellation-node tm3.conf 2>> qdata/logs/constellation3.log &
nohup constellation-node tm4.conf 2>> qdata/logs/constellation4.log &

echo "[*] Starting bootnode"
nohup bootnode --nodekeyhex "$BOOTNODE_KEYHEX" --addr="127.0.0.1:33445" 2>>qdata/logs/bootnode.log &
echo "wait for bootnode to start..."
sleep 6

echo "[*] Starting node 1"
PRIVATE_CONFIG=tm1.conf nohup geth --verbosity 6 --datadir qdata/dd1 $GLOBAL_ARGS --rpcport 22000 --port 21000 --unlock 0 --password passwords.txt 2>>qdata/logs/1.log &

echo "[*] Starting node 2"
PRIVATE_CONFIG=tm2.conf nohup geth --verbosity 6 --datadir qdata/dd2 $GLOBAL_ARGS --rpcport 22001 --port 21001 --voteaccount "0xbde357122f5769c18e6f52ae22702bb4c38dbfbc" --votepassword "" --blockmakeraccount "0x3c3358110f21035d0a43ed9132dcd53764357d4f" --blockmakerpassword "" --singleblockmaker --minblocktime 2 --maxblocktime 5 2>>qdata/logs/2.log &

echo "[*] Starting node 3"
PRIVATE_CONFIG=tm3.conf nohup geth --verbosity 6 --datadir qdata/dd3 $GLOBAL_ARGS --rpcport 22002 --port 21002  --voteaccount "0xa7e03334b759299544f9b8bf6d7e7c23b74e4b9e" --votepassword "" 2>>qdata/logs/3.log &

echo "[*] Starting node 4"
PRIVATE_CONFIG=tm4.conf nohup geth --datadir qdata/dd4 $GLOBAL_ARGS --rpcport 22003 --port 21003 2>>qdata/logs/4.log &

echo "[*] Waiting for nodes to start"
sleep 10
echo "[*] Sending first transaction"
PRIVATE_CONFIG=tm1.conf geth --exec 'loadScript("script1.js")' attach ipc:qdata/dd1/geth.ipc

echo "All nodes configured. See 'qdata/logs' for logs, and run e.g. 'geth attach qdata/dd1/geth.ipc' to attach to the first Geth node"


