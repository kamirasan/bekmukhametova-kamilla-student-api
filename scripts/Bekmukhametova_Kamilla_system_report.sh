#!/bin/bash
# System monitoring report for student Kamilla Bekmukhametova
# Usage: ./scripts/Bekmukhametova_Kamilla_system_report.sh
# Output is printed to the screen and appended to the personal log file.

STUDENT_NAME="Kamilla Bekmukhametova"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$SCRIPT_DIR/../logs/Bekmukhametova_Kamilla_system_report.log"

report() {
    echo "=================================================="
    echo " SYSTEM REPORT — $STUDENT_NAME"
    echo "=================================================="
    echo "Student full name : $STUDENT_NAME"
    echo "Date and time     : $(date '+%Y-%m-%d %H:%M:%S %Z')"
    echo "Current user      : $(whoami)"
    echo
    echo "--- Operating system and kernel ---"
    if [ "$(uname -s)" = "Darwin" ]; then
        echo "OS                : $(sw_vers -productName) $(sw_vers -productVersion)"
    else
        echo "OS                : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
    fi
    echo "Kernel            : $(uname -sr)"
    echo "Architecture      : $(uname -m)"
    echo
    echo "--- CPU information ---"
    if [ "$(uname -s)" = "Darwin" ]; then
        echo "CPU model         : $(sysctl -n machdep.cpu.brand_string)"
        echo "CPU cores         : $(sysctl -n hw.ncpu)"
    else
        echo "CPU model         : $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | xargs)"
        echo "CPU cores         : $(nproc)"
    fi
    echo
    echo "--- Memory information ---"
    if [ "$(uname -s)" = "Darwin" ]; then
        echo "Total memory      : $(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) GB"
        vm_stat | head -5
    else
        free -h
    fi
    echo
    echo "--- Disk usage ---"
    df -h
    echo
    echo "--- Available disk space on / ---"
    df -h / | awk 'NR==2 {print "Available: " $4 " of " $2 " (used " $5 ")"}'
    echo
}

# tee -a: show on screen AND append (>>) to the log file
report | tee -a "$LOG_FILE"
echo "Report saved to: $LOG_FILE"
