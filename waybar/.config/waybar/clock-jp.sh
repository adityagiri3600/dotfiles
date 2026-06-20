#!/usr/bin/env bash
# Simple Waybar custom script that prints time + weekday in kanji as JSON

kanji=(日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日)
w=$(date +%w)
weekday=${kanji[w]}
time=$(date +%H:%M)
tooltip=$(date +"%d/%m/%Y  %H:%M:%S")

printf '%s\n' "{\"text\":\"<span size='12000'>${time}</span>  <span size='16000'>${weekday}</span>\",\"tooltip\":\"<span>${tooltip}</span>\"}"