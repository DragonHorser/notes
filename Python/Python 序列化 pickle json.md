# Python 序列化 pickle /json 笔记

> 序列化：内存对象 → 可存储 / 可传输的字节 / 字符串；反序列化：字节 / 字符串 → 内存对象。
> 
> - `pickle`：Python 专属序列化，仅 Python 之间使用；
> - `json`：跨语言通用标准格式，web 开发常用。

## 一、pickle 模块（Python 专属）

### 核心概念

- **序列化 (pickling)**：内存对象转为`bytes`字节，可写入磁盘、网络传输
- **反序列化 (unpickling)**：bytes 字节还原回 Python 内存对象

> ⚠️ 缺点：只兼容 Python，不同 Python 版本可能不兼容；只适合保存不重要的数据。

### 1. dumps /loads（内存操作，bytes）

- `pickle.dumps(obj)`：对象 → bytes
- `pickle.loads(bytes_data)`：bytes → 对象

```
import pickle

d = dict(name='Bob', age=20, score=88)
# 序列化为bytes
data_bytes = pickle.dumps(d)
print(data_bytes)

# 反序列化
d2 = pickle.loads(data_bytes)
print(d2)
```

### 2. dump /load（直接读写文件对象，file‑like）

> 文件打开模式必须是二进制 `wb` / `rb`

```
import pickle

d = dict(name='Bob', age=20, score=88)

# 序列化写入文件
with open("dump.txt", "wb") as f:
    pickle.dump(d, f)

# 从文件反序列化读出对象
with open("dump.txt", "rb") as f:
    d3 = pickle.load(f)

print(d3)
```

> 注意：反序列化得到的是**新对象**，和原来对象不是同一个，只是内容相同。

## 二、json 模块（跨语言通用）

JSON 和 Python 类型映射表

表格

| JSON 类型        | Python 类型      |
| -------------- | -------------- |
| `{}`           | dict           |
| `[]`           | list           |
| `"string"`     | str            |
| `1234.56`      | int / float    |
| `true / false` | `True / False` |
| `null`         | `None`         |

### 基础 4 个 API

表格

| 函数                   | 作用                       |
| -------------------- | ------------------------ |
| `json.dumps(obj)`    | python 对象 → json 字符串 str |
| `json.dump(obj, fp)` | python 对象 → 直接写入文件对象     |
| `json.loads(s)`      | json 字符串 → python 对象     |
| `json.load(fp)`      | 从文件对象读取 json → python 对象 |

```
import json

d = dict(name='Bob', age=20, score=88)

# 对象转json字符串
json_str = json.dumps(d)
print(json_str)

# json字符串转回对象
obj = json.loads(json_str)
print(obj)
```

### JSON 进阶：序列化 class 实例对象

默认`json.dumps()`**不能直接序列化自定义类实例**，报`TypeError: is not JSON serializable`。

#### 方式 1：自定义转换函数，使用 `default` 参数

```
import json

class Student(object):
    def __init__(self, name, age, score):
        self.name = name
        self.age = age
        self.score = score

def student2dict(std):
    return {
        "name": std.name,
        "age": std.age,
        "score": std.score
    }

s = Student('Bob', 20, 88)
# default 指定实例转dict的函数
print(json.dumps(s, default=student2dict))
```

#### 偷懒通用写法：利用实例的 `__dict__`

> 注意：使用`__slots__`的类没有`__dict__`，此方法失效。

```
print(json.dumps(s, default=lambda obj: obj.__dict__))
```

#### 反序列化：json dict → 类实例，使用 `object_hook`

```
import json

class Student(object):
    def __init__(self, name, age, score):
        self.name = name
        self.age = age
        self.score = score

def dict2student(d):
    return Student(d["name"], d["age"], d["score"])

json_str = '{"age": 20, "score": 88, "name": "Bob"}'
stu_obj = json.loads(json_str, object_hook=dict2student)
print(stu_obj)
print(type(stu_obj))
```

### ✍️ 练习：`ensure_ascii` 参数对中文序列化的影响

> `ensure_ascii=True`(默认)：中文会转`\uXXXX`unicode 转义字符；
> `ensure_ascii=False`：直接输出原始中文。

```
import json

obj = dict(name='小明', age=20)

# 默认 True，中文转义
s1 = json.dumps(obj, ensure_ascii=True)
print("ensure_ascii=True：", s1)

# False，输出原始中文
s2 = json.dumps(obj, ensure_ascii=False)
print("ensure_ascii=False：", s2)
```

## 小结

1. `pickle`：Python 专属序列化，只适合 Python 内部使用，版本兼容性差；
   - `dumps/loads` 操作内存 bytes；`dump/load` 操作文件，必须 wb/rb 二进制模式。
2. `json`：跨语言通用，web 接口最常用，编码默认 UTF‑8。
3. 自定义类实例序列化：`dumps(..., default=转换函数)`；
4. json 字典转回类实例：`loads(..., object_hook=转换函数)`；
5. 中文 json 输出：`ensure_ascii=False` 保留原始中文。