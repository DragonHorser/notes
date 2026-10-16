JavaSE 继承 超全复习笔记（重点+难点+坑点）
一、继承核心概念【⭐必考重点】
1. 继承作用
解决代码冗余，实现代码复用：子类无需重复定义父类已有的字段、方法，只需要扩展自己独有功能。
示例关系：Student extends Person
- 父类（超类/基类）：Person，通用属性行为
- 子类（扩展类）：Student，在父类基础上拓展独有属性
2. Java继承硬性规则【高频考点】
- 单继承机制：一个类只能继承一个直接父类（区别于Python多继承）
- 所有类终极父类是Object：不写extends，默认 extends Object
- 禁止子类定义和父类重名字段：会造成字段隐藏，极度不推荐
- 子类自动拥有父类非私有的所有属性和方法
二、访问修饰符：protected【⭐重点】
1. 权限范围
- private：仅本类可见，子类无法访问
- protected：本类 + 所有子类 + 同包类可见
继承场景专用：想让子类直接访问父类字段，就用 protected。
2. 代码对比
// 父类private，子类无法访问（报错）
class Person { private String name; }

// 改为protected，子类可直接访问（正常）
class Person { protected String name; }
三、super 关键字【🔥难点+必考坑点】
1. super 三大用法
- super.字段：访问父类成员变量
- super.方法()：调用父类成员方法
- super()：调用父类构造方法
2. 构造方法超级大坑【90%新手报错点】
核心规则：
1. 子类构造方法第一行，必须调用父类构造
2. 不手写 super()，编译器自动补 super()（无参）
3. 如果父类没有无参构造，子类必须手动写 super(参数)，否则编译报错
3. 错误示例（报错）
class Person {
    // 只有有参构造，编译器不会自动生成无参构造
    public Person(String name, int age) {}
}

class Student extends Person {
    public Student(String name, int age, int score) {
        // 编译器自动补 super(); 父类无无参构造 → 编译报错
        this.score = score;
    }
}
4. 正确写法
class Student extends Person {
    public Student(String name, int age, int score) {
        super(name, age); // 手动调用父类有参构造，必须第一行
        this.score = score;
    }
}
5. 关键结论
- 构造方法不能被继承
- 子类构造先初始化父类，再初始化自己
四、向上转型 & 向下转型【🔥超级难点/面试高频】
1. 向上转型（Upcasting）
定义：子类对象赋值给父类引用，自动转换、安全、无报错
语法：父类 引用 = new 子类();
Person p = new Student();
Object o = new Student();
特点：
- 安全无损
- 丢失子类独有方法（只能调用父类定义的方法）
2. 向下转型（Downcasting）
定义：父类引用强制转为子类类型，不安全，极易抛异常
Person p1 = new Student();
Student s1 = (Student) p1; // 正确：真实对象是Student

Person p2 = new Person();
Student s2 = (Student) p2; // 运行报错：ClassCastException
3. instanceof 关键字【必用避坑】
作用：判断对象真实类型，向下转型前必须判断
if (p instanceof Student) {
    Student s = (Student) p;
}
Java14+ 模式匹配（简化写法）
if (p instanceof Student s) {
    // 直接使用s，无需强转
}
4. 转型核心总结
- 向上转型：自动、安全、多态基础
- 向下转型：强制、危险、必须配合instanceof
五、继承设计原则：is / has 关系【⭐面试必考】
1. 继承：is-a 关系
子类 是一种 父类 → 用继承
例：Student is Person ✅ 合理继承
2. 组合：has-a 关系
子类 包含一个 父类对象 → 用组合（成员变量）
例：Student has Book ❌ 不能继承，应该组合
// 正确：组合
class Student extends Person {
    Book book; // 持有对象
}
黄金原则：优先组合，少用继承
六、sealed 密封类（了解）
Java15+ 特性：限制类只能被指定子类继承，防止滥用继承
public sealed class Shape permits Rect, Circle {}
七、本节终极重点 & 难点汇总
✅ 必须背诵重点
1. Java 单继承，根类是 Object
2. protected 访问权限、private 子类不可见
3. super() 必须在子类构造第一行
4. 父类无无参构造，子类必须手动传参 super
5. 向上转型自动、向下转型强制+instanceof
6. 继承is-a，组合has-a
🔥 高频难点
1. 子类构造方法父类初始化机制
2. 上下转型真实对象 vs 引用类型区别
3. 转型异常产生原因
💣 高频坑点
1. 以为 private 字段能被继承访问（不能）
2. 父类有参构造覆盖无参构造，子类不写super直接报错
3. 无脑向下转型，不做 instanceof 判断
4. 乱用继承（非is关系强行继承）
八、课后练习标准答案（PrimaryStudent）
class PrimaryStudent extends Student {
    protected int grade;

    public PrimaryStudent(String name, int age, int score, int grade) {
        super(name, age, score);
        this.grade = grade;
    }
}