#!/bin/bash

# 设置备份存档路径
target_dir="/home/steam/Pal/AutoSaved"
# 设置游戏路径
game_dir="/home/steam/Steam/steamapps/common/PalServer"

# 存档
auto_save(){
    date=$(date +"%Y-%m-%d")
    time=$(date +"%H:%M:%S")
    mkdir -p "$target_dir"
    tar -czf "$target_dir/Saved_${date}_${time}.tar.gz" -C "$game_dir/Pal/Saved" .
    echo "存档已经备份到 $target_dir"
}

auto_save