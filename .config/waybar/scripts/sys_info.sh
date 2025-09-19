#!/bin/bash

# Function to get CPU usage
get_cpu_usage() {
    # Use mpstat (from sysstat) or top to calculate CPU usage
    cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | xargs printf "%.1f")
    echo "$cpu"
}

# Function to get RAM usage
get_ram_usage() {
    # Use free to get memory usage
    ram=$(free | grep Mem | awk '{print ($3/$2) * 100}' | xargs printf "%.1f")
    echo "$ram"
}

# Output format for Waybar (JSON)
output() {
    cpu=$(get_cpu_usage)
    ram=$(get_ram_usage)
    echo "{\"text\": \" ${cpu}% |  ${ram}%\", \"tooltip\": \"CPU: ${cpu}%\nRAM: ${ram}%\"}"
}

# Check if the script is triggered by a click
if [ "$1" = "click" ]; then
    notify-send "System Monitor" "CPU: $(get_cpu_usage)%\nRAM: $(get_ram_usage)%"
fi

# Watch for updates (optional, for continuous updates)
while true; do
    output
    sleep 1
done
