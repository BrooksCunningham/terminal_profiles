# Aliases
alias chromefetch="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --disable-features=EnforcePrivacySandboxAttestations"
alias vba='vim ~/.bash_alias_personal'
alias tsharkwire='tshark -F pcap -w - | Wireshark -k -i -'
alias gcloudssh="gcloud alpha cloud-shell ssh"
alias vssh="vagrant ssh -- -D 4444"
alias sbash="source ~/.bashrc"
alias hprox='export http_proxy=socks5://127.0.0.1:4444 https_proxy=socks5://127.0.0.1:4444'
alias uhprox='unset http_proxy https_proxy'
alias urldecode='python -c "import sys;	from urllib import parse;	print(parse.unquote_plus(sys.argv[1]))"'
alias urlencode='python -c "import sys; from urllib.parse import quote;       print(quote(sys.argv[1]))"'
alias jsondumps='python -c "import json; print(json.dumps(sys.argv[1]))"'
alias vimb='vim ~/.bashrc'
alias ll='ls -lah'
alias utc='date -u'
alias rbpie='ssh pi@192.168.1.80'
alias utc='date -u'
alias clip='pbcopy'
alias ipqs='curl "https://www.ipqualityscore.com/api/json/ip/$IPQSKEY/184.168.200.148" | jq'
alias tlssessionkeys_export='export SSLKEYLOGFILE="/Users/brookscunningham/.mitmproxy/sslkeylogfile.txt"'
#alias webup='node /Users/brookscunningham/Documents/random/app.js'
alias webp='python3 -m http.server'
alias webup='webp'
alias js-publish='npm install; npm run build; npm run deploy'
alias dps='docker ps --filter "label=lab"'
alias rustmon='cargo watch -c -s "fastly compute serve" --watch src/main.rs'

# Terraform alias
alias tfaa='terraform apply -auto-approve -parallelism=1'
alias tfda='terraform destroy -auto-approve -parallelism=1'
alias tfra='sleep 10 ; tfda ; sleep 10 ; tfaa'
alias tfforget='terraform state rm $(terraform state list)'
alias tfg='terraform plan -generate-config-out=generated_resources.tf'

# https://askubuntu.com/questions/829537/how-to-change-owner-of-folder-to-current-user-recursively and https://github.com/desktop/desktop/issues/3616#issuecomment-400371047
alias fixGithubDesktop='sudo find "/Applications/GitHub Desktop.app" -type d -user root -exec sudo chown -R $USER: {} +'

# Uses the range for the first 5 chars in the hash. https://haveibeenpwned.com/API/v2#PwnedPasswords
alias haveibeenpwned="echo 'curl https://api.pwnedpasswords.com/range/21BD1'"

function curlrltest() {
    for i in {1..100} ; do
        sleep 1;
        printf "$i\t"
        date | tr -d '\n'; printf '\t'
        curl -i -o /dev/null https://$@/anything/rl-test/$i -H 'rate-limit:abc' -d foo=bar -w 'response_code: %{response_code}'
        echo
    done
}

function curlloop() {
    # Loop 20 times
    echo "
for i in {1..20}; do
    # Execute the command
    http $1 api-key:secretkey foo=bar -p=h | head -n1 

    # Sleep for 1 second
    sleep 1; done"
}

function curlxxs() {
    echo "curl -ik -sD - -o /dev/null \"$@/brooks?<script>alert('brooks')</script>\""
    curl -ik -sD - -o /dev/null "$@/brooks?<script>alert('brooks')</script>"
}
function curlbig() {
    echo 'curl -i "https://$@/anything/whydopirates?likeurls=theargs" -d `for x in {1..8999}; do printf 1 ; done`'
}

function percent-encode() {
    python ~/.profile_scripts/url_encode.py $@ -a
    echo
}

function peerdb {
    curl "https://www.peeringdb.com/api/net?asn__in=${1}" | jq 
}

function busted {
    while :; do sleep 2 ; http "${1}`printf $((1 + $RANDOM % 99999))`" ; done
}

function rps {
    echo "Command: ${1} / 31 / 24 / 60 / 60"
    expr $1 / 31 / 24 / 60 / 60
}

function docupdate {
    echo "docker stop  $1 ; docker rm $1 ; docker build -t $1 ./ ; docker run --name $1 -p 127.0.0.1:81:80 -i -t $1"
}

# conda aliases
alias browser_bot='conda activate browser_bot'
alias deactivate='conda deactivate'

# Functions

#### DNS History
function getdnshistory {
  curl -s "https://api.securitytrails.com/v1/history/$1/dns/a" -H "apikey: $SECURITYTRAILS" | jq .
}

function getdnssubdomains {
  curl -s "https://api.securitytrails.com/v1/domain/$1/subdomains" -H "apikey: $SECURITYTRAILS" | jq .
}

#### datadog
function ddoghostname {
	curl -s "https://app.datadoghq.com/api/v1/hosts?api_key=${DATADOG_ORG_API_KEY}&application_key=${DATADOG_APPLICATION_API_KEY}&filter=$1" | jq '[.host_list[] | .name , .tags_by_source.Users]' -r
}

function nct {
        echo "nc -vz -w 5 $1 $2"
	nc -vz -w 5 $1 $2
}

function digshort {
    echo "digging for `printf $1 | sed 's/^https:\/\///g' | sed 's/\/.*//g'`"
	dig +short `printf $1 | sed 's/^https:\/\///g' | sed 's/\/.*//g'`
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
    echo "Checking server ${1}"
    echo "---------------------------"
    echo "Certificate Valid Dates"
    echo "---------------------------"
    true | openssl s_client -connect $1:443 2>/dev/null | openssl x509 -noout -dates
    echo "---------------------------"
    echo "Certificate CN and DNS Info"
    echo "---------------------------"
    true | openssl s_client -connect $1:443 2>/dev/null | openssl x509 -noout -text | grep DNS:
    echo "---------------------------"
    echo "Certificate issuer"
    echo "---------------------------"
    true | openssl s_client -connect $1:443 2>/dev/null | openssl x509 -noout -issuer
    echo "---------------------------"
    echo "Certificate Verify"
    echo "---------------------------"
    true | openssl s_client -connect $1:443 2>/dev/null -verify_hostname $1 | grep Verify
}

function chkcrtsni {
    echo "Checking server ${1} for certificate ${2}"
    echo "---------------------------"
    echo "Certificate Valid Dates"
    echo "---------------------------"
    true | openssl s_client -connect $1:443 2>/dev/null -servername $2 | openssl x509 -noout -dates
    echo "---------------------------"
    echo "Certificate CN and DNS Info"
    echo "---------------------------"
    true | openssl s_client -connect $1:443 2>/dev/null -servername $2 | openssl x509 -noout -text | grep DNS:
    echo "---------------------------"
    echo "Certificate issuer"
    echo "---------------------------"
    true | openssl s_client -connect $1:443 2>/dev/null -servername $2 | openssl x509 -noout -issuer
    echo "---------------------------"
    echo "Certificate Verify"
    echo "---------------------------"
    true | openssl s_client -connect $1:443 2>/dev/null -servername $2 -verify_hostname $2 -verify 2 | grep Verify
}

function getdomain {
    echo "Domain:" $1;
    whois $1 | grep "Registar URL" | tail -1;
    echo "DNS:"
    dig +short NS $1 | sed 's/.$//';
    curl -s "http://ip-api.com/{$1}?fields=isp,org,as,query" | sed -e '1d;$d ; s/"//g ; s/^..// ; s/,$//';
    curl -s "https://www.whatruns.com/website/{$1}" | grep ":{" | cut -d'{' -f9-99 | sed 's/}],/\n/g' | sed -e 's/\"//g; s/\[{name:/\n/g; s/},{name:/\n/g' | cut -d',' -f1 | sed '/:/s/^/\n/';
}


function ipinfo {
        curl -s https://ipinfo.io/$1 | jq
}

function orginfo {
	ip=`dig +short $1` | tail -n 1;
	curl -s https://ipinfo.io/${ip} | jq . ;
}

function curlqa {
    echo 'Testing the domain '$1' at the host '$2
	echo 'curl -ik -sD - -o /dev/null --resolve '$1':443:`dig +short '$2' | tail -n1` https://'$1''
}

function chhost {
    #vim /etc/hosts
    vim /etc/private/hosts
}

function enable_mitmproxy_transparent (){
    echo ""
    echo "Amending IP Forwarding"
    sudo sysctl -w net.inet.ip.forwarding=1
    sudo sysctl -w net.inet6.ip6.forwarding=1
    sudo pfctl -f /etc/pf.conf.tmp 
    sudo pfctl -e

    #echo "PF - DEBUG Check all filters etc."
    #sudo pfctl -s all

    echo ""
    echo "Ready to run mitmproxy proxy machine in Transparent Proxy Mode, with Client configured as custom gateway."
    echo ""
    echo "Source 1: https://docs.mitmproxy.org/stable/concepts-modes/#transparent-proxy"
    echo "Source 2: https://docs.mitmproxy.org/stable/howto-transparent/"
    echo "Source 3: https://docs.mitmproxy.org/stable/concepts-certificates/"
    echo ""
    echo ""
    echo "Short Instructions:"

    echo "1. Run mitmproxy as normal (not able to monitor macOS local network traffic)..."
    #find_ip=$(ifconfig en0 | grep 'inet' | grep -v 'inet6' | awk '{print $2}')
    echo "sudo mitmproxy --mode transparent --showhost"

    echo ""
    echo "2. Go to Mobile Device, edit WiFi settings. Change IP Settings to Static."

    echo ""
    echo "3. Choose a static IP, and add ** $find_ip ** as the Default Gateway."

    echo ""
    echo "4. Open a browser to http://mitm.it on the Mobile Device, add Certificate."

    echo ""

    # Run if monitoring local traffic
    #echo "Now run....."
    #echo "sudo -u nobody mitmproxy --mode transparent --showhost"
}

function disable_mitmproxy_transparent (){
    sudo sysctl -w net.inet.ip.forwarding=0
    sudo sysctl -w net.inet6.ip6.forwarding=0
    sudo pfctl -ef /etc/pf.conf
    #sudo rm /etc/pf.conf.temp
    #sudo rm /etc/pf.conf.temp.bak
    #sudo mv /etc/sudoers.backup /etc/sudoers
}

function gitcheats(){
    echo 'git update-index --assume-unchanged [<file> ...]'
    echo 'git update-index --no-assume-unchanged [<file> ...]'
}



