#!/bin/bash

# Section B: Artificial Intelligence Department
# Lab Title: Shell-Based Data Preprocessing Pipeline

# 1. Environment Setup & Variables
DATA_DIR="AI_Datasets"

# Create directory and navigate into it
# Check if directory exists to avoid errors or clean up previous runs
if [ -d "$DATA_DIR" ]; then
    echo "Directory $DATA_DIR already exists. Cleaning up for fresh start..."
    rm -rf "$DATA_DIR"
fi

mkdir "$DATA_DIR"
cd "$DATA_DIR" || exit

echo "=========================================="
echo "   AI Data Preprocessing Pipeline Started"
echo "=========================================="

# 2. The Dataset Loop
# Simulate generation of 5 raw data files
echo "Generating raw data files..."
for i in {1..5}
do
    FILENAME="raw_data_$i.txt"
    # Create file with random content size to simulate different sizes
    # We use /dev/urandom to generate random data and base64 to make it text-safe
    # Size will be roughly between 500 and 1500 bytes
    head -c $((RANDOM % 1024 + 500)) < /dev/urandom | base64 > "$FILENAME"
    echo "Created $FILENAME"
done

# 3. Categorize based on size (Inferred from Scenario description)
echo "------------------------------------------"
echo "Categorizing files based on size..."
mkdir -p Small Large

for file in raw_data_*.txt; do
    # Get file size in bytes
    size=$(wc -c < "$file")
    echo "Processing $file (Size: $size bytes)"
    
    # Threshold set to 1000 bytes for demonstration
    if [ "$size" -lt 1000 ]; then
        mv "$file" Small/
        echo " -> Moved to Small/"
    else
        mv "$file" Large/
        echo " -> Moved to Large/"
    fi
done

# 4. Calculate dataset splits (Inferred from Scenario description)
echo "------------------------------------------"
echo "Calculating dataset splits..."
total_files=5
# Calculate 80% for training
train_split=$((total_files * 80 / 100))
# Remaining for testing
test_split=$((total_files - train_split))

echo "Total Files Processed: $total_files"
echo "Training Set (80%): $train_split files"
echo "Testing Set (20%): $test_split files"

echo "=========================================="
echo "   Pipeline Completed Successfully"
echo "=========================================="
