#!/bin/bash

# Usage:
# ./load_test.sh <root_count> <orders_count> <catalogue_count>

ROOT_COUNT=$1
ORDERS_COUNT=$2
CATALOGUE_COUNT=$3

# Base URL of your API (change to your actual Minikube IP or NodePort)
BASE_URL="https://192.168.58.2:31184/"

# Concurrent requesters for each test
CONCURRENCY=50

echo "Starting load test with:"
echo "  / endpoint      -> $ROOT_COUNT requests"
echo "  /orders endpoint -> $ORDERS_COUNT requests"
echo "  /catalogue endpoint -> $CATALOGUE_COUNT requests"
echo "  Using $CONCURRENCY concurrent requesters each"

# Run each test in the background
echo "/ endpoint"
hey -z 60s -c "$CONCURRENCY" "$BASE_URL/" &

echo "/orders endpoint"
hey -z 60s -c "$CONCURRENCY" "$BASE_URL/orders" &

echo "/catalogue endpoint"
hey -z 60s -c "$CONCURRENCY" "$BASE_URL/catalogue" &

# Wait for all background processes to finish
wait

echo "✅ Load test complete."

