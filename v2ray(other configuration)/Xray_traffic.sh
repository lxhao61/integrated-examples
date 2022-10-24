#!/bin/bash

_APISERVER=127.0.0.1:10085 //此端口必须与traffic_config.json中流量统计端口一致
_XRAY=/usr/local/bin/xray/xray //此路径为Xray的实际路径

apidata () {
    local ARGS=
    if [[ $1 == "reset" ]]; then
      ARGS="-reset=true"
    fi
    $_XRAY api statsquery --server=$_APISERVER "${ARGS}" \
    | awk '{
        if (match($1, /"name":/)) {
            f=1; gsub(/^"|link"|,$/, "", $2);
            split($2, p,  ">>>");
            printf "%s:%s->%s\t", p[1],p[2],p[4];
        }
        else if (match($1, /"value":/) && f){
          f = 0;
          gsub(/"/, "", $2);
          printf "%.0f\n", $2;
        }
        else if (match($0, /}/) && f) { f = 0; print 0; }
    }'
}

print_sum() {
    local DATA="$1"
    local PREFIX="$2"
    local SORTED=$(echo "$DATA" | grep "^${PREFIX}" | sort -r)
    local SUM=$(echo "$SORTED" | awk '
        /->up/{us+=$2}
        /->down/{ds+=$2}
        END{
            printf "SUM->up:\t%.0f\nSUM->down:\t%.0f\nSUM->TOTAL:\t%.0f\n", us, ds, us+ds;
        }')
    echo -e "${SORTED}\n${SUM}" \
    | numfmt --field=2 --suffix=B --to=iec \
    | column -t
}

DATA=$(apidata $1)
echo "-----------Inbound-----------" //入站代理的流量统计（可根据traffic_config.json配置是否配置此部分参数）
print_sum "$DATA" "inbound"
echo "-----------------------------"
echo "-----------Outbound----------" //出站代理的流量统计（可根据traffic_config.json配置是否配置此部分参数）
print_sum "$DATA" "outbound"
echo "-----------------------------"
echo
echo "-------------User------------" //当前等级的所有用户的流量统计
print_sum "$DATA" "user"
echo "-----------------------------"
