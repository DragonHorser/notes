天数	章节	标签	学习任务 + RAG 向练习
Day1	7. 高级特性8. 函数式编程	🔥必学	7：切片、列表推导式；写生成器做文档 chunk 分批读取 demo；迭代器懂原理8：lambda/map/filter 做文本清洗；手写简易计时装饰器（模拟接口装饰器）
Day2	9. 模块10. 面向对象编程	🔥必学	9：搭建小型 rag_demo 目录，练习绝对 / 相对导入，吃透__name__ == '__main__'10：定义 Document 文档类，简单继承；目标看得懂 LangChain 各类对象
Day3	11. 面向对象高级编程12. 错误、调试和测试	⚠难点 +🔥必学	11：只学 @property、__str__魔术方法；浅看__slots__、多重继承；元类直接跳过12：try‑except 捕获文件、解析异常；pdb 简单调试；写 pytest 单元测试校验分片函数
Day4	13.IO 编程15. 正则表达式	🔥必学	13：pathlib 文件操作，遍历文件夹加载文档 demo；读写文本 / 二进制15：re 做文档清洗：去除多余换行、提取关键片段；不写极度复杂正则
Day5	14. 进程和线程16. 常用内建模块17. 常用第三方模块	⚠难点 +🟡浅读	14：理解进程 / 线程、GIL；不手写多进程业务代码，记住 AI 后端优先 asyncio16：重点掌握datetime、collections；其余模块只留印象17：requests 写同步调用大模型 API；Pillow 仅了解用途
Day6	19. 网络编程22.Web 开发21. 访问数据库	🟡浅读 +🔥必学	19：看懂 TCP/UDP 概念，不写 socket 代码22：吃透 WSGI 原理，老 web 框架跳过，铺垫 FastAPI21：Python 数据库 CRUD；SQLAlchemy 简单 demo，存储 RAG 文档元数据
Day7	23. 异步 IO整体复盘	🔥最高优先级难点	23：重点攻坚！练习async/await；aiohttp 异步并发请求模拟大模型接口；理解事件循环；区分同步 / 异步函数，禁止混用复盘：把前面所有 demo 全部跑通，整理高频代码片段，梳理易错点