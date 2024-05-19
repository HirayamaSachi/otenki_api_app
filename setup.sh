# .envの作成
if [ ! -e .env ]; then
    cp .env.default .env
    echo "Create file: .env"
    echo "Prease edit file: .env"
fi
