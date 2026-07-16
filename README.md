# Android DingTalk Auto Attendance System

基于 **Magisk Root 模块 + Shell 自动化脚本** 实现的 Android 钉钉自动考勤系统。

通过后台常驻运行 `service.sh`，在指定时间自动唤醒设备、解锁屏幕、打开钉钉，并模拟点击完成考勤打卡，实现无人值守自动化操作。

---

## ✨ 项目介绍

本项目利用 Android Root 权限，通过 Magisk 模块加载 Shell 脚本，实现移动设备上的定时自动化任务。

系统启动后：

1. Magisk 自动加载模块
2. `service.sh` 后台运行
3. 定时检测当前时间
4. 到达指定时间后执行自动打卡流程

完整流程：

```
开机
 ↓
Magisk 加载模块
 ↓
service.sh 后台运行
 ↓
检测时间
 ↓
唤醒屏幕
 ↓
滑动解锁
 ↓
输入密码
 ↓
启动钉钉
 ↓
进入工作台
 ↓
进入考勤页面
 ↓
点击打卡按钮
 ↓
完成自动打卡
```

---

# 📁 项目结构

```
autobrightness_unlocker/

├── module.prop
└── service.sh
```

---

# 🔧 环境要求

## 硬件

- Android 手机 / 平板
- 已解锁 Bootloader
- 已获取 Root 权限

## 软件

- Magisk
- Android Shell 环境

---

# 📦 安装方式

## 1. 创建 Magisk 模块目录

路径：

```
/data/adb/modules/autobrightness_unlocker/
```

结构：

```
autobrightness_unlocker/

├── module.prop
└── service.sh
```

---

## 2. 设置执行权限

进入 Root Shell：

```bash
su
```

执行：

```bash
chmod 755 /data/adb/modules/autobrightness_unlocker/service.sh
```

---

## 3. 重启设备

重启后 Magisk 会自动执行：

```
service.sh
```

---

# ⚙️ 功能说明

## 定时任务

当前配置：

| 时间 | 功能 |
|-|-|
| 09:29 | 自动执行打卡 |
| 17:18 | 自动执行打卡 |

修改时间：

编辑：

```
service.sh
```

修改：

```sh
if [ "$HOUR" = "09" ] && [ "$MIN" = "29" ]
```

即可。

---

# 🖥️ 自动化流程

## 1. 唤醒屏幕

```bash
input keyevent 224
```

---

## 2. 滑动解锁

```bash
input swipe 500 1800 500 300
```

---

## 3. 输入密码

```bash
input text 9999
input keyevent 66
```

---

## 4. 打开钉钉

```bash
am start -n com.alibaba.android.rimet/.biz.LaunchHomeActivity
```

---

## 5. 自动点击

当前设备坐标：

### 工作台

```
X:615
Y:3050
```

---

### 考勤打卡

```
X:200
Y:1800
```

---

### 打卡按钮

```
X:720
Y:1900
```

---

# 📝 日志

运行日志：

```
/sdcard/dingding.log
```

查看：

```bash
cat /sdcard/dingding.log
```

示例：

```
2026-07-16 09:29 开始执行
2026-07-16 09:30 执行完成
```

---

# 🛠️ 调试方法

## 手动运行脚本

进入：

```bash
su
```

执行：

```bash
sh /data/adb/modules/autobrightness_unlocker/service.sh
```

---

## 测试输入控制

亮屏：

```bash
input keyevent 224
```

滑动：

```bash
input swipe 500 1800 500 300
```

点击：

```bash
input tap 720 1900
```

---

# ⚠️ 注意事项

## 1. 分辨率依赖

本项目采用固定坐标点击方式：

```
input tap X Y
```

如果更换设备：

- 屏幕尺寸
- 分辨率
- DPI

需要重新校准坐标。


---

## 2. 密码修改

当前：

```
9999
```

对应：

```sh
input text 9999
```

请修改为自己的锁屏密码。

---

## 3. 网络因素

钉钉页面加载速度受到：

- 网络
- 手机性能
- 钉钉版本

影响。

必要时增加：

```sh
sleep
```

等待时间。

---

# 🚀 后续优化方向

## OCR 自动识别

替代固定坐标：

```
识别文字
 ↓
定位按钮
 ↓
自动点击
```

---

## UIAutomator

通过 Android UI 节点：

```
text="打卡"
```

自动定位。

---

## 打卡结果检测

增加：

- 截图
- OCR识别
- 自动重试

提高成功率。

---

# 📄 License

仅用于 Android 自动化研究与个人设备自动化管理。

请遵守所在组织的考勤制度和相关规定。
