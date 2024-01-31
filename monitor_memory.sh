#!/bin/bash

# 另一个脚本的路径
ANOTHER_SCRIPT="/home/steam/pal-server-tools/pal_server_reboot.sh"

# 获取内存使用信息
memory_usage=$(free | grep "内存" | awk '{print $3/$2 * 100.0}')

# 检查内存使用是否超过90%
if (( $(echo "$memory_usage > 90" | bc -l) )); then
    echo "内存使用超过90%，正在重启pal-server"
    /bin/bash $ANOTHER_SCRIPT
else
    echo "当前内存使用率为: $memory_usage%"
fi
