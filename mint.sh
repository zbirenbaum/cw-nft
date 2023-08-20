contract=$1
receiver=$2
id=$3
uri=$4
echo $contract
echo $receiver
echo $id
echo $uri

if [ -z "${keyname}" ];
then keyname=admin
fi
if [ -z "${password}" ];
then password="12345678\n"
fi

seid=~/go/bin/seid
msg="{\"mint\":{\"token_id\":\"$id\",\"owner\":\"$receiver\",\"token_uri\":\"$uri\"}}"
result=$(printf $password \
  | $seid tx wasm execute \
    $contract $msg \
  --from $keyname \
  --broadcast-mode=block  \
  --chain-id sei-chain \
  --gas=3000000 \
  --fees=300000usei -y)
echo $result

# new_count=$($seid q wasm contract-state smart $contract '{"get_count":{}}' | grep -A 1 "count:" | awk -F: '/count:/{getline; print $2}')

    # let mint_msg = ExecuteMsg::Mint {
    #     token_id: token_id1.clone(),
    #     owner: demeter.clone(),
    #     token_uri: None,
    #     extension: None,
    # };

