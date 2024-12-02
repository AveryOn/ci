base_dir=$(basename "$PWD")
base_cmd="git"
full_date="$(date +%d)-$(date +%m)-$(date +%Y)--$(date +%H):$(date +%M):$(date +%S)"
commit_name="commit-$full_date"
current_branch=$(git branch --show-current)




function start {
    commands=(
        "status"
        "add ."
        "commit -m '$commit_name'"
        "push $1 $2"
    )
    for i in "${commands[@]}"; do
        echo "[command] \"$base_cmd $i\"..."
    done
}

for origin in $(git remote); do
    echo "=================  {$origin}  ================="
    start $origin $current_branch
done

# for i in "${commands[@]}"; do
#     echo "$i"
# done

# 
# for i in "${current_branch[@]}"; do

#     if [[ "$i" == *"*"* ]]; then
#         echo "$i"
#     fi
# done