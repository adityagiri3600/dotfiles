#!/usr/bin/env bash
# Simple Waybar custom script that prints time + weekday in kanji as JSON
kanji=(日 月 火 水 木 金 土)
w=$(date +%w)
weekday=${kanji[w]}
time=$(date +%H:%M)
tooltip=$(date +"%d/%m/%Y  %H:%M:%S")
printf '%s' "{\"text\":\"${time} ${weekday}\",\"tooltip\":\"<span>${tooltip}</span>\"}"
