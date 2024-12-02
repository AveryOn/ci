base_dir=$(basename "$PWD")
base_cmd="git"
full_date="$(date +%d)-$(date +%m)-$(date +%Y)--$(date +%H):$(date +%M):$(date +%S)"
commit_name="commit-$full_date"
current_branch=$(git branch --show-current)


# Запуск последовательности команд
function start {
    commands=(
        "status"
        "add ."
        "commit -m '$commit_name'"
        "push $1 $2"
    )
    for i in "${commands[@]}"; do
        command="$base_cmd $i"
        echo "[command] RUN => \"$command\""
        eval "$command"
    done
}

# Запуск команд для каждого origin
for origin in $(git remote); do
    echo "=================  {$origin}  =================\n"
    start $origin $current_branch
done