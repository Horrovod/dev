#!/bin/bash

# Check if Bluetooth is powered on
powered_on() {
    bluetoothctl show | grep -q "Powered: yes"
}

# Power on if off
if ! powered_on; then
    bluetoothctl power on > /dev/null
    sleep 2  # Give time for power on
fi

# Function to scan for new devices
scan_devices() {
    bluetoothctl scan on > /dev/null &
    sleep 10  # Scan for 10 seconds
    bluetoothctl scan off > /dev/null
}

# Get list of paired devices with MAC and name
paired_devices=$(bluetoothctl paired-devices | awk '{print $2 " " substr($0, index($0,$3))}')

# Check connected status for each
devices=""
while IFS= read -r line; do
    mac=$(echo "$line" | awk '{print $1}')
    name=$(echo "$line" | cut -d' ' -f2-)
    connected=$(bluetoothctl info "$mac" | grep "Connected: yes" && echo " (Connected)" || echo "")
    devices+="$mac $name$connected\n"
done <<< "$paired_devices"

# Add options for scanning and powering off
options="Scan for devices\nPower off\n$devices"

# Show Rofi menu
selected=$(echo -e "$options" | rofi -dmenu -i -p "Bluetooth Devices" -lines 10 -width 30)

if [ -z "$selected" ]; then
    exit 0
fi

case "$selected" in
    "Scan for devices")
        scan_devices
        # Re-run the script to refresh the list
        exec "$0"
        ;;
    "Power off")
        bluetoothctl power off > /dev/null
        ;;
    *)
        mac=$(echo "$selected" | awk '{print $1}')
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            bluetoothctl disconnect "$mac" > /dev/null
        else
            bluetoothctl connect "$mac" > /dev/null
        fi
        ;;
esac

# Optional: Force Waybar update (if needed, depending on your setup)
pkill -RTMIN+8 waybar  # Adjust signal if using custom signals in Waybar#!/bin/bash

# Check if Bluetooth is powered on
powered_on() {
    bluetoothctl show | grep -q "Powered: yes"
}

# Power on if off
if ! powered_on; then
    bluetoothctl power on > /dev/null
    sleep 2  # Give time for power on
fi

# Function to scan for new devices
scan_devices() {
    bluetoothctl scan on > /dev/null &
    sleep 10  # Scan for 10 seconds
    bluetoothctl scan off > /dev/null
}

# Get list of paired devices with MAC and name
paired_devices=$(bluetoothctl paired-devices | awk '{print $2 " " substr($0, index($0,$3))}')

# Check connected status for each
devices=""
while IFS= read -r line; do
    mac=$(echo "$line" | awk '{print $1}')
    name=$(echo "$line" | cut -d' ' -f2-)
    connected=$(bluetoothctl info "$mac" | grep "Connected: yes" && echo " (Connected)" || echo "")
    devices+="$mac $name$connected\n"
done <<< "$paired_devices"

# Add options for scanning and powering off
options="Scan for devices\nPower off\n$devices"

# Show Rofi menu
selected=$(echo -e "$options" | rofi -dmenu -i -p "Bluetooth Devices" -lines 10 -width 30)

if [ -z "$selected" ]; then
    exit 0
fi

case "$selected" in
    "Scan for devices")
        scan_devices
        # Re-run the script to refresh the list
        exec "$0"
        ;;
    "Power off")
        bluetoothctl power off > /dev/null
        ;;
    *)
        mac=$(echo "$selected" | awk '{print $1}')
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            bluetoothctl disconnect "$mac" > /dev/null
        else
            bluetoothctl connect "$mac" > /dev/null
        fi
        ;;
esac

# Optional: Force Waybar update (if needed, depending on your setup)
pkill -RTMIN+8 waybar  # Adjust signal if using custom signals in Waybar#!/bin/bash

# Check if Bluetooth is powered on
powered_on() {
    bluetoothctl show | grep -q "Powered: yes"
}

# Power on if off
if ! powered_on; then
    bluetoothctl power on > /dev/null
    sleep 2  # Give time for power on
fi

# Function to scan for new devices
scan_devices() {
    bluetoothctl scan on > /dev/null &
    sleep 10  # Scan for 10 seconds
    bluetoothctl scan off > /dev/null
}

# Get list of paired devices with MAC and name
paired_devices=$(bluetoothctl paired-devices | awk '{print $2 " " substr($0, index($0,$3))}')

# Check connected status for each
devices=""
while IFS= read -r line; do
    mac=$(echo "$line" | awk '{print $1}')
    name=$(echo "$line" | cut -d' ' -f2-)
    connected=$(bluetoothctl info "$mac" | grep "Connected: yes" && echo " (Connected)" || echo "")
    devices+="$mac $name$connected\n"
done <<< "$paired_devices"

# Add options for scanning and powering off
options="Scan for devices\nPower off\n$devices"

# Show Rofi menu
selected=$(echo -e "$options" | rofi -dmenu -i -p "Bluetooth Devices" -lines 10 -width 30)

if [ -z "$selected" ]; then
    exit 0
fi

case "$selected" in
    "Scan for devices")
        scan_devices
        # Re-run the script to refresh the list
        exec "$0"
        ;;
    "Power off")
        bluetoothctl power off > /dev/null
        ;;
    *)
        mac=$(echo "$selected" | awk '{print $1}')
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            bluetoothctl disconnect "$mac" > /dev/null
        else
            bluetoothctl connect "$mac" > /dev/null
        fi
        ;;
esac

# Optional: Force Waybar update (if needed, depending on your setup)
pkill -RTMIN+8 waybar  # Adjust signal if using custom signals in Waybar
