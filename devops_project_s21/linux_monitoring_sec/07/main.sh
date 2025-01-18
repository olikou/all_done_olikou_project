#!/bin/bash

# https://teletype.in/@justteam/prometheus-node-exporter-grafana-ubuntu-20-04#lJHC

if [ "$USER" == "student" ] ; then
    echo "Prometheus installation..."
    sudo apt install prometheus -y
    echo -e "\n\033[35mtry to open web interface in browser by port 9090 and press enter\033[0m"
    read T

    echo "Node Exporter installation..."
    curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep browser_download_url | grep linux-amd64 |  cut -d '"' -f 4 | wget -qi -
    tar xvf node_exporter-*linux-amd64.tar.gz
    cd node_exporter-*linux-amd64
    ./node_exporter
    echo -e "\033[35mNode Exporter is available by port 9100 by default\033[0m"
    
    echo "Grafana installation..."
    sudo apt-get install -y adduser libfontconfig1
    sudo apt install -y gnupg2 curl software-properties-common
    curl https://packages.grafana.com/gpg.key | sudo apt-key add -
    add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
    apt -y install grafana
    systemctl enable --now grafana-server
    systemctl start grafana-server

    echo -e "\033[35mGrafana is available by port 3000 by default\033[0m"
else
    echo -e "\033[31mget root and restart the script\033[0m"
fi
