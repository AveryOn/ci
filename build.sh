base_dir=$(basename "$PWD");
base_cmd="npm"

commands=(
    "install" 
    "run build"
)
for i in "${commands[@]}"; do
    command="$base_cmd $i"
    echo "[start] $command"
    eval "$command"
done
