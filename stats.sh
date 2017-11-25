#!/bin/bash

# Copyright (c) 2012, Haggis
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met :
#
#   * Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright notice,
#     this list of conditions and the following disclaimer in the documentation
#     and/or other materials provided with the distribution.
#   * Neither the name of any individual or organization nor the names of its
#     contributors may be used to endorse or promote products derived from this
#     software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# ( INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION ) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT ( INCLUDING NEGLIGENCE OR OTHERWISE ) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Author: Mik McLean <haggistech@gmail.com>

########################################################################
#                           Global Variables                           #
########################################################################

localver=1.0.1
currver=$(curl https://raw.githubusercontent.com/haggistech/haggistech_stats/master/ver.txt 2> /dev/null)
clear
echo
if [ $currver != $localver ]; then
echo "You have Version $localver. The latest version is $currver Please Update!"
echo
echo "You can update by running the following command"
echo
echo "curl https://raw.githubusercontent.com/haggistech/haggistech_stats/master/stats.sh > stats.sh"
sleep 5
fi




unset os         # Human-readable (pretty) name of the operating system
unset host       # Hostname
unset kernel     # Linux kernel build string

unset days       # Days the system has been online
unset hours      # Hours the system has been online (in relation to days)
unset label      # Precision of days, hours, minutes, or seconds
unset day_label  # day/days
unset hour_label # hour/hours

unset totalram   # Size of installed RAM in kilabytes
unset ram        # Size of installed RAM in megabytes
unset free	# Size of used RAM in megabytes
unset user       # Name of the user running this script
unset res        # Resolution of the current X session
unset load       # Load average since the last reboot
unset cpu        # CPU identifier information

unset de         # Desktop environment (or window manager) running
unset ver        # DE version information, if available

########################################################################
#                           Primary Functions                          #
########################################################################

# Print a pretty logo for the Linux distribution the user is running.
function print_logo
{
exists=`ls /etc/ | grep "-release" | wc -l`
if [ "$exists" -gt "0" ]; then
#if [ -e /etc/*-release ]; then
    id="$(cat /etc/*-release 2>/dev/null | grep -E '^ID[ ]*=[ ]*[A-Za-z]+[ ]*' | cut -d '=' -f 2)"
    case $id in
        ubuntu)
            echo "                                       "
            echo "              ..''''''..               "
            echo "          .;::::::::::::::;.           "
            echo "       .;::::::::::::::'.':::;.        "
            echo "     .;::::::::;,'..';.   .::::;.      "
            echo "    .:::::::,.,.      ....:::::::.     "
            echo "   .:::::::.   :;::::,.   .:::::::.    "
            echo "   ;::::::   .::::::::::.   ::::::;    "
            echo "   :::.  .'  ::::::::::::...,::::::    "
            echo "   :::.  .'  ::::::::::::...,::::::    "
            echo "   ;::::::   .::::::::::.   ::::::;    "
            echo "   .:::::::.   :,;::;,.   .:::::::.    "
            echo "    .:::::::;.;.      ....:::::::.     "
            echo "      ;::::::::;,'..';.   .::::;       "
            echo "       .;::::::::::::::'.':::;.        "
            echo "          .,::::::::::::::,.           "
            echo "              ...''''...               "
            echo "                                       "
            ;;
	debian)
	 echo '                                       '
            echo '              _,met$$$$$gg.            '
            echo '           ,g$$$$$$$$$$$$$$$P.         '
            echo '         ,g$$P$$       $$$Y$$.$.       '
            echo '        ,$$P`              `$$$.       '
            echo '       ,$$P       ,ggs.     `$$b:      '
            echo '       d$$`     ,$P$`   .    $$$       '
            echo '       $$P      d$`     ,    $$P       '
            echo '       $$:      $$.   -    ,d$$`       '
            echo '       $$;      Y$b._   _,d$P`         '
            echo '       Y$$.     .`$Y$$$$P$`            '
            echo '       `$$b      $-.__                 '
            echo '        `Y$$b                          '
            echo '         `Y$$.                         '
            echo '           `$$b.                       '
            echo '             `Y$$b.                    '
            echo '               `$Y$b._                 '
            echo '                   `$$$$               '
            echo '                                       '
            ;;
        linuxmint)
            echo '                                       '
            echo '    .:::::::::::::::::::::::::;,.          '
            echo '    ,0000000000000000000000000000Oxl,      '
            echo '    ,00,                       ..,cx0Oo.   '
            echo '    ,00,       ,,.                  .cO0o  '
            echo '    ,00l,,.   `00;       ..     ..    .k0x '
            echo '    `kkkkO0l  `00;    ck000Odlk000Oo.  .00c'
            echo '         d0k  `00;   x0O:.`d00O;.,k00.  x0x'
            echo '         d0k  `00;  .00x   ,00o   ;00c  d0k'
            echo '         d0k  `00;  .00d   ,00o   ,00c  d0k'
            echo '         d0k  `00;  .00d   ,00o   ,00c  d0k'
            echo '         d0k  `00;   ;;`   .;;.   .cc`  d0k'
            echo '         d0O  .00d                ...   d0k'
            echo '         ;00,  :00x:,,,,        .....   d0k'
            echo '          o0O,  .:dO000k...........     d0k'
            echo '           :O0x,                        x0k'
            echo '             :k0Odc,`.................;x00k'
            echo '               .;lxO0000000000000000000000k'
            echo '                     ......................'
            echo '                                       '
            ;;
        fedora)
            echo '                                       '
            echo '                  ___                  '
            echo '            ,g@@@@@@@@@@@p,            '
            echo '         ,@@@@@@@@@@@D****4@@.         '
            echo '       ,@@@@@@@@@@P`        `%@.       '
            echo '      y@@@@@@@@@@F   ,g@@p.  !3@k      '
            echo '     !@@@@@@@@@@@.  !@@@@@@@@@@@@k     '
            echo '    :@@@@@@@@@@@@   J@@@@@@@@@@@@@L    '
            echo '    J@@@@@@@@@***   `***@@@@@@@@@@)    '
            echo '    J@@@@@@@@@          @@@@@@@@@@)    '
            echo '    J@@@@@@@@@@@@   J@@@@@@@@@@@@@L    '
            echo '    J@@@@@@@@@@@@   J@@@@@@@@@@@@F     '
            echo '    J@@@@@@@@@@@F   {@@@@@@@@@@@F      '
            echo '    J@@@E.  ``*^`   i@@@@@@@@@@B^      '
            echo '    J@@@@@._      ,@@@@@@@@@@P`        '
            echo '    J@@@@@@@@@@@@@@@@@@BP*`            '
            echo '                                       '
            ;;
               *)
            echo '                                            '
            echo '                 .88888888:.                '
            echo '                88888888.88888.             '
            echo '              .8888888888888888.            '
            echo '              888888888888888888            '
            echo '              88| _`88|_  `88888            '
            echo '              88 88 88 88  88888            '
            echo '              88_88_::_88_:88888            '
            echo '              88:::,::,:::::8888            '
            echo '              88`:::::::::``8888            '
            echo '             .88  `::::`    8:88.           '
            echo '            8888            `8:888.         '
            echo '          .8888`             `888888.       '
            echo '         .8888:..  .::.  ...:`8888888:.     '
            echo '        .8888.|     :|     `|::`88:88888    '
            echo '       .8888        `         `.888:8888.   '
            echo '      888:8         .           888:88888   '
            echo '    .888:88        .:           888:88888:  '
            echo '    8888888.       ::           88:888888   '
            echo '    `.::.888.      ::          .88888888    '
            echo '   .::::::.888.    ::         :::`8888`.:.  '
            echo '  ::::::::::.888   |         .::::::::::::  '
            echo '  ::::::::::::.8    |      .:8::::::::::::. '
            echo ' .::::::::::::::.        .:888::::::::::::: '
            echo ' :::::::::::::::88:.__..:88888:::::::::::`  '
            echo '  ``.:::::::::::88888888888.88:::::::::`    '
            echo '        ``:::_:` -- `` -`-` ``:_::::``      '
            echo '                                            '
            ;;
    esac
fi

}

# Take a screenshot and save it in the user's home directory.
function print_screenshot
{
    echo "    Screenshot being taken.....$(tput bold)$(tput setaf 4)Smile!!$(tput sgr0)"
    echo
    import -window root "$HOME/Screenshot_$(/bin/date +%Y%m%d.%H%M).png"
    echo "    Screenshot Saved as $HOME/Screenshot_$(/bin/date +%Y%m%d.%H%M).png"
}

# Collect release information.
function get_release
{
test=$(lsb_release -a 2>/dev/null | grep Description:| sed -r 's/Description:"?([^"]+)"?/\1/')
os=${test#"${test%%[![:space:]]*}"}
#exists=`ls /etc/ | grep "-release" | wc -l`
#if [ -f /etc/debian_version ]; then
#os='Debian'

#elif [ "$exists" -gt "0" ]; then
#    os=$(cat /etc/*-release | grep "^PRETTY_NAME=" | sed -r 's/PRETTY_NAME="?([^"]+)"?/\1/')
#    [ -z "$os" ] && os='Not Found'
  
#elif [ "$exists" -gt "0" ]; then
#if [ "$(cat /etc/*-release | grep "^DISTRIB_ID=" | sed -r 's/DISTRIB_ID="?([^"]+)"?/\1/')" == "LinuxMint" ]; then
#os='Linux Mint'
#fi
#fi
  host=$(uname -n)
    kernel=$(uname -r)
}

# Save the uptime at the time this function is executed.
function get_uptime
{
    # Since uptime changes constantly, save it before parsing so the output is consistent.
    current_uptime="$(uptime)"
    # Parse the uptime snapshot.
    days=$(echo $current_uptime | awk '{print $3}' | sed 's/,//g')
    if [ "$days" = 1 ]; then
        day_label='day'
    else
        day_label='days'
    fi
    hours=$(echo $current_uptime | awk '{print $5}' | sed 's/,//g')
    if [ "$hours" = 1 ]; then
        hour_label='hour'
    else
        hour_label='hours'
    fi
    label=$(echo $current_uptime | awk '{print $4}')
}

# Collect generic system statistics.
function get_system_stats
{
    totalram=$(awk '/MemTotal/{print $2}' /proc/meminfo)
    ram=$((totalram/1024))
    freeram=$(awk '/MemAvailable/{print $2}' /proc/meminfo)
    free=$((freeram/1024))
    user=$(whoami)
    res=$(xdpyinfo | grep dimensions | awk {'print $2'})
    load=$(uptime | awk -F 'load average:' '{ print $2 }')
    # AFAIK there is no standard identification strings between CPU architectures.
    case $(arch) in
        x86_64|i386|i486|i586|i686)
            cpu="$(cat /proc/cpuinfo | grep 'model name' | head -n 1 | cut -d ':' -f 2-)"
            ;;
        ppc)
            cpu="$(cat /proc/cpuinfo | grep -E '^cpu' | head -n 1 | cut -d ':' -f 2-)"
            cpu="${cpu}   @$(cat /proc/cpuinfo | grep -E '^clock' | head -n 1 | cut -d ':' -f 2-)"
            ;;
        arm*)
            cpu=$(cat /proc/cpuinfo | grep 'Processor' | head -n 1 | cut -d ':' -f 2-)
            ;;
        *)
            cpu='Unknown'
            ;;
    esac
}

# Determine which desktop environment the user is running.
function get_desktop_environment
{
    # $DESKTOP_SESSION in an UNRELIABLE method for determining which
    # desktop environment is running. It is tied to the display manager,
    # not the desktop environment itself. It is useful, though, when it
    # is set.
    if [ -z "$DESKTOP_SESSION" ]; then
        if [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}kdeinit')" ]; then
            DESKTOP_SESSION='kde-plasma'
        elif [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}cinnamon')" ]; then
            DESKTOP_SESSION='cinnamon'
        elif [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}unity')" ]; then
            DESKTOP_SESSION='unity'
        elif [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}gnome-session')" ]; then
            DESKTOP_SESSION='gnome'
        elif [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}lxsession')" ]; then
            DESKTOP_SESSION='LXDE'
        elif [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}xfce.*-session')" ]; then
            DESKTOP_SESSION='xfce'
        elif [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}mate-session')" ]; then
            DESKTOP_SESSION='mate'
        elif [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}openbox')" ]; then
            DESKTOP_SESSION='openbox'
        elif [ -n "$(ps xo cmd | grep -v 'grep' | grep -E '([/][A-Za-z]+)*[/]{0,1}fluxbox')" ]; then
            DESKTOP_SESSION='fluxbox'
        fi
    fi


    if [ -n "$KDE_FULL_SESSION" ]; then
        de='KDE'
        ver=$(kde-open -v | awk '/Platform/ {print $4}')
    elif [ "$DESKTOP_SESSION" == 'cinnamon' ]; then
        de='Cinnamon'
        ver=$(cinnamon --version | cut -d ' ' -f 2)
    elif [ "$DESKTOP_SESSION" == 'ubuntu' ]; then
        de='Unity'
        ver=$(unity --version | cut -d ' ' -f 2)
    elif [ -n "$GNOME_DESKTOP_SESSION_ID" ]; then
        de='GNOME'
        ver=$(gnome-session --version | awk {'print $2'})
    elif [ "$DESKTOP_SESSION" == 'LXDE' ]; then
        de='LXDE'
        ver=$(lxpanel --version | cut -d ' ' -f 2)
    elif [ "$DESKTOP_SESSION" == 'xfce' ]; then
        de='XFCE'
        ver=$(xfce4-session --version | head -n 1 | cut -d ' ' -f 2)
    elif [ "$DESKTOP_SESSION" == 'mate' ]; then
        de='Mate'
        ver=$(mate-session --version | cut -d ' ' -f 2)
elif [ -f "$(mate-session --version)" ]; then
        de='Mate'
        ver=$(mate-session --version | cut -d ' ' -f 2)
    elif [ "$DESKTOP_SESSION" == 'openbox' ]; then
        de='Openbox'
        ver=$(openbox --version | head -n 1 | cut -d ' ' -f 2)
    elif [ "$DESKTOP_SESSION" == 'fluxbox' ]; then
        de='Fluxbox'
        ver=$(fluxbox -version | head -n 1 | cut -d ' ' -f 2)
    else
        de='Not Found'
    fi
}
function get_processes {
processes="$(ps aux --sort -rss | head | awk {'print $11'} | sed -n '2p')"
}

########################################################################
#                                 Main                                 #
########################################################################

#clear

get_release
get_uptime
get_system_stats
get_desktop_environment
get_processes

echo
print_logo
echo
echo "    $(tput bold)$(tput setaf 4)OS:$(tput sgr0) $os"
echo "    $(tput bold)$(tput setaf 4)Hostname:$(tput sgr0) $host"
if [ "$label" = 'min,' ]; then
    echo "    $(tput bold)$(tput setaf 4)Uptime:$(tput sgr0) $days minutes"
elif [[ "$label" = 'day,' || "$label" = 'days,' ]]; then
    echo "    $(tput bold)$(tput setaf 4)Uptime:$(tput sgr0) $days $day_label, $hours $hour_label"
elif [ "$label" = '2' ]; then
    echo "    $(tput bold)$(tput setaf 4)Uptime:$(tput sgr0) $days hours"
fi
echo "    $(tput bold)$(tput setaf 4)CPU:$(tput sgr0)$cpu"
echo "    $(tput bold)$(tput setaf 4)RAM (free / total):$(tput sgr0) $free $(tput bold)$(tput setaf 4)/$(tput sgr0) $ram $(tput bold)$(tput setaf 4)Mb$(tput sgr0)"
echo "    $(tput bold)$(tput setaf 4)Desktop Enviroment:$(tput sgr0) $de $ver"
echo "    $(tput bold)$(tput setaf 4)Logged in as:$(tput sgr0) $user"
echo "    $(tput bold)$(tput setaf 4)Kernel:$(tput sgr0) $kernel"
echo "    $(tput bold)$(tput setaf 4)Resolution:$(tput sgr0) $res $(tput bold)$(tput setaf 4)pixels$(tput sgr0)"
echo "    $(tput bold)$(tput setaf 4)Load Averages:$(tput sgr0)$load"
echo "    $(tput bold)$(tput setaf 4)Top Process (by memory use): $(tput sgr0)$processes"
echo
echo
# print_screenshot
# echo
# echo
