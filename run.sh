# есть задача. Написать некоторый скрипт на Bash. Не буду вдавать в подробности. 
# Но можешь по моим поступающим последовательно вопросам помогать по синтаксису Bash потому что я ваще 
# не шарю за синтаксис в Bash? Только есть условие. Отвечай коротко очень. Я теорию потом изучу по Bash

base_dir=$(basename "$PWD")
base_cmd="npm"

echo "Application \"$base_dir\" run..."

commands=("run dev")

for i in "${commands[@]}"; do
    command="$base_cmd $i"
    echo "[start] $command"
    eval "$command"
done