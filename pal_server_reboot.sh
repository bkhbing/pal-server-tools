#!/bin/bash

# RCON服务器的端口和密码
RCON_PORT=<RCONport>
ADMIN_PASSWORD=<Adminpassword>
# 设置备份存档路径
target_dir="/home/steam/Pal/AutoSaved"
# 设置游戏路径
game_dir="/home/steam/Steam/steamapps/common/PalServer"

# 发送RCON命令
send_rcon_command() {
    echo "$1" | ./ARRCON -P $RCON_PORT -p $ADMIN_PASSWORD
}

# 存档
auto_save(){
    date=$(date +"%Y-%m-%d")
    time=$(date +"%H:%M:%S")
    mkdir -p "$target_dir"
    tar -czf "$target_dir/Saved_${date}_${time}.tar.gz" -C "$game_dir/Pal/Saved" .
    echo "存档已经备份到 $target_dir"
}

# 开启服务器
start_pal_server(){
    echo "正在启动PalServer"
    cd $game_dir
    nohup ./PalServer.sh &
    sleep 5
    if ps aux | grep -q "PalServer.sh"; then
        echo "PalServer成功启动"
    else
        echo "PalServer启动失败"
    fi
}

# 关闭服务器
stop_pal_server(){
    send_rcon_command "save"
    sleep 1
    send_rcon_command "shutdown 120 The_server_will_be_rebooting_in_2_minutes"
    sleep 60
    send_rcon_command "broadcast The_server_will_be_rebooting_in_1_minutes"
    sleep 30
    send_rcon_command "broadcast The_server_will_be_rebooting_in_30_seconds"
    sleep 20
    send_rcon_command "broadcast The_server_will_be_rebooting_in_10_seconds"
    sleep 5
    send_rcon_command "broadcast The_server_will_be_rebooting_in_5_seconds"
    sleep 1
    send_rcon_command "broadcast The_server_will_be_rebooting_in_4_seconds"
    sleep 1
    send_rcon_command "broadcast The_server_will_be_rebooting_in_3_seconds"
    sleep 1
    send_rcon_command "broadcast The_server_will_be_rebooting_in_2_seconds"
    sleep 1
    send_rcon_command "broadcast The_server_will_be_rebooting_in_1_seconds"
}

stop_pal_server
sleep 10
auto_save
start_pal_server