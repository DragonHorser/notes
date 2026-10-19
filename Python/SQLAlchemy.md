# AI智伴-SQLAlchemy

> 个人学习笔记 · SQLAlchemy 入门 / 用法 / 项目优化

## 目录

- [介绍](#介绍)
- [入门](#入门)
- [用法](#用法)
  - [插入数据](#插入数据)
  - [修改数据](#修改数据)
  - [删除数据](#删除数据)
  - [查询数据](#查询数据)
- [项目优化](#项目优化)

---

## 介绍

Python 里用于操作数据库的框架，以面向对象的形式进行操作。

**使用的前提：**

- 有一张表，就必须要准备一个对应的类
- 表里有哪些字段，类里要有哪些对应的属性
- 表里有一行数据记录，最终要封装成一个实例对象

### 连接池

**如果没有连接池，存在的问题：**

- Python 程序要和 MySQL 建立连接，资源开销非常大
- 每次要操作数据库：要消耗很多资源，建立连接，使用完毕之后再销毁连接
- 如果操作数据库很频繁：导致性能下降非常明显

**使用连接池解决性能问题：**

1. 准备连接池：池子里提前准备好一批连接
2. 当需要操作数据库时：直接从连接池里取一个使用，用完以后归还到连接池里

**连接池的好处：**

- 池子里的连接可以复用，少量连接就可以支撑海量的数据库操作
- 每次操作数据库，避免了创建新连接的开销，直接从池子里取一个使用，耗时减少很多

**SQLAlchemy 已内置了连接池：**

- `pool_size`：常驻连接池的连接数量
- `max_overflaw`：如果操作数据库太频繁，允许创建最多多少个临时连接；空闲时会释放掉这些连接

---

## 入门

**1. 先为表准备对应的类（实体类：对应数据库表的类）**

使用 Python 工具生成实体类：

```bash
sqlacodegen mysql+pymysql://数据库账号:密码@IP:端口/库名称 --tables 表名,表名,...
```

**2. 再创建引擎对象（直接复制粘贴使用即可）**

```python
engine = create_engine("mysql+pymysql://root:root@localhost:3306/db1", echo=True)
```

**3. 使用 SQLAlchemy 操作数据库**

1. 创建 Session 对象
   - 因为这个对象提供了执行 SQL 语句、开启事务、提交事务等等功能方法

```python
session = Session(engine)
```

2. 执行 SQL

```python
session.add( 实体类的实例对象 )
```

3. 提交事务并关闭 session

```python
session.commit()
session.close()
```

---

## 用法

### 插入数据

#### 插入一条

**原始方式：**

```python
session.execute( insert(模型类).values(属性名=值, 属性名=值, ...) )
session.commit()
```

**简写形式：**

```python
session.add( 实例对象 )
session.commit()
```

#### 批量插入

**原始方式【更高效】：无论插入几条数据，只执行一次 SQL**

```python
session.execute( insert(模型类), [
    { "属性名": 值, "属性名": 值, ... },
    ......,
    { "属性名": 值, "属性名": 值, ... }
] )
session.commit()
```

**简写形式【不推荐】：插入几条数据，就要执行几次 SQL**

```python
session.add_all( [实例对象, 实例对象, ...] )
session.commit()
```

### 修改数据

```python
session.execute( update(模型类).where(模型类.属性名==值, 模型类.属性名>值, ...).values(属性名=值, 属性名=值, ...) )
session.commit()
```

### 删除数据

```python
session.execute( delete(模型类).where(模型类.属性名==值, 模型类.属性名>值, ...) )
session.commit()
```

### 查询数据

#### 简单查询

**查询所有列：**

```python
result = session.execute( select(模型类) )
data_list = result.scalars().all()
```

- 将结果集降维并转换成列表
- 得到的是列表 `list`，里边每个元素是实例对象。比如：`[AiMessage对象, AiMessage对象, ...]`

**查询指定列：**

```python
result = session.execute( select(模型类.属性名, 模型类.属性名, ...) )
row_list = result.all()
```

- 不需要降维，只需要转换成列表
- 得到的是列表 `list`，里边每个元素是 `Row` 对象
  - 比如：`[ 第一行Row对象, 第二行Row对象, ... ]`
- 取值：
  - `Row对象[0]`：取这一行的第 0 列的值
  - `Row对象.字段名`：取这一行的指定字段值

#### 条件查询

**构造 SQL 语句：**

多条件用 `and` 连接：

```python
select(...).where( 模型类.属性名==值, 模型类.属性名 > 值, ... )
select(...).where( and_(模型类.属性名==值, 模型类.属性名<值, ...) )
```

多条件用 `or` 连接：

```python
select(...).where( or_(模型类.属性名==值, 模型类.属性名>=值, ...) )
```

**执行查询语句：**

```python
result = session.execute( 上一步构造的SQL语句对象 )
```

#### 排序 + 分页

**构造 SQL 语句：**

```python
select(...).where(...)
    .order_by( 模型类.属性名.asc(), 模型类.属性名.desc(), ... )
    .offset(起始索引).limit(查询几行)
```

**执行查询语句：**

```python
result = session.execute( 上一步构造的SQL语句对象 )
```

---

## 项目优化

### 优化所使用的知识点

#### Depends 依赖注入

- API 接口的形参，不需要我们自己赋值，而是由 FastAPI 提供值
- 我们只需要声明 `形参名 = Depends(函数名)`
- 效果：FastAPI 调用这个 API 接口时，会提前调用指定的函数，将函数返回值交给这个形参

#### yield 关键字，和 return 对比

**return 的用法：**

- 定义

```python
def abc():
    print(.....)
    return 结果值
    # 后边的代码是不可能执行的
```

- 效果：`return` 关键字一旦执行，函数就立即结束
- 调用：`abc()` 得到结果值

**yield 的用法：**

- 定义

```python
def abc():
    print("1111")
    yield 1
    print("222")
    yield 2
```

- 效果：`yield` 关键字执行，会返回结果值，但函数并不会结束；当使用生成器的 `next()` 时会执行下一段代码
- 调用：
  - 先调用函数得到生成器对象：`gen = abc()`
  - 按顺序执行生成器的代码：`next(gen)`
    - 第一次调用 `next(gen)`：执行函数开始到 `yield`
    - 第二次调用 `next(gen)`：从目前的位置继续执行到下一个 `yield`

### 优化之后的用法

任何 API 接口的写法是：

```python
async def 函数名( session: AsyncSession = Depends(get_db_session) ):
    利用session对象操作数据库
    # 操作之后不需要关注提交、回滚、关闭
```