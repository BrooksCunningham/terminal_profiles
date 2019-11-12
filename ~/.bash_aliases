# Use seperate line for new terminal sessions. This should probably go in .bash_profile instead of aliases.
PS1="$PS1\n"

# Aliases
alias vba='vim ~/.bash_alias_personal'
alias tsharkwire='tshark -F pcap -w - | Wireshark -k -i -'
alias gcloudssh="gcloud alpha cloud-shell ssh"
alias vssh="vagrant ssh -- -D 4444"
alias sbash="source ~/.bashrc"
alias hprox='export http_proxy=socks5://127.0.0.1:4444 https_proxy=socks5://127.0.0.1:4444'
alias uhprox='unset http_proxy https_proxy'
alias urldecode='python3.6 -c "import sys;	from urllib import parse;	print(parse.unquote_plus(sys.argv[1]))"'
alias urlencode='python3.6 -c "import sys;      from urllib import urlencode;       print(urlencode(sys.argv[1]))"'
alias vimb='vim ~/.bashrc'
alias ll='ls -lah'
alias utc='date -u'

# Functions
#### datadog
function ddoghostname {
	curl -s "https://app.datadoghq.com/api/v1/hosts?api_key=${DATADOG_ORG_API_KEY}&application_key=${DATADOG_APPLICATION_API_KEY}&filter=$1" | jq '[.host_list[] | .name , .tags_by_source.Users]' -r
}

function nct {
        echo "nc -vz -w 5 $1 $2"
	nc -vz -w 5 $1 $2
}

function diga {
	dig +short $1
}

function digtxt {
	dig TXT +short $1
}

function curlqav {
        echo "curl -ik -sD - -o /dev/null -w ' time_namelookup:  %{time_namelookup}\n time_connect:  %{time_connect}\n time_appconnect:  %{time_appconnect}\n time_pretransfer:  %{time_pretransfer}\n time_redirect:  %{time_redirect}\n time_starttransfer:  %{time_starttransfer}\n time_total: %{time_total}\n' -H 'host: $1' http://"
}

function cnvdate {
	date --date='TZ=\"Asia/Taipei\" 15:00' +%F\ %H:%M
}


function chkcrt {
echo "---------------------------"
echo "Certificate Valid Dates"
echo "---------------------------"
echo | openssl s_client -connect $1:443 2>/dev/null | openssl x509 -noout -dates
echo "---------------------------"
echo "Certificate CN and DNS Info"
echo "---------------------------"
echo | openssl s_client -connect $1:443 2>/dev/null | openssl x509 -noout -text | grep DNS:
}

function chkcrtsni {
echo "---------------------------"
echo "Certificate Valid Dates"
echo "---------------------------"
echo | openssl s_client -connect $1:443 2>/dev/null -servername $2 | openssl x509 -noout -dates
echo "---------------------------"
echo "Certificate CN and DNS Info"
echo "---------------------------"
echo | openssl s_client -connect $1:443 2>/dev/null -servername $2 | openssl x509 -noout -text | grep DNS:
}


function ipinfo {
        curl -s https://ipinfo.io/$1 | jq
}

function orginfo {
	ip=`dig +short $1` | tail -n 1;
	curl -s https://ipinfo.io/${ip} | jq . ;
}

function curlqa {
	echo 'curl -ik -sD - -o /dev/null --resolve '$1':443:127.0.0.1 http://'$1':81 -H "host: '$1'"'
}

function chhost {
	sudo vim /etc/hosts
}
