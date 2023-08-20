SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
name=$1
symbol=$2
# then contract=artifacts/counter.wasm
if [ -z "${contract}" ];
then contract="$SCRIPT_DIR/artifacts/cw721_metadata_onchain.wasm"
fi
keyname=admin
password="12345678\n"

seid=~/go/bin/seid
code=$(printf $password | $seid tx wasm store $contract -y --from=$keyname --chain-id=sei-chain --gas=10000000 --fees=10000000usei --broadcast-mode=block | grep -A 1 "code_id" | sed -n 's/.*value: "//p' | sed -n 's/"//p')

admin_addr=$(printf $password |$seid keys show $keyname | grep -A 1 "address" | sed -n 's/.*address: //p')

msg="{\"name\":\"$name\",\"symbol\":\"$symbol\",\"minter\":\"$admin_addr\"}"

addr=$(printf $password |$seid tx wasm instantiate $code "$msg" --from $keyname --broadcast-mode=block --label "cw721_metadata_onchain.wasm" --chain-id sei-chain --gas=300000 --fees=300000usei --admin=$admin_addr -y | grep -A 1 -m 1 "key: _contract_address" | sed -n 's/.*value: //p' | xargs)

echo $addr

# echo $password | $seid tx wasm execute \
    # $addr '{"mint":{"token_id":"69","owner":"sei1kfx0lxpplumzzr3qd0v7er83ru3unl9xhend5e","token_uri":"auri"}}' --from $keyname \
  # --broadcast-mode=block --chain-id sei-chain --gas=3000000 --fees=300000usei -y
