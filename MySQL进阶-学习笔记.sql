---- 进阶篇begining
---- 第一部分 存储引擎
--- 按照顺序有四层：连接层，服务层，引擎层和存储层

-- 查询建表语句
show create table account;##默认存储引擎InnoDB

-- 查询的当前数据库库支持的存储引擎
show engines ;

--- 创建表 my_myisam 并指定引擎
create table my_myisam(
    id int,
    name varchar(10)
)engine = MyISAM;
--- 创建表 my_memory 并指定引擎
create table my_memory(
    id int,
    name varchar(10)
)engine = Memory;

show variables like 'innodb_file_per_table';##查看系统变量，可在cmd中查看表结构 cmd命令行输入ibd2sdi account.ibd

--- innodb逻辑存储结构
--- 表空间tablespacce 段segment 区extent 页page 行row
--- 一个区含有64个页，固定大小1M，为了保证页连续，通常分配4-5个区
--- 一页固定大小16K
-- 以及innodb与myisam的区别
--- innodb支持外键，行级锁以及事务
--- myisam不支持事务和外键，支持表锁

--- 第二部分 索引

--- 索引操作语法
CREATE TABLE tb_user (
    id int auto_increment comment 'id' primary key ,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    profession VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    gender char(1) comment '1: 男, 2: 女',
    status int not null,
    createtime DATETIME NOT NULL
)comment 'tb_user';

INSERT INTO tb_user (name, phone, email, profession, age, gender, status, createtime) VALUES
('吕布', '17799990000', 'vbu666@163.com', '软件工程', 23, 1, 6, '2001-02-02 00:00:00'),
('曹操', '17799990001', 'caocao6666@qq.com', '通讯工程', 31, 1, 0, '2001-03-05 00:00:00'),
('赵云', '17799990002', '17799990@139.com', '英语', 34, 1, 2, '2002-03-02 00:00:00'),
('孙悟空', '17799990003', '17799990@sina.com', '工程造价', 54, 1, 0, '2001-07-02 00:00:00'),
('花木兰', '17799990004', '19980729@sina.com', '软件工程', 23, 2, 1, '2001-04-22 00:00:00'),
('大乔', '17799990005', 'daqiao666@sina.com', '舞蹈', 22, 2, 0, '2001-02-07 00:00:00'),
('露娜', '17799990006', 'luna_loveesina.com', '应用数学', 24, 2, 0, '2001-02-08 00:00:00'),
('程咬金', '17799990008', 'xiaoyu666@qq.com', '金属材料', 43, 1, 5, '2001-09-18 00:00:00'),
('项羽', '17799990009', 'baiqi666@sina.com', '机械工程及其自动化', 27, 1, 0, '2001-08-16 00:00:00'),
('白起', '17799990010', 'hbaiqi520@163.com', '机械工程及其自动化', 27, 1, 2, '2001-06-12 00:00:00'),
('韩信', '17799990010', 'hanxin520@163.com', '无机非金属材料工程', 27, 1, 0, '2001-06-12 00:00:00'),
('荆柯', '17799990011', 'jingke123@163.com', '会计', 29, 1, 0, '2001-05-11 00:00:00'),
('兰陵王', '17799990012', 'lanlinwang666@126.com', '工程造价', 44, 1, 1, '2001-04-09 00:00:00'),
('狂铁', '17799990013', 'kuangtie@sina.com', '应用数学', 43, 1, 2, '2001-04-10 00:00:00'),
('貂蝉', '17799990006', 'luna_loveesina.com', '软件工程', 24, 2, 3, '2001-02-08 00:00:00'),
('姐己', '17799990014', '2783238293@qq.com', '软件工程', 31, 2, 0, '2001-01-30 00:00:00'),
('半月', '17799990015', 'xiaomin2001@sina.com', '工业经济', 35, 2, 0, '2000-05-03 00:00:00'),
('嬴政', '17799990016', '8839434342@qq.com', '化工', 38, 1, 1, '2001-08-08 00:00:00'),
('狄仁杰', '17799990017', 'jujiamlm8166@163.com', '国际贸易', 30, 1, 0, '2007-03-12 00:00:00'),
('安琪拉', '17799990018', 'jdodmlh@126.com', '城市规划', 51, 2, 0, '2001-08-15 00:00:00'),
('典韦', '17799990019', 'ycaunanjian@163.com', '城市规划', 52, 1, 2, '2000-04-12 00:00:00'),
('廉颇', '17799990020', 'lianpo321@126.com', '土木工程', 19, 1, 3, '2002-07-18 00:00:00'),
('后羿', '17799990021', 'altycj2000@139.com', '城市园林', 20, 1, 0, '2002-03-10 00:00:00'),
('姜子牙', '17799990022', '37483844@qq.com', '工程造价', 29, 1, 4, '2003-05-26 00:00:00');
------ 需求
---- -1. name字段为姓名字段，该字段的值可能会重复，为该字段创建索引。
create index idx_user_name on tb_user(name);
----- 2. phone手机号字段的值，是非空，且唯一的，为该字段创建唯一索引。
create unique index idx_user_phone on tb_user(phone);
----- 3. 为profession、age、status创建联合索引。
create index idx_user_pro_age_sta on tb_user(profession,age,status);##联合索引的顺序是最左原则，用的最多的放左边
----- 4.为email建立合适的索引来提升查询效率。
create index idx_user_email on tb_user(email);
##删除索引
drop index idx_user_email on tb_user;
##查看索引
show index from tb_user;

----- SQL性能分析

----看增删改为主还是查询为主
show global status like 'Com_______'
---查看每一条SQL的耗时情况
show profiles;
----查看query id的SQL语句各个阶段大的耗时情况
show profile for query query_id;
---- 查看-----CPU使用情况
show profile cpu for query query_id;
---- 获取select执行顺序以及如何连接等信息
explain select * from tb_user where id = 1;

------ SQL性能分析
create table student(
    id int auto_increment  primary key comment '主键ID',
    name varchar(10) comment '姓名',
    no varchar(10) comment '学号'
)comment '学生表';
insert into student VALUES (null,'黛绮丝', '2000100101'),(null,'谢逊', '2000100102'),(null,'殷天正', '2000100103'),(null,'韦一笑', '2000100104');

create table course(
    id int auto_increment  primary key comment '主键ID',
    name varchar(10) comment '课程名称'
)comment '课程表';
insert into course VALUES (null,'Java'),(null,'PHP'),(null,'MySQL'),(null,'Hadoop');

create table student_course(
    id int auto_increment  primary key comment '主键',
    studentid int not null comment '学生ID',
    courseid int not null comment '课程ID',
    constraint fk_courseid foreign key (courseid) references course(id),
    constraint fk_studentid foreign key (studentid) references student(id)
)comment '学生课程中间表';
insert into student_course VALUES (null,1, 1),(null,1, 2),(null,1, 3),(null,2, 2),(null,2, 3),(null,3, 4);

select s.*,c.* from student s, course c,student_course sc where s.id = sc.studentid and c.id = sc.courseid;
explain  select s.*,c.* from student s, course c,student_course sc where s.id = sc.studentid and c.id = sc.courseid;

-----查询选修了MySQL课程的学生（子查询）
select id from course c where c.name= 'MySQL';
use itheima;
select studentid from student_course sc where sc.courseid = 3;
select * from student s where  s.id in (1,2);
---- 整理成一个
select * from student s where  s.id in (select studentid from student_course sc where sc.courseid = (select id from course c where c.name= 'MySQL'));

explain  select * from student s where  s.id in (select studentid from student_course sc where sc.courseid = (select id from course c where c.name= 'MySQL'));

-------- 418 验证最左前缀法则
use itcast;
select  * from tb_user where profession = '软件工程' and age = 31 and status = '0';
explain select  * from tb_user where profession = '软件工程' and age = 31 and status = '0';

select  * from tb_user where profession = '软件工程';
explain  select  * from tb_user where profession = '软件工程';

select  * from tb_user where profession = '软件工程';

------ 第三部分 SQL优化

mysql --local-infile -u root -p##进入local infile

select @@local_infile;#3查看状态，默认为0

set global local_infile = 1;#打开

CREATE TABLE tb_user (
    id INT(11) NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    name VARCHAR(20) NOT NULL,
    birthday DATE DEFAULT NULL,
    sex CHAR(1) DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY `unique_user_username` (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

use itheima;
----- 第四部分 视图
-- 1.创建视图
create or replace view stu_v_1 as select id,name from student where id <= 10;
-- 2.查询视图
--- 查看创建视图语句
show create view stu_v_1;

--- 查看视图数据
select * from stu_v_1;

--- 有条件的查看视图数据
select * from stu_v_1 where  id < 3;
-- 3.修改视图
--- 方式一
create or replace view stu_v_1 as select id,name,no from student where id <= 10;

--- 方式二
alter  view stu_v_1 as select id ,name from student where id <= 10;

-- 4.删除视图
drop view if exists stu_v_1;

------ 试图检查选项cascaded 视图的增删改

create or replace view stu_v_1 as select id,name from student where id <= 20;
select * from stu_v_1;
--- 添加数据
insert into stu_v_1 values (6,'Tom');##视图不保存数据，增删改的数据都在基础表里

insert into stu_v_1 values (30,'Tom',2000000000);##视图看不到，因为视图是id小于20的

create or replace view stu_v_1 as select id,name from student where id <= 20 with cascaded check option ;##或者用localcheck option
insert into stu_v_1 values (6,'Tom');
insert into stu_v_1 values (32,'Tom');##会失败，因为有cascaded check option约束

---- cascadeed
create or replace view stu_v_1 as select id,name from student where id <= 20;
insert into stu_v_1 values (25,'Tom');##不会失败，因为没有cascaded check option约束

create or replace view stu_v_2 as select id,name from stu_v_1 where id >= 10 with cascaded check option ;
select * from stu_v_2;
insert into stu_v_2 values (7,'Tom');##会报错，因为不满足当前视图
insert into stu_v_2 values (26,'Tom');##会报错，因为cascaded check option不仅要检查当前视图，也会检查当前视图依赖的所有视图


create or replace view stu_v_3 as select id,name from stu_v_2 where id <=15 ;
insert into stu_v_3 values (11,'Tom');
insert into stu_v_3 values (17,'Tom');##可以成功因为v3咩有加with cascaded check option，同时满足v2和v1
insert into stu_v_3 values (28,'Tom');##会报错，因为不满足v2


---------- local
create or replace view stu_v_4 as select id,name from student where id <= 15;
insert into stu_v_4 values (5,'Tom');
insert into stu_v_4 values (16,'Tom');

create or replace view stu_v_5 as select id,name from stu_v_4 where id >= 10 with local check option ;
insert into stu_v_5 values (13,'Tom');
insert into stu_v_5 values (17,'Tom');


create or replace view stu_v_6 as select id,name from stu_v_5 where id <=20 ;
insert into stu_v_6 values (11,'Tom');

---- 视图案例

-- 1．为了保证数据库表的安全性，开发人员在操作tb_user表时，只能看到的用户的基本字段，屏蔽手机号和邮箱两个字段
use itcast;
create view tb_user_view as select id,name,profession,age,gender,status,createtime from tb_user;

select * from tb_user_view;

-- 2．查询每个学生所选修的课程（三张表联查)，这个功能在很多的业务中都有使用到，为了简化操作，定义一个视图
use  itheima;
--- 三表联查
select * from student s,student_course sc,course c where s.id=sc.studentid and sc.courseid= c.id;

select s.name,s.no,c.name from student s,student_course sc,course c where s.id=sc.studentid and sc.courseid= c.id;

create view tb_stu_course_view as select s.name student_name,s.no student_no,c.name course_name from student s,student_course sc,course c where s.id=sc.studentid and sc.courseid= c.id;

select * from tb_stu_course_view;

----- 存储过程
--- 创建
create procedure p1()
begin
    select count(*) from student;
end;
-- 调用
call p1();
-- 查看
select * from information_schema.ROUTINES where ROUTINE_SCHEMA = 'itheima';
---- 查看p1被定义时的语句
show create procedure p1;
--- 删除
drop procedure  if exists p1;

----- 变量：系统变量
------- 查看系统变量
show variables ;#默认session

---- 查看跟事务相关的变量，模糊匹配like
show session  variables like'auto%';

show local variables like'auto%';

----- 精准查找
select @@autocommit;
select @@global.autocommit;
select @@session.autocommit;

--- 设置系统变量
set session autocommit = 0;##关闭手动提交

--- 变量：用户变量
-- 赋值
set @myname = 'itcast';
set @myage := 10;
set @mygender :='男', @myhobby :='java';##赋值推荐使用：=

select @mycolor :='red';
select count(*) into @mycount from tb_user;
-- 使用
select  @myname,@mygender,@myhobby;

select  @mycolor,@mycount;

select @abc;##将会返回null值


--- 变量：局部变量,是在begin和end之间的

--- 声明--declare
---- 赋值
create procedure p2()
begin
    declare stu_count int default 0;
    select count(*) into stu_count from student;
    select stu_count;
end;

call p2();


--- 定义存储过程，完成如下需求
---- 根据定义的分数score变量，判定当前分数对应的分数等级。
--- 1. score >= 85分，等级为优秀。
--- 2. score >=60分且score<85分，等级为及格。
--- 3.score<60分，等级为不及格。
---假定58为判断标准
create procedure p3()
 begin
     declare score int default 58;
     declare result varchar(10);
     if score >=85 then
         set result := '优秀';
    elseif score >= 60 then
         set result :='及格';
    else
         set result :='不及格';
     end if;
    select result;
 end;

call p3();

---- 存储过程 in out inout参数
-- 根据传入参数（in）score，判定当前分数对应的等级并返回结果（out）
--- 1定义存储过程
-- 2调用存储过程
-- 3查看结果
create procedure p4(in score int, out result varchar(10))
 begin
     if score >=85 then
         set result := '优秀';
    elseif score >= 60 then
         set result :='及格';
    else
         set result :='不及格';
     end if;
 end;

call p4(68,@result);##要用一个空值变量来接收返回的参数，这个值属于局部变量

select @result;

--- 需求二
--- 将200分制的分数进行换算成百分制，然后返回分数  ---inout 即使输入又是输出
drop procedure p5;
create procedure p5(inout score double)
 begin
     set score := score*0.5;
 end;

set @score = 78;
call p5(@score);
select @score;


---- 存储过程case 实例
--- 根据传入的月份，判定月份所属的季节（要求采用case结构）。
--- 1.1-3月份，为第一季度
-- 2.4-6月份，为第二季度
-- 3.7-9月份，为第三季度
-- 4.10-12月份，为第四季度

create procedure p6(in month int)
begin
    declare result varchar(10);

    case
        when month >=1 and month <=3 then
            set result := '第一季度';
        when month >=4 and month <=6 then
            set result := '第二季度';
        when month >=7 and month <=9 then
            set result := '第三季度';
        when month >=10 and month <=12 then
            set result := '第四季度';

        else
            set result := '非法参数';
    end case;

    select concat('您输入的月份为：', month, '所属季度为' , result);
end;

call p6(3);

----- 存储过程：循环while
--- 从1加到n 步骤：
--- 1定义局部变量 记录累加之后的值
--- 2每循环一次会对n减去1，直到n=0则退出循环

create procedure  p7(in n int)
begin
    declare total int default 0;

    while n > 0 do
        set total := total + n;
        set n := n -1;
    end while;

    select total;
end;

call p7(10);

----- 存储过程：循环repeat 有条件的循环
--- 从1加到n 步骤：
--- 1.定义局部变量，记录累加之后的值
--- 2.每循环一次就会对n减一，如果n等于0则退出循环
drop procedure p8;
create procedure p8(in n int)
begin
    declare total int default 0;

    repeat
        set total := total +n;
        set n := n-1;
    until n<=0
    end repeat;

    select total;
end;

call p8(10);
call p8(100);

------ 存储过程：循环loop
--------- 1.计算从1累加到n的值，n为传入的参数值。
--- 步骤
--- 1.定义局部变量，记录累加之后的值 给循环过程起一个名字sum
--- 2.每循环一次就会对n减一，如果n等于0则退出循环 leave xxx
create procedure p9(in n int)
    begin
        declare total int default  0;

        sum:loop
            if n<= 0 then
                leave sum;
            end if;

            set total := total + n;
            set n := n -1;

        end loop sum;

        select  total;

    end;

call p9(10);

----------- 2.计算从1到n之间的偶数累加的值，n为传入的参数值。

--- 步骤
--- 1.定义局部变量，记录累加之后的值 给循环过程起一个名字sum
--- 2.每循环一次就会对n减一，如果n等于0则退出循环 leave xxx
--- 3.如果当前累加的数据时奇数则直接进入下一个循环 interate

create procedure p10(in n int)
    begin
        declare total int default  0;

        sum:loop
            if n<= 0 then
                leave sum;
            end if;

            if n%2 = 1 then
                set n = n - 1;
                iterate  sum;
            end if;

            set total := total + n;
            set n := n -1;

        end loop sum;

        select  total;

    end;

call p10(10);
call p10(100);

----存储过程 游标；用来存储查询结果集的数据类型

create procedure p11()
begin
    declare stu_count int default 0;
    select * into stu_count from student;##此时会报错，因为stu-count时数字，* 是一个表，不能匹配
    select stu_count;
end;

call p11();

---- 存储案例
-- 根据传入的参数uage，来查询用户表tb_user中，所有的用户年龄小于等于uage的用户姓名(name)和专业（profession)，
-- 并将用户的姓名和专业插入到所创建的一张新表(id,name,profession)中。
use itcast;
---- 步骤：
---- 1.先声明游标，存储查询结果集
----- 2.准备：创建表的结构
---- 3.开启游标
--- 4.获取游标中的记录
--- 5.插入数据到新表中
--- 6. 关闭游标
create procedure p11(in uage int)
 begin
     declare uname varchar(100);##要先声明普通变量再声明游标，是有顺序要求的
     declare  upro varchar(100);

     declare u_cursor cursor for select name,profession from tb_user where age <= uage;



     create table if not exists tb_user_pro(
         id int primary key auto_increment,
         name varchar(100),
         profession varchar(100)
 );

     open u_cursor;

     while true do
        fetch u_cursor into uname, upro;
        insert into tb_user_pro values (null,uname,upro);##因为id自增所以传递个null
     end while;

     close u_cursor;

 end;

call p11(40);##查年龄小于40的，这里的40是uage的赋值

## 但是以上代码会报错也不会产生新表，因为while循环不会结束

----- 解决方案一 使用状态码
create procedure p12(in uage int)
 begin
     declare uname varchar(100);##要先声明普通变量再声明游标，是有顺序要求的
     declare  upro varchar(100);

     declare u_cursor cursor for select name,profession from tb_user where age <= uage;

     declare exit handler for SQLSTATE '02000' close u_cursor;



     create table if not exists tb_user_pro(
         id int primary key auto_increment,
         name varchar(100),
         profession varchar(100)
 );

     open u_cursor;

     while true do
        fetch u_cursor into uname, upro;
        insert into tb_user_pro values (null,uname,upro);##因为id自增所以传递个null
     end while;

     close u_cursor;

 end;

call p12(30);##查年龄小于40的，这里的40是uage的赋值

----解决方案二 使用not found
create procedure p13(in uage int)
 begin
     declare uname varchar(100);##要先声明普通变量再声明游标，是有顺序要求的
     declare  upro varchar(100);

     declare u_cursor cursor for select name,profession from tb_user where age <= uage;

     declare exit handler for not found close u_cursor;



     create table if not exists tb_user_pro(
         id int primary key auto_increment,
         name varchar(100),
         profession varchar(100)
 );

     open u_cursor;

     while true do
        fetch u_cursor into uname, upro;
        insert into tb_user_pro values (null,uname,upro);##因为id自增所以传递个null
     end while;

     close u_cursor;

 end;

call p13(30);##查年龄小于40的，这里的40是uage的赋值

----- 存储函数 参数只能是in类型的
---- 案例需求
---- 1.从1到n的累加
drop function fun1;
create function fun1(n int)#默认是in，默认是int
returns int deterministic #加deter--的目的是需要指出输出特性
begin
   declare total int default 0;

   while n > 0 do
       set total := total + n;
       set n := n - 1;
       end while;

   return total;
end;
select fun1(50);



---- 触发器
use itcast;

---- 总需求：通过触发器记录user表的数据变更日志user——logs，包含增加，修改，删除

--- 案例一：插入
---- 1.准备工作：日志表user——logs
create table user_logs(
  id int(11) not null auto_increment,
  operation varchar(20) not null comment '操作类型, insert/update/delete',
  operate_time datetime not null comment '操作时间',
  operate_id int(11) not null comment '操作的ID',
  operate_params varchar(500) comment '操作参数',
  primary key(`id`)
)engine=innodb default charset=utf8;

--- 2.定义触发器
create trigger  tb_user_insert_trigger
    after insert on tb_user for each row
begin
    insert into user_logs(id, operation, operate_time, operate_id, operate_params) VALUES
    (null,'insert',now(),new.id,concat('插入的数据内容为：id=' ,new.id,',name=',new.name,',phone=',new.phone,',email=',new.email, 'profession=',new.profession));
end;

--- 3.查看触发器
show triggers;

--- 4.删除触发器
drop trigger tb_user_insert_trigger;

--- 插入数据到tb——user
insert into tb_user(id, name, phone, email, profession, age, gender, status, createtime)
VALUES (25,'二皇子','18809091212','erhuangzi@163.com','软件工程',23,'1','1',now());##此时日志userlogs中可以看到

--- 案例二更新

---- 修改数据的触发器

create trigger  tb_user_update_trigger
    after update on tb_user for each row
begin
    insert into user_logs(id, operation, operate_time, operate_id, operate_params) VALUES
    (null,'update',now(),new.id,
    concat('更新之前的数据为：id=' ,old.id,',name=',old.name,',phone=',old.phone,',email=',old.email, 'profession=',old.profession,
        '更新之后的数据为：id=' ,new.id,',name=',new.name,',phone=',new.phone,',email=',new.email, 'profession=',new.profession));
end;

update tb_user set age = 32 where id = 23;

update tb_user set profession = '会计' where id <=5;

###行级触发器，会触发5次，userlogs中会更改五次
--- 查看
--- 去日志中看

--- 案例三：删除
--- 删除数据的触发器
create trigger  tb_user_delete_trigger
    after delete on tb_user for each row
begin
    insert into user_logs(id, operation, operate_time, operate_id, operate_params) VALUES
    (null,'delete',now(),old.id,
    concat('删除之前的数据为：id=' ,old.id,',name=',old.name,',phone=',old.phone,',email=',old.email, 'profession=',old.profession));
end;

show triggers ;

delete from tb_user where id = 25;


---- 第五部分 锁
----1全局锁 锁定数据库中的所有表 只读但是不能写入
flush tables with read lock ;
unlock tables ;

---- 备份数据
mysqldump -h 127.0.1.1 -uroot -p123456 itcast > D:/itcast.sql

--- 表级锁 包括表锁 元数据锁 意向锁

--- 表锁
-- 第一种表共享读锁
lock tables student read;
unlock tables ;
--- 第二种表独占写锁
lock tables student write;
unlock tables ;

--- 元数据锁
select object_type,object_schema,object_name,lock_type,lock_duration from performance_schema.metadata_locks;

----- 意向锁
select * from score where id = 1 lock in share mode;

---- 查看意向锁
select object_schema,object_name,index_name,lock_type,lock_mode,lock_data from performance_schema.data_locks;

-------- 进阶部分已完结



