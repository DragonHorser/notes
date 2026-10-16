# Python 文件 IO & 内存 IO（StringIO / BytesIO）

> 
> 程序不能直接操作磁盘，向操作系统请求获取**文件对象（文件描述符）**，通过该对象完成读写；用完必须关闭，释放系统资源。
> 
> 
> 内存 IO：读写不一定操作磁盘，直接内存完成读写，接口与文件对象一致，属于 file‑like Object。

## 一、磁盘文件读写 open ()

### 读文件 `open(路径, 'r')`

#### 基础写法

```
f = open("test.txt", "r")
data = f.read()
f.close()   # 必须手动关闭
```

- 文件不存在抛出：`FileNotFoundError`
- 风险：中间发生异常，`close()` 不会执行，造成系统资源泄露。

#### try‑finally 安全写法

```
try:
    f = open("test.txt","r")
    print(f.read())
finally:
    if f:
        f.close()
```

#### ✅ 推荐 with 语句（自动关闭文件）

等价于 `try‑finally`，**不需要手动调用 close ()**

```
with open("test.txt","r") as f:
    content = f.read()
```

#### 读取方法选型

表格

| 方法 | 作用 | 使用场景 |
| --- | --- | --- |
| `f.read()` | 一次性读取全部内容返回字符串 | 小文件 |
| `f.read(size)` | 最多读取 size 字节 | 大文件，循环读取 |
| `f.readline()` | 读取一行内容 | 逐行处理 |
| `f.readlines()` | 读取所有行，返回字符串列表 | 配置文件等 |

```
with open("test.txt","r") as f:
    for line in f.readlines():
        print(line.strip()) # strip() 去除末尾换行符 \n
```

### 二进制文件读写（图片、视频等）

- `rb`：读取二进制
- `wb`：写入二进制
返回 `bytes` 字节对象 `b'xxxx'`

```
with open("test.jpg","rb") as f:
    data = f.read()
```

### 指定字符编码

```
# 读取 gbk 编码文件
with open("gbk.txt","r", encoding="gbk") as f:
    text = f.read()

# 遇到非法编码字符直接忽略错误
with open("gbk.txt","r", encoding="gbk", errors="ignore") as f:
    text = f.read()
```

### 写文件

表格

| 模式 | 说明 |
| --- | --- |
| `w` | 文本写入，**文件存在直接覆盖**，不存在新建 |
| `wb` | 二进制写入 |
| `a` | 追加模式，在文件末尾追加，不会覆盖原有内容 |

> 
> ⚠️ 写入的数据先存在内存缓存，执行 close () /with 结束块才真正写入磁盘；忘记关闭会造成数据丢失。

```
# with 安全写入
with open("out.txt","w", encoding="utf-8") as f:
    f.write("hello world")

# 追加写入示例
with open("out.txt","a", encoding="utf-8") as f:
    f.write("\n追加一行内容")
```

### file‑like Object（类文件对象）

只要拥有 `read()` 方法的对象统称为类文件对象；
不局限磁盘文件，也可以是内存流 `StringIO`、网络流、自定义流。

### ✨磁盘 IO 重点速记清单

1. 优先使用 `with open(...) as f:`，自动关闭文件，避免资源泄漏与数据丢失
2. 模式速记：`r`读；`w`覆盖写；`a`追加写；`rb/wb`二进制读写
3. 文本读写建议显式指定 `encoding="utf‑8"`；乱码可以加参数 `errors="ignore"`
4. 大文件禁止直接 `read()` 一次性全部读入内存，使用 `read(size)` 或者逐行读取
5. `w` 模式会清空旧文件，追加内容务必使用 `a`

### 练习示例

```
fpath = '/etc/timezone'
with open(fpath, 'r') as f:
    s = f.read()
    print(s)
```

---

## 二、内存 IO：StringIO & BytesIO

> 
> 全部在内存操作，**不生成磁盘文件**，接口和普通文件对象保持一致。

### StringIO

> 
> 用于在内存读写 **字符串 (str)**，来自 `io` 模块。

#### 写入 StringIO

```
from io import StringIO

# 创建内存字符串对象
f = StringIO()
# write 返回写入的字符数
f.write('hello')
f.write(' ')
f.write('world!')

# getvalue() 获取全部写入的字符串
print(f.getvalue())
# output: hello world!
```

#### 读取 StringIO

可以直接用字符串初始化 StringIO，支持 `read()` / `readline()` / `readlines()`，用法同普通文件。

```
from io import StringIO

# 使用字符串初始化
f = StringIO('Hello!\nHi!\nGoodbye!')

while True:
    s = f.readline()
    if s == '':
        break
    print(s.strip())
```

输出：

```
Hello!
Hi!
Goodbye!
```

### BytesIO

> 
> `StringIO` 只能处理字符串；**二进制数据 (bytes)** 使用 `BytesIO`，同样在内存操作。

#### 写入 BytesIO

写入的必须是 `bytes` 类型，字符串需要先 encode 编码。

```
from io import BytesIO

f = BytesIO()
# str -> bytes
f.write('中文'.encode('utf-8'))
# getvalue() 获取完整bytes
print(f.getvalue())
# output: b'\xe4\xb8\xad\xe6\x96\x87'
```

#### 读取 BytesIO

用 bytes 对象初始化，直接 `read()` 读取二进制。

```
from io import BytesIO

f = BytesIO(b'\xe4\xb8\xad\xe6\x96\x87')
data = f.read()
print(data)
```

### StringIO vs BytesIO 速查表

表格

| 类 | 模块 | 处理类型 | 常用方法 |
| --- | --- | --- | --- |
| StringIO | io | `str` 字符串 | `write()`、`getvalue()`、`readline()` |
| BytesIO | io | `bytes` 二进制 | `write()`、`getvalue()`、`read()` |

### 内存 IO 要点

1. 不需要 `open()`、不需要 `close()`，完全在内存，不会生成磁盘文件。
2. 接口和普通文件对象几乎一致，`read` / `readline` / `write` 都可用。
3. `getvalue()`：**获取内存中全部内容**（StringIO、BytesIO 都有这个方法）。
4. StringIO 只能存字符串；二进制（图片、字节流）必须用 BytesIO，字符串要先 `.encode()`。
5. 适用场景：临时缓冲数据，避免频繁读写磁盘。

### 小结

`StringIO` / `BytesIO` 在内存分别操作字符串与字节，拥有和文件一致的读写接口，属于 file‑like Object。