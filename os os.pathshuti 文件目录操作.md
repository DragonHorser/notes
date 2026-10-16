# Python os /os.path/shutil 文件目录操作

> 
> Python 通过 `os` 模块调用操作系统接口完成目录、文件操作；路径相关工具大多在 `os.path`；文件复制等补充功能使用 `shutil`。

## 操作系统信息

```
import os

# 判断操作系统
print(os.name)
# posix → Linux / macOS
# nt → Windows

# 获取系统详细信息，Windows不支持
os.uname()
```

## 环境变量

所有环境变量存放在 `os.environ`

```
import os

# 获取全部环境变量
print(os.environ)

# 获取指定环境变量
path = os.environ.get("PATH")

# 获取key，不存在返回默认值default
val = os.environ.get("x", "default")
```

## 目录操作 os /os.path

> 
> ⚠️ 路径拼接**不要手动拼字符串**，使用 `os.path.join()`，自动适配 Windows `\` 和 Linux `/`。

```
import os

# 获取当前目录绝对路径
os.path.abspath('.')

# 拼接路径
full_path = os.path.join("/Users/michael", "testdir")

# 创建目录
os.mkdir(full_path)

# 删除目录
os.rmdir(full_path)

# 拆分路径，(父目录,最后一段)
os.path.split("/Users/michael/testdir/file.txt")
# ('/Users/michael/testdir', 'file.txt')

# 拆分文件名与扩展名
os.path.splitext("/path/to/file.txt")
# ('/path/to/file', '.txt')
```

> 
> `os.path.join` / `split` / `splitext` **只处理字符串，文件 / 目录不需要真实存在**。

## 文件操作

```
import os

# 文件重命名
os.rename("test.txt", "test.py")

# 删除文件
os.remove("test.py")
```

> 
> ✨ os 模块**没有复制文件函数**，复制使用 `shutil`（os 模块补充）

```
import shutil

shutil.copyfile("src.txt", "dst.txt")
```

## 目录列表过滤

```
import os

# 列出当前目录下【所有文件夹】
dirs = [x for x in os.listdir('.') if os.path.isdir(x)]

# 列出当前目录下所有 .py 文件
py_files = [x for x in os.listdir('.') if os.path.isfile(x) and os.path.splitext(x)[1] == '.py']
```

## 练习：递归遍历所有子目录，查找文件名包含指定字符串的文件，打印相对路径

题目：编写一个程序，能在当前目录以及当前目录的所有子目录下查找文件名包含指定字符串的文件，并打印出相对路径。

```
import os

def find_file(keyword, root_path="."):
    """
    keyword: 需要搜索的文件名关键字
    root_path: 起始搜索目录，默认当前目录
    """
    for dirpath, dirnames, filenames in os.walk(root_path):
        for filename in filenames:
            if keyword in filename:
                # 拼接得到文件完整路径，转为相对路径输出
                full = os.path.join(dirpath, filename)
                rel = os.path.relpath(full)
                print(rel)

if __name__ == '__main__':
    # 查找名字含有 "test" 的文件
    find_file("test")
```

- `os.walk()`：递归遍历目录；返回 `(当前目录路径, 子目录列表, 文件列表)`
- `os.path.relpath()`：把绝对路径转为相对路径

## 重点速记

表格

| 功能 | 函数 | 备注 |
| --- | --- | --- |
| 操作系统类型 | `os.name` | `posix`/`nt` |
| 获取环境变量 | `os.environ.get(key)` | 推荐用 get 防止 key 不存在报错 |
| 拼接路径 | `os.path.join(a,b)` | 跨平台，禁止手动字符串拼接 |
| 拆分路径 | `os.path.split()` | (父目录，文件名) |
| 分离扩展名 | `os.path.splitext()` | (无后缀路径，后缀) |
| 创建目录 | `os.mkdir()` | 只创建单级目录 |
| 删除目录 | `os.rmdir()` | 只能删空目录 |
| 重命名文件 | `os.rename()` |  |
| 删除文件 | `os.remove()` | 只能删文件，不能删目录 |
| 复制文件 | `shutil.copyfile()` | os 没有复制文件接口 |
| 递归遍历目录 | `os.walk()` | 遍历全部子目录 |

## 小结

1. 文件目录操作：一部分在 `os`，路径处理在 `os.path`；复制文件使用 `shutil`。
2. 路径操作一律使用 `os.path` 系列函数，不要手写 `/` 或 `\`，保证跨平台兼容。
3. `os.walk()` 用于递归扫描多层子目录。