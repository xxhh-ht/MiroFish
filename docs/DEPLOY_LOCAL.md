# MiroFish 本地化部署指南

## 📋 部署方式概览

MiroFish 支持两种本地部署方式：

| 方式 | 优点 | 缺点 |
|------|------|------|
| **Docker 部署** | 简单快捷，一键启动 | 需要 Docker 基础 |
| **源码部署** | 可深度定制开发 | 需要配置多个环境 |

---

## 🚀 方式一：Docker 部署（推荐）

### 前置要求
- Docker Desktop 已安装并运行
- 网络连接正常（可访问 Docker Hub）

### 部署步骤

```bash
# 1. 进入项目目录
cd /Volumes/MacSD/GitHub/MiroFish

# 2. 复制环境变量配置文件
cp .env.example .env

# 3. 编辑 .env 文件，填入 API 密钥
vim .env
```

**`.env` 必需配置：**
```env
# LLM API配置（必须）
LLM_API_KEY=你的API密钥
LLM_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
LLM_MODEL_NAME=qwen-plus

# Zep Cloud 配置（必须）
ZEP_API_KEY=你的ZEP_API密钥
```

```bash
# 4. 启动服务
docker compose up -d

# 5. 查看日志确认启动成功
docker compose logs -f
```

### 访问地址
- 前端界面：http://localhost:3000
- 后端 API：http://localhost:5001

### 停止服务
```bash
docker compose down
```

---

## 💻 方式二：源码部署

### 前置要求

| 工具 | 版本要求 | 安装命令 |
|------|---------|---------|
| Node.js | 18+ | `brew install node` |
| Python | 3.11 ~ 3.12 | `brew install python@3.11` |
| uv | 最新版 | `brew install uv` |

### 验证环境
```bash
node -v    # 应显示 v18.x.x 或更高
python --version  # 应显示 3.11.x 或 3.12.x
uv --version
```

### 部署步骤

```bash
# 1. 进入项目目录
cd /Volumes/MacSD/GitHub/MiroFish

# 2. 复制环境变量配置文件
cp .env.example .env

# 3. 编辑 .env 文件
vim .env
```

**`.env` 必需配置：**
```env
# LLM API配置（必须）
LLM_API_KEY=你的API密钥
LLM_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
LLM_MODEL_NAME=qwen-plus

# Zep Cloud 配置（必须）
ZEP_API_KEY=你的ZEP_API密钥
```

```bash
# 4. 一键安装所有依赖
npm run setup:all

# 5. 启动服务
npm run dev
```

### 访问地址
- 前端界面：http://localhost:3000
- 后端 API：http://localhost:5001

### 单独启动前后端
```bash
# 仅启动后端
npm run backend

# 仅启动前端
npm run frontend
```

---

## 🔑 API 密钥获取

### 1. LLM API（阿里百炼平台）
1. 访问 https://bailian.console.aliyun.com/
2. 注册/登录阿里云账号
3. 创建百炼应用，获取 API Key
4. 推荐使用 `qwen-plus` 模型

### 2. Zep Cloud（记忆图谱）
1. 访问 https://app.getzep.com/
2. 注册账号
3. 创建项目，获取 API Key
4. 每月有免费额度，足够日常使用

---

## 🐛 常见问题

### Q1: Docker 部署拉取镜像慢？
```bash
# 使用国内加速镜像
docker compose pull ghcr.nju.edu.cn/666ghj/mirofish:latest
```

### Q2: 依赖安装失败？
```bash
# 清理缓存重试
npm cache clean --force
cd backend && uv sync --refresh
```

### Q3: 端口被占用？
```bash
# 查看端口占用
lsof -i :3000
lsof -i :5001

# 修改 docker-compose.yml 中的端口映射
```

### Q4: 前端/后端启动报错？
```bash
# 检查 Node 版本
node -v  # 需要 >=18

# 检查 Python 版本
python --version  # 需要 3.11 或 3.12
```

---

## 📝 环境变量说明

| 变量名 | 必须 | 说明 |
|--------|------|------|
| `LLM_API_KEY` | ✅ | LLM 服务 API 密钥 |
| `LLM_BASE_URL` | ✅ | LLM API 地址 |
| `LLM_MODEL_NAME` | ✅ | LLM 模型名称 |
| `ZEP_API_KEY` | ✅ | Zep 记忆图谱 API 密钥 |
| `LLM_BOOST_*` | ❌ | 加速 LLM 配置（可选） |

---

## ✅ 部署检查清单

- [ ] Docker Desktop 已运行（或 Node/Python 环境已配置）
- [ ] `.env` 文件已创建
- [ ] `LLM_API_KEY` 已配置
- [ ] `ZEP_API_KEY` 已配置
- [ ] 服务已启动
- [ ] http://localhost:3000 可访问
