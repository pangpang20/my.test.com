#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

cd "$SCRIPT_DIR" || exit

echo "Current script directory: $SCRIPT_DIR"
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
else
    echo "Virtual environment already exists, skip creation."
fi
echo "Activate the virtual environment"
source .venv/bin/activate
echo "Virtual environment activated. Python path: $(which python)"

if [ ! -d "$(python3 -c 'import site; print(site.getsitepackages()[0])')/psycopg2" ]; then
    echo "Installing psycopg2..."
    echo "Get GaussDB driver..."
    wget -O /tmp/GaussDB_driver.zip https://dbs-download.obs.cn-north-1.myhuaweicloud.com/GaussDB/1730887196055/GaussDB_driver.zip

    echo "Install GaussDB driver..."
    unzip -o /tmp/GaussDB_driver.zip -d /tmp/ && rm -rf /tmp/GaussDB_driver.zip 
    \cp /tmp/GaussDB_driver/Centralized/Hce2_arm_64/GaussDB-Kernel_505.2.0_Hce_64bit_Python.tar.gz /tmp/ 
    tar -zxvf /tmp/GaussDB-Kernel_505.2.0_Hce_64bit_Python.tar.gz -C /tmp/ 


    echo "Install new psycopg2..."
    \cp /tmp/psycopg2 $(python3 -c 'import site; print(site.getsitepackages()[0])') -r 
    chmod 755 $(python3 -c 'import site; print(site.getsitepackages()[0])')/psycopg2 -R

    echo "Set environment variables..."
    echo 'export PYTHONPATH="${PYTHONPATH}:$(python3 -c '\''import site; print(site.getsitepackages()[0])'\'')"' >> .venv/bin/activate
    echo 'export LD_LIBRARY_PATH="/tmp/lib:$LD_LIBRARY_PATH"' >> .venv/bin/activate
else
    echo "psycopg2 already exists, skip installation."
fi


grep -rl postgresql | grep -E "\.py$|\.sql$|\.toml$|\.md$" | xargs sed -i 's/postgresql/gaussdbdws/g'
grep -rl postgres_ | grep -E "\.py$|\.sql$|\.toml$|\.md$" | xargs sed -i 's/postgres_/gaussdbdws_/g'

echo "Install requirements..."
pip install pyyaml
pip install tqdm

