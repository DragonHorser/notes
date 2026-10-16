# JavaSE 完整学习流程+重点难点+避坑指南

> 学习路线：环境搭建 → 基础语法 → 数组/方法 → 面向对象 → 常用类 → 集合框架 → 异常 → IO流 → 多线程 → JDK8+新特性 → 综合实战

## 一、Java入门与环境搭建

**学习内容**：Java概述、JDK/JRE/JVM、环境变量、IDEA、HelloWorld、编译运行流程

**重点**

- JDK包含JRE，JRE包含JVM；开发用JRE不行，运行只需JRE
- Java跨平台：JVM屏蔽操作系统差异，一次编译到处运行
- 编译`javac`，运行`java`

**难点**

- JVM基础运行机制
- JAVA_HOME、PATH环境变量作用原理

**坑点**

1. 不配`JAVA_HOME`，后续Maven/Tomcat各种工具报错
2. `public`修饰的类，类名必须和`.java`文件名完全一致，大小写敏感
3. 中文标点符号，直接编译报错
4. 运行class文件不要带`.class`后缀

## 二、Java基础语法

**学习内容**：变量、8大基本类型、运算符、分支循环、数组、Scanner

**重点**

- 8大基本数据类型取值范围、默认值、对应包装类
- 自动类型转换、强制类型转换（可能丢失精度）
- `&& ||`短路逻辑，`& |`非短路
- `for/while/do‑while`；`break/continue`
- 数组静态初始化、动态初始化，遍历

**难点**

- `i++`与`++i`混合运算顺序
- 逻辑短路行为
- 二维数组内存模型
- 数组边界判断

**坑点**

1. 整数相除 `1/2=0`，不会自动小数，需要强转double
2. char参与运算自动转为ASCII数值
3. 数组长度固定，不能直接扩容，只能拷贝新建数组
4. `ArrayIndexOutOfBoundsException`数组索引越界
5. 数组未初始化直接使用，空指针
6. for循环内定义变量，循环外部不能访问

## 三、方法与面向对象基础

**学习内容**：方法定义调用、重载、参数传递、类与对象、成员变量/局部变量、封装

**重点**

- **方法重载**：方法名相同，参数列表不同；与返回值无关
- Java只有**值传递**：基本类型传副本；引用类型传对象地址副本
- 成员变量：堆内存，有默认值，跟随对象生命周期
- 局部变量：栈内存，无默认值，方法结束销毁
- 封装：属性private，提供get/set

**难点**

- 值传递本质：修改对象属性会影响原对象；修改引用本身不会
- 局部变量成员变量同名就近原则

**坑点**

1. 返回值不同不算重载，编译报错
2. 局部变量必须手动初始化，没有默认值
3. 误以为引用类型是“引用传递”写出错误逻辑
4. 成员变量直接public暴露，破坏封装

## 四、面向对象三大特性（封装、继承、多态）

**学习内容**：继承、`super`、方法重写、向上转型、向下转型、多态、`this/static/final`、抽象类、接口

**重点**

- Java类是**单继承**，支持多层继承
- 方法重写：子类重写父类方法；权限不能更严格
- 多态：父类引用指向子类对象；**编译看左边，运行看右边（只针对方法）**
- `this`当前对象；`super`父类对象/父构造器
- `static`属于类，优先对象加载，全局共享
- `final`：变量不可修改；方法不可重写；类不可继承
- 抽象类：包含抽象方法，不能实例化
- 接口：JDK7只有抽象；JDK8默认/静态方法；JDK9私有方法；支持多实现

**难点**

- 多态细节：成员变量、静态方法没有多态行为
- 向上转型、向下转型，`instanceof`判断
- 构造执行顺序：父类构造优先子类构造；`super()`必须第一行
- 静态代码块、构造代码块、构造方法执行顺序
- 抽象类 vs 接口（面试高频）

**坑点**

1. 父类private方法不能重写，子类同名只是新方法
2. 多态访问成员变量，编译运行都看父类
3. 向下强转不做`instanceof`判断，抛出`ClassCastException`
4. 接口中变量默认`public static final`，抽象方法默认`public abstract`，不能随便改权限
5. static方法不叫重写，叫方法隐藏
6. 父类没有无参构造，子类不显式写super会编译报错

## 五、常用类与字符串

**学习内容**：`String`、`StringBuilder`、`StringBuffer`、包装类、`Object`、Date时间API

**重点**

- String不可变，字符串拼接生成新对象
- StringBuilder：可变，线程不安全，效率高；StringBuffer线程安全
- 自动装箱、自动拆箱
- Object：`equals()`、`toString()`、`hashCode()`
- 时间戳、日期格式化

**难点**

- 字符串常量池原理，对象创建分析
- `==`和`equals()`区别
- `hashCode()`与`equals()`约定：相等对象hashCode必须相等

**坑点**

1. String比较内容不用`==`，要用`equals()`；`==`比较地址
2. 循环大量拼接字符串，优先用StringBuilder，不要直接`+`
3. `null`和`""`区分：null没有对象，调用方法直接空指针
4. Integer缓存范围`‑128~127`，超出缓存`==`不相等
5. `SimpleDateFormat`线程不安全，多线程环境不能共用实例

## 六、集合框架（面试重点）

**学习内容**：Collection、List、Set、Map；ArrayList、LinkedList、HashSet、HashMap；迭代、遍历

**重点**

- Collection单列集合；Map双列键值对集合
- List有序可重复
  - ArrayList：底层数组；查询快，增删慢
  - LinkedList：双向链表；增删快，查询慢
- Set无序不可重复，HashSet底层基于HashMap
- HashMap JDK1.8：数组+链表+红黑树；键唯一，允许一个null键
- 遍历方式：普通for、增强for、Iterator迭代器、lambda

**难点**

- HashMap底层、哈希扰动、扩容、树化条件
- HashSet去重依赖`hashCode()+equals()`
- ArrayList扩容机制：初始容量10，1.5倍扩容
- 并发修改异常产生原因

**坑点**

1. 增强for循环遍历集合时直接add/remove，报并发修改异常
2. 自定义对象存入HashSet/HashMap，不重写`hashCode()`和`equals()`，无法去重
3. 大数据量ArrayList不指定初始容量，频繁扩容性能差
4. LinkedList不要用普通for循环遍历，性能极差
5. HashMap可以存一个null key，多个null value

## 七、异常机制

**学习内容**：异常体系，编译时异常、运行时异常，`try‑catch‑finally`，`throws`，`throw`，自定义异常

**重点**

- Throwable：Error系统错误，无法处理；Exception可处理异常
- 编译时异常：必须显式处理；RuntimeException运行时异常可选择不处理
- finally：几乎一定执行；只有JVM退出时不执行
- `throws`声明抛出；`throw`手动抛出单个异常对象

**难点**

- try代码块return，finally仍然会执行，return时机
- catch捕获顺序：子类异常放前面，父类异常放后面

**坑点**

1. 空catch，吃掉异常不打印日志，隐藏bug
2. finally修改返回值，返回结果不符合预期
3. 子类重写父类方法，不能抛出比父类范围更大的异常
4. 尝试捕获Error，没有意义

## 八、IO流

**学习内容**：字节流、字符流、缓冲流、转换流、序列化、资源关闭

**重点**

- 字节流InputStream/OutputStream：万能，可以处理所有文件
- 字符流Reader/Writer：只适合文本文件
- 缓冲流BufferedXXX提升读写性能
- 对象序列化需要实现`Serializable`接口
- JDK7 `try‑with‑resources`自动关闭流

**难点**

- 乱码问题，字节字符流适用场景区分
- `transient`瞬态字段不参与序列化
- flush缓冲区刷新机制

**坑点**

1. 二进制文件（图片视频）用字符流读写，文件损坏
2. 字符流写完忘记`flush()`或者close()，数据留在缓冲区没有写入文件
3. IO流不关闭，资源泄漏
4. 序列化类新增字段，没有`serialVersionUID`，反序列化报错
5. 混淆相对路径绝对路径，文件找不到

## 九、多线程（JavaSE难点天花板）

**学习内容**：线程创建方式、线程状态、线程安全、synchronized、Lock、volatile、死锁、wait/notify、线程池

**重点**

- 线程创建：继承Thread；实现Runnable；实现Callable（带返回值）
- 多线程共享资源产生线程安全问题；synchronized / Lock加锁解决
- volatile：保证可见性、禁止指令重排，**不保证原子性**
- 线程池复用线程，减少创建销毁开销
- 线程状态：新建、就绪、运行、阻塞、死亡

**难点**

- synchronized同步代码块、同步方法锁对象
- 并发三大特性：原子性、可见性、有序性
- 死锁四个必要条件
- wait/notify等待通知机制，必须在同步块内
- 线程池七大核心参数、拒绝策略

**坑点**

1. 多个线程new各自对象，不存在共享数据，加锁毫无意义
2. synchronized锁对象选错，锁失效，并发错乱
3. volatile不能保证原子性，不要用来做计数
4. 禁止直接使用Executors快捷创建线程池，容易OOM
5. sleep不释放锁；wait会释放锁，二者不要混淆
6. wait notify不在同步代码块中调用直接抛异常

## 十、JDK8+新特性

**学习内容**：Lambda、函数式接口、Stream流、Optional、LocalDateTime

**重点**

- Lambda语法 `(参数)‑>{代码}`，简化匿名内部类
- 函数式接口：只有一个抽象方法，注解`@FunctionalInterface`
- Stream流：集合链式处理，过滤、映射、排序、收集
- Optional用来规避空指针
- LocalDate/LocalDateTime线程安全日期API，替代老Date

**难点**

- Stream中间操作（延迟）、终止操作（触发执行）
- Stream流只能消费一次，用完就关闭
- Lambda捕获外部变量必须是有效final

**坑点**

1. Stream处理过程修改原集合，出现并发修改异常
2. Stream已经执行终止操作，再次调用报错
3. Lambda不能修改外部局部变量
4. 继续使用SimpleDateFormat多线程共用实例

## 十一、全局避坑总结

1. 一定要理解内存模型：栈、堆、方法区；大量bug根源来自内存理解不清
2. Lambda、增强for循环、自动装箱都是语法糖，要懂底层原理，不要只会调用API
3. 报错优先看异常栈信息，根据报错行定位问题，不要盲目试错
4. 不要滥用static；IO资源记得关闭；并发场景时刻考虑线程安全
5. 面向对象不要只背概念，写代码刻意练习封装继承多态
