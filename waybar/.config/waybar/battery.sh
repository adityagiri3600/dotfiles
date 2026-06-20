#!/usr/bin/env bash
# Battery display with PNG icons

BAT_PATH=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -1)
if [[ -z "$BAT_PATH" ]]; then
  echo '{"text":"N/A","class":"critical"}'
  exit 0
fi

CAPACITY=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")

class="good"
text=""

case "$STATUS" in
  "Charging")
    class="charging"
    text="Charging $CAPACITY%"
    ;;
  "Discharging")
    if [[ $CAPACITY -le 10 ]]; then
      class="critical"
      text="Critical $CAPACITY%"
    elif [[ $CAPACITY -le 20 ]]; then
      class="low"
      text="Low $CAPACITY%"
    elif [[ $CAPACITY -le 50 ]]; then
      class="battery-1"
      text="$CAPACITY%"
    elif [[ $CAPACITY -le 75 ]]; then
      class="battery-2"
      text="$CAPACITY%"
    else
      class="battery-3"
      text="$CAPACITY%"
    fi
    ;;
  "Full"|"Not charging")
    class="full"
    text="Full"
    ;;
esac

# Build tooltip
if [[ -f "$BAT_PATH/power_now" ]]; then
  power_mw=$(cat "$BAT_PATH/power_now")
  power_w=$(awk "BEGIN {printf \"%.1f\", $power_mw/1000000}")
  if [[ "$STATUS" == "Discharging" ]]; then
    tooltip="$power_w W ↓"
  else
    tooltip="$power_w W ↑"
  fi
else
  tooltip="$STATUS"
fi

tooltip="$tooltip at $CAPACITY%"

# Output JSON with class for CSS background-image
printf '%s' "{\"text\":\"$text\",\"tooltip\":\"$tooltip\",\"class\":\"$class\"}"
