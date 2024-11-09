parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Find file
f() {
    find -name "*$1*"
}

# Grep history
gh() {
    history | grep "$1"
}


# This requires the following VSCode extension: moshfeu.compare-folders
compare-folder(){
    COMPARE_FOLDERS=DIFF code $1 $2
}

compare-file(){
    code --diff $1 $2
}

n() {
    "$@" && notify-send "Command Completed: $*"
}

export PS1="\[\033[32m\]\w:\$(parse_git_branch)\[\033[00m\]\n$ "


# SONiC specific functions

sonic-ssh() {
  # Set default password if not provided
  local password="${2:-YourPaSsWoRd}"

  # Use the provided last part of the IP address
  local ip_suffix="$1"

  # Combine the prefix directly with the provided suffix
  local full_ip="192.168.122.${ip_suffix}"

  # SSH into the VM using sshpass and provided options
  sshpass -p "$password" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no admin@"$full_ip"
}

sonic-scp() {

  # Local file to transfer
  local local_file="$1"

  # Use the provided last part of the IP address
  local ip_suffix="$2"

  # Combine the prefix directly with the provided suffix
  local full_ip="192.168.122.${ip_suffix}"

  # Set default password if not provided
  local password="${3:-YourPaSsWoRd}"

  # Securely copy the file using sshpass and scp with provided options
  sshpass -p "$password" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "$local_file" admin@"$full_ip":"/home/admin"
}

sonic-install() {

    # Path to .img or .img.gz file                     
    local img_path="${1:-./sonic-vs.img}" 

    if [[ "$img_path" == *.gz ]]; then
        echo "Image is compressed, decompressing..."
        gzip -d "$img_path"
        img_path="${img_path%.gz}"
    fi

    local vm_name=$(basename $img_path .img)
    
    virt-install \
    --name "$vm_name" \
    --memory 6000 \
    --os-variant debian12 \
    --disk path="$img_path" \
    --import \
    --graphics none \
    --noautoconsole

    echo "Waiting for VM to start and get IP address..."
    local ip_info
    while true; do
        ip_info=$(virsh domifaddr "$vm_name" | grep ipv4)

        # Check if the IP address was found
        if [[ -n "$ip_info" ]]; then
            echo "VM is up and running. IP information:"
            echo "$ip_info"
            break
        else
            sleep 3
        fi
    done
}