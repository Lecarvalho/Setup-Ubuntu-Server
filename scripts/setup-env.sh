service_exists() {
    local n=$1
    if [[ $(systemctl list-units --all -t service --full --no-legend "$n.service" | sed 's/^\s*//g' | cut -f1 -d' ') == $n.service ]]; then
        return 0
    else
        return 1
    fi
}

file_exists() {
    if [ -f $n ]; then
        return 1
    else 
        return 0
    fi
}

directory_exists() {
    if [ -d $1 ]; then
        return 1
    else
        return 0
    fi
}

if directory_exists "/Workspace"; then
    echo "/Workspace already exists";
else 
    sh create-workspace-dir.sh
fi

if service_exists docker; then
    echo "docker already installed"
else 
    sh install-docker.sh
fi

if file_exists "/usr/local/bin/docker-compose"; then
    echo "docker-compose already installed"
else
    sh install-docker-compose.sh
fi

sh open-ports.sh