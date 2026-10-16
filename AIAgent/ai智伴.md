AI智伴
日志
作用
用于帮助开发人员解决 bug、定位问题的。

任何应用程序不正常，作为开发人员，我们的第一反应应该是：找日志，看日志。

日志模块：logging
可以很方便地打印不同级别的日志，并控制实际输出的日志级别。

用法：

python
import logging
配置日志：

python
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - [%(filename)s:%(lineno)d] - %(message)s"
)
level = 日志级别：

logging.DEBUG

logging.INFO

logging.WARNING

logging.ERROR

logging.FATAL

程序里输出日志：

python
logging.debug("debug级别的日志")
logging.info("info级别的日志")
# ...
异常统一处理
作用
可以将项目中的异常统一抓取、统一处理，给前端返回友好提示结果。

用法
python
@app.exception_handler(异常类)
def handle_exception(request: Request, e: 异常类):
    logging.error("打印错误日志信息")
    return JSONResponse(content={ ... })
数据库
作用
用于存储数据的仓库。

常见的数据库
MySQL，知名版本有：

5.x

8.x

社区版：免费的

商业版：收费的

Oracle

SQLServer

DB2

SQLite

数据库模型（MySQL）
概念	说明
database	数据库，通常一个项目要有一个数据库
table	表，一张表通常用于存储一种（相关）数据，比如商品表、订单表
row	行，一行是一条数据记录
column	列，一列是一个字段，规定这一列要存储什么数据
SQL	用于管理数据库的语句
SQL 语句
特点：

不区分大小写

每一句结尾要加分号

数据库的字符串使用单引号

分类：

DDL：用于管理 database 和 table 的

DML：用于对数据记录进行增删改

DQL：用于对数据记录进行查询的

DCL：给 DBA 用来管理数据库账号和权限的

DDL
操作库
创建库：

sql
create database if not exists 库名称 character set 字符集;
MySQL 里的 utf8mb4，就是我们日常所说的 utf-8。

sql
create database if not exists 库名称;
create database 库名称;
进入库：

sql
use 库名称;
列出所有库：

sql
show databases;
查看当前库：

sql
select database();
删除库：

sql
drop database 库名称;
操作表
MySQL 的数据类型
数值类型：

整数

int

bigint

小数

float

double

double(数字总长度, 小数位)

double(5, 2) 存储 -999.99 到 999.99

字符串类型：

char(n) —— 定长字符串

char(5)

最多存储 5 个字符

如果实际存储的不足 5 个，也会占用 5 个字符的空间

varchar(n) —— 变长字符串

varchar(5)

最多存储 5 个字符

如果实际存储的不足 5 个，内容多大就占空间

日期时间类型：

date —— 仅日期，格式：2026-03-20

datetime —— 日期 + 时间，格式：2026-03-20 20:03:02

MySQL 的字段约束
唯一约束：

语法关键字：unique

效果：添加了唯一约束的字段，值不能重复

非空约束：

语法关键字：not null

效果：添加了非空约束的字段，值不能为空

默认约束：

语法关键字：default 默认值

效果：添加了默认约束的字段，如果不设置数据，将会取默认值

主键约束：

语法关键字：primary key auto_increment

效果：添加了主键约束的字段，称为主键字段，主键字段值要求 非空且唯一

注意：一张表只能有一个主键约束

注意：任何表创建时，原则上都要有一个主键字段，用于存储一行记录的唯一标识

创建表：

sql
create table 表名称(
    字段名  字段类型  约束 comment '字段说明',
    字段名  字段类型  约束 comment '字段说明',
    ......,
    字段名  字段类型  约束 comment '字段说明'
);