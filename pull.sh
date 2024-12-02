base_dir=$(basename "$PWD")
base_cmd="git"
full_date="$(date +%d)-$(date +%m)-$(date +%Y)--$(date +%H):$(date +%M):$(date +%S)"
commit_name="commit-$full_date"
current_branch=
commands=(
    "status"
    "add ."
    "commit -m '$commit_name'"
    "push"
)

# for i in "${commands[@]}"; do
#     echo "$i"
# done

# Find current branch
for word in "$(git branch | grep -i '*')"; do
    if [[ "$word" == *"*"* ]]; then
        # current_branch="$word";
        echo "$word"
    fi
done

# 
# for i in "${current_branch[@]}"; do

#     if [[ "$i" == *"*"* ]]; then
#         echo "$i"
#     fi
# done