# 数据库

> 个人学习笔记 · 数据库模型 / SQL 分类 / DDL / DML / DQL

## 目录

- [概述](#概述)
- [数据库模型](#数据库模型)
- [SQL 语句](#sql-语句)
- [DDL - 管理 database](#ddl---管理-database)
- [DDL - 管理 table](#ddl---管理-table)
- [DML - 增删改](#dml---增删改)
- [DQL - 查询数据](#dql---查询数据)

---

## 概述

数据库：用于持久化存储数据的仓库。

**常见数据库：** MySQL、Oracle、SQLServer、DB2、SQLite

**我们使用的：** MySQL 8.x.x 社区版

---

## 数据库模型

| 概念 | 说明 |
| --- | --- |
| 数据库服务器 | 安装了数据库软件的计算机 |
| DBMS | 数据库管理系统，指数据库软件，比如 MySQL |
| database | 数据库，通常是一个项目要有一个对应的数据库 |
| table | 表，一张表存储一种数据，比如：用户表、商品表、订单表 |
| column | 字段，一列是一个字段 |
| row | 一行是一条数据记录 |

---

## SQL 语句

结构化查询语言，用于操作数据库的语言规范。

**特点：**

- 不区分大小写
- 每一句要以分号结尾
- 字符串以单引号括起来

**分类：**

| 分类 | 说明 |
| --- | --- |
| DDL | 数据定义语言，用于管理 database 和 table 的 |
| DML | 数据操作语言，用于对数据行进行增删改的 |
| DQL | 数据查询语言，用于对数据行进行查询的 |
| DCL | 数据控制语言，给 DBA 用来管理数据库的账号和权限的 |

---

## DDL - 管理 database

**创建库：**

```sql
create database if not exists 库名称 character set 字符集;
```

> **提示**：MySQL 里的字符集名称 `utf8mb4`，相当于我们日常所说的 utf-8。

**列出所有库：**

```sql
show databases;
```

**进入某个库：**

```sql
use 库名称;
```

**查看当前库：**

```sql
select database();
```

**删除库：**

```sql
drop database 库名称;
```

---

## DDL - 管理 table

### 数据类型

**数值类型：**

| 类型 | 说明 |
| --- | --- |
| `int`、`bigint` | 整数 |
| `double(总长度, 小数位)` | 小数 |

**字符串类型：**

| 类型 | 说明 |
| --- | --- |
| `char(n)` | 定长字符串 |
| `varchar(n)` | 变长字符串 |

**日期类型：**

| 类型 | 格式 |
| --- | --- |
| `date` | 仅日期，格式 `2020-01-01` |
| `datetime` | 日期时间，格式 `2020-01-01 10:10:10` |

### 字段约束

| 约束 | 关键字 | 说明 |
| --- | --- | --- |
| 唯一约束 | `unique` | 字段值不能重复 |
| 非空约束 | `not null` | 字段值不能为空 |
| 默认约束 | `default 默认值` | 如果字段没有设置值，将会采用默认值 |
| 主键约束 | `primary key auto_increment` | 主键值非空且唯一 |

> **注意**
> - 建表时，原则上每张表都要有主键字段
> - 一张表最多允许有一个主键约束

### 创建表

```sql
create table 表名称(
    字段名 类型 约束 comment '字段说明',
    ...,
    字段名 类型 约束 comment '字段说明'
);
```

### 常用操作

**列出所有表：**

```sql
show tables;
```

**查看某张表的结构：**

```sql
desc 表名称;
```

**查看某张表的建表语句：**

```sql
show create table 表名称;
```

**修改表 - 重命名表：**

```sql
rename table 表名称 to 新名称;
```

**修改表 - 添加字段：**

```sql
alter table 表名称 add 字段名 类型 约束 comment '字段说明';
```

**修改表 - 修改字段：**

```sql
alter table 表名称 change 字段名 新字段名 新类型 新约束 comment '字段说明';
```

**修改表 - 删除字段：**

```sql
alter table 表名称 drop 字段名;
```

**删除表：**

```sql
drop table 表名称;
```

---

## DML - 增删改

### 新增数据

**给所有字段设置值：**

```sql
insert into 表名称 values (值1, 值2, ...), (), ...;
```

**给指定字段设置值：**

```sql
insert into 表名称(字段1, 字段2, ...) values (值1, 值2, ...), (), ...;
```

### 修改数据

```sql
update 表名称 set 字段=值, 字段=值, ... where 条件;
```

### 删除数据

```sql
delete from 表名 where 条件;
```

---

## DQL - 查询数据

### 综合语法

```sql
select ... from ... where ... group by ... having ... order by ... limit ...
```

### 简单查询

**查询指定列：**

```sql
select 字段, 字段, ... from 表名;
```

**查询所有列：**

```sql
select * from 表名;
```

**查询时计算：**

```sql
select 字段+值, 字段-值, ... from 表名;
```

**查询时起别名：**

```sql
select 字段 as 别名, 字段+值 as 别名 from 表名;
```

> 其中 `as` 可以省略不写。

**查询时去重：**

```sql
select distinct 字段, 字段 from 表名;
```

### 条件查询

`where` 条件，用于筛选数据行（定位到数据行）。

```sql
where 字段=值
where 字段>值
where 字段<值
where 字段>=值
where 字段<=值
where 字段<>值
where 字段!=值
where 字段 is null
where 字段 is not null
where 字段 between 开始值 and 结束值
where 字段 in (值1, 值2, ...)
where 字段 not in (值1, 值2, ...)
where 字段 like '表达式'
where 字段 not like '表达式'
where 条件1 and 条件2
where 条件1 or 条件2
```

> `like` 表达式里：`_` 表示 1 个任意字符，`%` 表示任意个任意字符。

### 聚合函数

用于统计数据的，所有聚合函数都会忽略 `null` 值。

| 函数 | 说明 |
| --- | --- |
| `count(主键字段)` 或 `count(*)` | 统计数量 |
| `sum(字段)` | 求和 |
| `max(字段)` | 求最大值 |
| `min(字段)` | 求最小值 |
| `avg(字段)` | 求平均值 |

### 分组统计

```sql
select 分组字段, 聚合函数 from 表名 where 条件 group by 分组字段 having 分组后的过滤条件;
```

**执行顺序：**

1. `where` 过滤原始表
2. 根据分组字段进行分组
3. 对分组后的结果做统计与过滤

**where 和 having 的区别：**

| 对比项 | where | having |
| --- | --- | --- |
| 过滤的对象不同 | 对原始表过滤 | 对分组后的结果过滤 |
| 过滤的时机不同 | 在分组前执行 | 在分组后执行 |
| 过滤的写法不同 | 条件不允许有聚合函数 | 条件可以写聚合函数 |

### 排序

```sql
order by 排序字段 规则, 排序字段 规则, ...
```

- **规则**：升序 `asc`（默认），降序 `desc`
- **效果**：先根据第一个字段排序；如果第一个字段值相同，再按照第二个字段排序

### 分页

作用是只挑选符合条件的一部分数据行。

**语法：**
起始索引:(页数-1) * 每页的数据数量(多少行)
```sql
limit 起始索引, 查询几行;
```

**简写：**

```sql
limit 查询几行;
```

> 等价于 `limit 0, 查询几行`。