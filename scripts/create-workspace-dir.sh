if [-d "/Workspace" ]; then
    echo "Directory already exists";
else
    `sudo mkdir -m 777 /Workspace`;
fi