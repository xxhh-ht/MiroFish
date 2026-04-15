# MiroFish Docker 本地化部署指南

## 📋 前置要求

- Docker Desktop 已安装并运行
- 网络连接正常

## 🚀 部署步骤

### 1. 进入项目目录

```bash
cd /Volumes/MacSD/GitHub/MiroFish
```

### 2. 配置环境变量

```bash
# 复制示例配置文件
cp .env.example .env

# 编辑 .env 文件
vim .env
```

**必须填入以下配置：**

```env
# LLM API配置（阿里百炼平台）
LLM_API_KEY=你的API密钥
LLM_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
LLM_MODEL_NAME=qwen-plus

# Zep Cloud 配置
ZEP_API_KEY=你的ZEP_API密钥
```

### 3. 启动服务

```bash
# 启动所有服务
docker compose up -d

# 查看启动日志
docker compose logs -f
```

### 4. 验证部署

等待容器启动完成后，访问：

- **前端界面：** http://localhost:3000
- **后端 API：** http://localhost:5001

## 🔑 API 密钥获取

### LLM API（阿里百炼）

1. 访问 https://bailian.console.aliyun.com/
2. 注册/登录阿里云账号
3. 获取 API Key

### Zep Cloud

1. 访问 https://app.getzep.com/
2. 注册账号并获取 API Key
3. 每月有免费额度

## 🛠️ 常用命令

```bash
# 停止服务
docker compose down

# 重启服务
docker compose restart

# 重新构建并启动
docker compose up -d --build

# 查看容器状态
docker compose ps

# 查看日志
docker compose logs -f mirofish

# 进入容器
docker exec -it mirofish /bin/bash
```

## 🐛 常见问题

### 镜像拉取慢

```bash
# 使用国内加速镜像
# 编辑 docker-compose.yml，将镜像地址改为：
image: ghcr.nju.edu.cn/666ghj/mirofish:latest
```

### 端口被占用

```bash
# 检查端口占用
lsof -i :3000
lsof -i :5001

# 修改 docker-compose.yml 中的端口映射
```

### 查看容器状态

```bash
docker compose ps
docker compose logs
```

## 📁 数据持久化

上传文件存储在 `./backend/uploads`，已通过 volume 挂载：
```yaml
volumes:
  - ./backend/uploads:/app/backend/uploads
```
