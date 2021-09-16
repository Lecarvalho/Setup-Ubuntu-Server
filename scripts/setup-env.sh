service_exists() {
    local n=$1
    if service --status-all | grep -Fq $n; then
        return 0
    else
        return 1
    fi
}

file_exists() {
    if [ -f $1 ]; then
        return 0
    else 
        return 1
    fi
}

directory_exists() {
    if [ -d $1 ]; then
        return 0
    else
        return 1
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

entropy=$(cat /proc/sys/kernel/random/entropy_avail)

if [[ $entropy > 1000 ]]; then
    echo "entropy has a good value: $entropy"
else
    echo "entropy is too slow ($entropy), need to fix it installing haveged"
    sh install-haveged.sh
fi

sh allow-ports.sh

sh configure-docker-network.sh