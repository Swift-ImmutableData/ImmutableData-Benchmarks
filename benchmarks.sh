#!/bin/bash

set -eu

main() {
  results="Results"
  cycles=100
  
  mkdir -p "$results"
  
  while [ $cycles -gt 0 ]
  do
  swift run -c release CollectionsBenchmarks run --max-size 64k --cycles 1 --iterations 1 --disable-cutoff true ./"$results"/"$results".json
  
  cycles=$(($cycles-1))
  done
  
  swift run -c release CollectionsBenchmarks render --filter ".*Count.*" --amortized false ./"$results"/"$results".json ./"$results"/"$results"-0.png
  swift run -c release CollectionsBenchmarks render --filter ".*Delete.*" --amortized false ./"$results"/"$results".json ./"$results"/"$results"-1.png
  swift run -c release CollectionsBenchmarks render --filter ".*Insert.*" --amortized false ./"$results"/"$results".json ./"$results"/"$results"-2.png
  swift run -c release CollectionsBenchmarks render --filter ".*Read.*" --amortized false ./"$results"/"$results".json ./"$results"/"$results"-3.png
  swift run -c release CollectionsBenchmarks render --filter ".*Sort.*" --amortized false ./"$results"/"$results".json ./"$results"/"$results"-4.png
  swift run -c release CollectionsBenchmarks render --filter ".*Update.*" --amortized false ./"$results"/"$results".json ./"$results"/"$results"-5.png
  
  swift package --disable-sandbox -c release benchmark run --filter ".*Count.*" --format markdown --no-progress --grouping metric > ./"$results"/"$results"-0.txt
  swift package --disable-sandbox -c release benchmark run --filter ".*Delete.*" --format markdown --no-progress --grouping metric > ./"$results"/"$results"-1.txt
  swift package --disable-sandbox -c release benchmark run --filter ".*Insert.*" --format markdown --no-progress --grouping metric > ./"$results"/"$results"-2.txt
  swift package --disable-sandbox -c release benchmark run --filter ".*Read.*" --format markdown --no-progress --grouping metric > ./"$results"/"$results"-3.txt
  swift package --disable-sandbox -c release benchmark run --filter ".*Sort.*" --format markdown --no-progress --grouping metric > ./"$results"/"$results"-4.txt
  swift package --disable-sandbox -c release benchmark run --filter ".*Update.*" --format markdown --no-progress --grouping metric > ./"$results"/"$results"-5.txt
}

main
