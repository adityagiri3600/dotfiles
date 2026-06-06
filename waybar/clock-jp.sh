#!/usr/bin/env bash
# Simple Waybar custom script that prints time + weekday in kanji as JSON

kanji=(日 月 火 水 木 金 土)
w=$(date +%w)
weekday=${kanji[w]}
time=$(date +%H:%M)
tooltip=$(date +"%d/%m/%Y  %H:%M:%S")

printf '%s\n' "{\"text\":\"<span size='12000'>${time}</span>               <span size='18000'>${weekday}</span>\",\"tooltip\":\"<span>${tooltip}</span>\"}"