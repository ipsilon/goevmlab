#!/bin/bash

# evm="/home/martin/workspace/evm"
# nethtest="/home/martin/workspace/nethtest"
# besuvm="/home/martin/workspace/besu-vm"
# erigonvm="/home/martin/workspace/erigon-evm"
# nimbus="/home/martin/workspace/evmstate"

### Geth

if [[ -n "$evm" ]]; then
    echo "geth"
    cd ./cases
    # The traces
    for i in *.json; do
        $evm --json --nomemory --noreturndata statetest $i \
         2>../traces/$i.geth.stderr.txt \
         1>../traces/$i.geth.stdout.txt
    done
    # And the stateroots, where we invoke the evm the same way that
    # GetStateRoot does
    for i in *.json; do
        $evm statetest $i \
         2>../roots/$i.geth.stderr.txt \
         1>../roots/$i.geth.stdout.txt
    done
    cd ..
fi


### Nethermind

if [[ -n "$nethtest" ]]; then
    echo "nethermind"
    cd ./cases
    for i in *.json; do
        $nethtest --memory --trace --input $i \
         2>../traces/$i.nethermind.stderr.txt \
         1>../traces/$i.nethermind.stdout.txt
    done
    for i in *.json; do
        $nethtest --memory --neverTrace -s --input $i \
         2>../roots/$i.nethermind.stderr.txt \
         1>../roots/$i.nethermind.stdout.txt
    done
    cd ..
fi


### Besu

if [[ -n "$besuvm" ]]; then
    echo "besu"
    cd ./cases
    for i in *.json; do
        $besuvm --json --nomemory --notime state-test $i \
          2>../traces/$i.besu.stderr.txt \
          1>../traces/$i.besu.stdout.txt
    done
    for i in *.json; do
        $besuvm --nomemory --notime state-test $i \
         2>../roots/$i.besu.stderr.txt \
         1>../roots/$i.besu.stdout.txt
    done
    cd ..
fi

### Erigon

if [[ -n "$erigonvm" ]]; then
    echo "erigon"
    cd ./cases
    for i in *.json; do
        $erigonvm  --json --nomemory --noreturndata statetest $i \
         2>../traces/$i.erigon.stderr.txt \
         1>../traces/$i.erigon.stdout.txt
    done
    for i in *.json; do
        $erigonvm statetest $i \
         2>../roots/$i.erigon.stderr.txt \
         1>../roots/$i.erigon.stdout.txt
    done
    cd ..
fi

# Nimbus
if [[ -n "$nimbus" ]]; then
    echo "nimbus"
    cd ./cases
    # The traces
    for i in *.json; do
        $nimbus --json --nomemory --noreturndata --nostorage $i \
         2>../traces/$i.nimbus.stderr.txt \
         1>../traces/$i.nimbus.stdout.txt
    done
    # And the stateroots, where we invoke the evm the same way that
    # GetStateRoot does
    for i in *.json; do
        $nimbus  $i \
         2>../roots/$i.nimbus.stderr.txt \
         1>../roots/$i.nimbus.stdout.txt
    done
    cd ..
fi
