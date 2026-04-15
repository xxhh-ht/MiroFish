#!/bin/bash

# ========================================
# MiroFish 一键启动脚本
# ========================================

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "========================================"
echo "  MiroFish 启动中..."
echo "========================================"

# 检测 Node.js
echo -n "检测 Node.js... "
if ! command -v node &> /dev/null; then
    echo "❌ 未安装 Node.js"
    echo "请运行: brew install node"
    exit 1
fi
NODE_VERSION=$(node -v)
echo "✅ $NODE_VERSION"

# 检测 Python
echo -n "检测 Python... "
if command -v python3.11 &> /dev/null; then
    PYTHON_CMD="python3.11"
elif command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
else
    echo "❌ 未安装 Python"
    echo "请运行: brew install python@3.11"
    exit 1
fi
PYTHON_VERSION=$($PYTHON_CMD --version 2>&1)
echo "✅ $PYTHON_VERSION"

# 检测 uv
echo -n "检测 uv... "
if ! command -v uv &> /dev/null; then
    echo "❌ 未安装 uv"
    echo "请运行: brew install uv"
    exit 1
fi
UV_VERSION=$(uv --version | head -1)
echo "✅ $UV_VERSION"

# 检测 .env 文件
if [ ! -f ".env" ]; then
    echo "⚠️  未找到 .env 文件，正在创建..."
    cp .env.example .env
    echo "✅ 已创建 .env 文件"
    echo "⚠️  请编辑 .env 文件填入 API 密钥"
    open -t .env
fi

# 检查依赖
echo ""
echo "检查依赖..."
if [ ! -d "backend/.venv" ]; then
    echo "正在安装后端依赖..."
    cd backend && uv sync --python 3.11
    cd ..
fi

if [ ! -d "node_modules" ]; then
    echo "正在安装前端依赖..."
    npm install
fi

if [ ! -d "frontend/node_modules" ]; then
    echo "正在安装前端依赖..."
    cd frontend && npm install && cd ..
fi

# 启动服务
echo ""
echo "========================================"
echo "  启动服务..."
echo "========================================"
echo "按 Ctrl+C 停止服务"
echo ""

# 启动并在新标签打开浏览器
osascript -e "tell app \"Terminal\" to do script \"cd '$SCRIPT_DIR' && npm run dev\"" 2>/dev/null || {
    # 如果 osascript 失败，使用默认方式启动
    npm run dev &
}

# 等待服务启动
sleep 5

# 打开浏览器
echo ""
echo "正在打开浏览器..."
open http://localhost:3000

echo ""
echo "========================================"
echo "  ✅ MiroFish 已启动！"
echo "  前端: http://localhost:3000"
echo "  后端: http://localhost:5001"
echo "========================================"
