show databases ;

show tables ;

desc user ;

insert into  employee(id, worknumber, name, gender, age, idcard, entrydate) values (1, '1', 'Itcast', '男', '10', '123456789012345678', '2000-01-01');

#insert into  employee(id, worknumber, name, gender, age, idcard, entrydate) values (2, '2', 'Itcast', '男', '10', '123456789012345678', '2000-01-01');

select * from employee;

insert into employee values (2, '2', '张无忌', '男', 18, '123456789012345678', '2005-01-01');

insert into employee values (3, '3', '韦一笑', '男', 38, '123456789012345678', '2005-01-01'),(4, '4', '赵敏', '女', 26, '123456789012345678', '2005-01-01');

update employee set name = 'Itheima' where id =1;

update employee set name  = '小昭', gender = '女' where id = 1;

#将所有员工的入职日期都修改为统一

update employee set entrydate = '2008-01-01';

delete from employee where gender = '女';

delete from employee;

drop table  employee;

create table emp(
	id int comment '编号',
	worknumber varchar(10) comment '工号',
	name varchar(10) comment '姓名',
	gender char(1) comment '性别',
	age tinyint unsigned comment '年龄',
	idcard char(18) comment '身份证号',
    workaddress char(50) comment '工作地址',
	entrydate date comment '入职时间'
) comment '员工表';

desc emp;

show create table  emp;

select * from emp;#查询所有字段返回

select workaddress from emp;#查询指定字段返回

select workaddress as '工作地址' from emp;#起别名

select distinct workaddress from emp;#查询住址不要重复

select id, workno, name, gender, age, idcard, workaddress, entrydate from emp; #查询所有字段返回

/*--条件查询*/
#1．查询年龄等于88的员工
select * from emp where age = 88;
#2．查询年龄小于20的员工信息
select  * from emp where age < 20;
#3．查询年龄小于等于20的员工信息
select  * from emp where age <= 20;
#4．查询没有身份证好的员工信息
select * from emp where idcard is null;
#5．查询有身份证号的员工信息
select * from emp where idcard is not null;
#6．查询年龄不等于88的员工信息
select  * from emp where age != 88;#不包含88
select  * from emp where age <> 88;#不包含88
#7．查询年龄在15岁(包含)到 20岁(包含)之间的员工信息
select  * from emp where age >=15 && age <=20;#不包含15和20
select  * from emp where age >=15 and age <=20;
select  * from emp where age between 15 and 20;#包括15和20
#8．查询性别为女且年龄小于25岁的员工信息
select  * from emp where gender = '女' and age <25;
#9．查询年龄等于18或20或40的员工信息
select  * from emp where age = 18 or age = 20 or age = 40;
select  * from emp where age in (18,20,40);
#10．查询姓名为两个字的员工信息
select  * from emp where name like '__';#加三个——就是三个字
#11. 身份证号最后一位X
select * from emp where idcard like '%X';
select * from emp where idcard like '_________________X';
/*条件查询*/

#聚合函数
#1．统计该企业员工数量
select count(*) from emp;
select count(idcard) from emp;#null不参与聚合函数
#2．统计该企业员工的平均年龄
select avg(age) from emp;
#3．统计该企业员工的最大年龄
select  max(age) from emp;
#4．统计该企业员工的最小年龄
select  min(age) from emp;
#5.统计西安地区年龄之和
select  sum(age) from emp where workaddress = '西安';
#聚合函数

#分组查询
#1．根据性别分组，统计男性员工和女性员工的数量
select count(*) from emp group by gender;#出来的数量不区分男女
select gender, count(*) from emp group by gender;#区分男女
#2．根据性别分组，统计男性员工和女性员工的平均年龄
select gender, avg(age) from emp group by gender;
#3．查询年龄小于45的员工，并根据工作地址分组，获取员工数量大于等于3的工作地址
select count(*) from emp where age < 45 group by workaddress;
select workaddress, count(*) from emp where age < 45 group by workaddress;
select workaddress, count(*) from emp where age < 45 group by workaddress having count(*) >= 3;
select workaddress, count(*) address_count from emp where age < 45 group by workaddress having address_count >= 3;
#执行顺序:where》聚合函数》having

#排序查询
#1．根据年龄对公司的员工进行升序排序
select  * from emp order by age asc;#asc可省略
select  * from emp order by age desc;
#2．根据入职时间，对员工进行降序排序
select  * from emp order by entrydate desc;
#3．根据年龄对公司的员工进行升序排序，年龄相同，再按照入职时间进行降序排序
select  * from emp order by age asc, entrydate desc;

#分页查询
#1．查询第1页员工数据，每页展示10条记录
select * from emp limit 0,10;#索引从0开始
select * from emp limit 10;#索引从0开始可省略
#2．查询第2页员工数据，每页展示10条记录  ##计算索引：（页码-1）*页展示记录数
select * from emp limit 10,10;

#DQL练习案例
#1．查询年龄为20,21,22,23岁的员工信息。
select * from emp where gender = '女' and age in (20,22,23);
#2．查询性别为男，并且年龄在20-40岁(含)以内的姓名为三个字的员工。
select  * from emp where gender = '男' and age between 20 and 40 and name like '___';
#3．统计员工表中,年龄小于60岁的，男性员工和女性员工的人数。
select  * from emp group by gender;
select  count(*) from emp group by gender;
select  count(*) from emp where age < 60 group by gender;#筛选之后再分组
select  gender , count(*) from emp where age < 60 group by gender;#筛选之后再分组
#4.查询所有年龄小于等于35岁员工的姓名和年龄，并对查询结果按年龄升序排序，如果年龄相同按入职时间降序排序。
select name, age from emp where age <= 35 order by age asc , entrydate desc;
#5.查询性别为男，且年龄在20-40岁(含)以内的前5个员工信息，对查询的结果按年龄升序排序，年龄相同按入职时间升序排序。
#前五个员工信息就是分页展示五条信息，limit要在order by指令之后，放在最后
select  * from emp where gender = '男' and age between  20 and 40 order by  age asc, entrydate asc limit 5 ;

#执行顺序：查询年龄大于15的员工的姓名、年龄,[并根据年龄进行升序排序
select name , age from emp where age > 15 order by age asc;
#emp指定别名e
select name , age from emp e where e.age > 15 order by age asc;
#select执行在from之后
select e.name,e.age from emp e where e.age > 15 order by age asc;
#where要在select之前执行，因此一下句子会报错
#select e.name ename,e.age eage from emp e where eage > 15 order by age asc;
#order by是在select之后执行的，因此下面句子不会报错
select e.name ename,e.age eage from emp e where e.age > 15 order by eage asc;


update emp set idcard = null where id = 16;

drop table emp;

alter table emp change  worknumber workno varchar(10);

insert into emp (id, worknumber, name, gender, age, idcard, workaddress, entrydate)
    values (1,'1','柳岩', '女', 20,   '123456789012345678', '北京', '2000-01-01'),
           (2,'2','张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01'),
           (3,'3','韦一笑', '男', 26, '123455589012345670', '上海', '2010-01-01'),
           (4,'4','赵敏', '女', 28,   '123450989012345678', '北京', '2009-01-01'),
           (5,'5','小昭', '女', 30,   '123456789012345678', '上海', '2007-01-01'),
           (6,'6','杨逍', '男', 28,   '12345678931234567X', '北京', '2006-01-01'),
           (7,'7','范瑶', '男', 40,   '123456789212345670', '北京', '2005-01-01'),
           (8,'8','黛绮丝', '女', 38, '123415769012345678', '天津', '2015-01-01'),
           (9,'9','范凉凉', '女', 45, '123456789790345678', '北京', '2010-01-01'),
           (10,'10','陈友谅', '男', 53,'123456789012345670', '上海', '2011-01-01'),
           (11,'11','张士诚', '男', 88,'123567897123465670', '江苏', '2015-05-01'),
           (12,'12','常遇春', '男', 32,'123446757152345670', '北京', '2004-02-01'),
           (13,'13','张三丰', '男', 88,'123656789012345678', '江苏', '2004-02-01'),
           (14,'14','灭绝', '女', 65,  '123456719012345670', '西安', '2019-05-01'),
           (15,'15','胡青牛', '男', 65, '12345674971234567X', '西安', '2019-05-01'),
           (16,'16','周芷若', '女', 18, 'null', '北京', '2012-06-01');
#字符串函数
select  concat('Hello' , 'mysql');

select  lower('HELLO');#upper

select lpad('01',5,'-');#rlad

select trim('  Hello  MySQL  ');

select substring('Hello MySQL',1,5);#从第一个字符开始截取5个

#根据需求完成以下SQL编写
#1.由于业务需求变更，企业员工的工号，统一为5位数，目前不足5位数的全部在前面补0。比如:1号员工的工号应该为000012
update emp set workno = lpad(workno,5,'0');


#数值函数
select ceil(1.1);#floor mod rand
select rand();
select round(2.343,2);

#通过数据库函数生成六位数的随机验证码
select round(rand()*1000000,0);#因为rand是0-1，因此会出现五位的情况
select lpad(round(rand()*1000000,0),6,0);

select curdate();
select curtime();
select now();
select year(now());
select month(now());
select day(now());

#求当前时间后退70天之后的日期
select date_add(now(),INTERVAL 70 DAY);#year month
select date_add(now(),interval 70 day);

select datediff('2021-12-01','2032-10-9');

#查询所有员工入职天数，倒序排列
select name,datediff(curdate(),entrydate) from emp;

select name,datediff(curdate(),entrydate) as entrydays from emp order by entrydays desc;

#流程控制函数
select if(false,'OK','Error');#返回error
select ifnull('OK','Default');#返回OK
select ifnull('','Default');#返回空格
select ifnull(null,'Default');#返回default
#case when then else end
#需求需求:查询emp表的员工姓名和工作地址〔北京/上海---->一线城市，其他―--->二线城市)
select name, workaddress from emp;
select name,
       case workaddress when '北京' then '一线城市' when '上海' then '一线城市' else '二线城市' end
from emp;
select name,
       (case workaddress when '北京' then '一线城市' when '上海' then '一线城市' else '二线城市' end) as '工作地址'
from emp;

#练习根据需求完成以下SQL编写  统计班级各个学员的成绩，展示的规则如下:>=85,展示优秀;>=60，展示及格.否则，展示不及格
create table score(
	id int comment 'ID',
	name varchar(20) comment '姓名',
	math int comment '数学',
	english int comment '英语',
	chinese int comment '语文'
) comment '学员成绩表';

show create table score;

insert into score(id, name, math, english, chinese) VALUES (1,'Tom',67,88,95), (2,'Rose',23,66,90), (3,'Jack',56,98,76);

select distinct id from score;

drop table if exists score;

#练习根据需求完成以下SQL编写  统计班级各个学员的成绩，展示的规则如下:>=85,展示优秀;>=60，展示及格.否则，展示不及格

select
    id,
    name,
    (case when math >= 85 then '优秀' when math >= 60 then '及格' else '不及格' end) '数学',
    (case when english >= 85 then '优秀' when math >= 60 then '及格' else '不及格' end) '英语',
    (case when chinese >= 85 then '优秀' when math >= 60 then '及格' else '不及格' end) '语文'
from score;

select
    id,
    name,
    (case when math >= 85 then '优秀' when math < 60 then '不及格' else '及格' end) '数学',
    (case when english >= 85 then '优秀' when math < 60 then '不及格' else '及格' end) '英语',
    (case when chinese >= 85 then '优秀' when math < 60 then '不及格' else '及格' end) '语文'
from score;

#创建用户itcast，只能够在当前主机localhost访间，密码123456;
create user 'itcast'@'localhost' identified by '123456';
#创建用户 heima，可以在任意主机访间该数据库，密码123456 ;
create user 'heima'@'%' identified by '123456';
#修改用户 heima的访间密码为1234 ;
alter user 'heima'@'%' identified  with mysql_native_password by '1234';
#删除itcast@localhost用户
drop user 'itcast'@'localhost';
#主机名可使用％通配符

#查询权限
show grants  for 'heima'@'%';
#授予权限
grant all on itcast.* to 'heima'@'%';
#撤销权限
revoke all on itcast.* from 'heima'@'%';
##·多个权限之间，使用逗号分隔;·授权时，数据库名和表名可以使用*进行通配，代表所有。

create user 'it'@'%' identified by '12';
create user 'it'@'localhost' identified by '12';

#基础约束 根据需求完成表结构的创建
create table user(
	id int primary key auto_increment comment '主键',
	name varchar(10) not null unique comment '姓名',
	age int check ( age > 0 && age <= 120 ) comment '年龄',
	status char(1) default '1' comment '状态',
	gender char(1) comment '性别'
) comment '用户表';

show create table user;

#因为id自动增长
insert into user (name,age,status,gender) values ('Tom1',19,'1','男'), ('Tom2',25,'0','男');
#验证id自增操作
insert into user (name, age,status,gender) values ('Tom3',19,'1','男');
#姓名不能为空，下面出现报错，但是主键会更新，但实际并不会
#insert into user (name, age,status,gender) values (null,80,'1','男');
insert into user (name, age,status,gender) values ('Tom4',80,'1','男');
#status是默认值，不传递也会显示为1
insert into user (name, age,gender) values ('Tom5',120,'男');



#外键约束案例之联系两个表
##准备数据阶段
create table dept(
    id int auto_increment comment 'ID' primary key ,
    name varchar(50) not null comment '部门名称'
)comment '部门表';
insert into dept(id, name) VALUES (1,'研发部'),(2,'市场部'),(3,'财务部'),(4,'销售部'),(5,'总经办');

create table emp(
    id int auto_increment comment 'ID' primary key ,
    name varchar(50) not null comment '姓名',
    age int comment '年龄',
    job varchar(20) comment '职位',
    salary int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id int comment '部门ID'
)comment '员工表';

drop table emp;

insert into emp values
    (1,'金庸',66,'总裁',20000,'2000-01-01',null,5),
    (2,'张无忌',20,'项目经理',12500,'2005-12-05',1,1),
    (3,'杨逍',33,'开发',8400,'2000-11-03',2,1),
    (4,'韦一笑',48,'开发',11000,'2002-02-05',2,1),
    (5,'常遇春',43,'开发',10500,'2004-07-09',3,1),
    (6,'小昭',19,'程序员鼓励师',6600,'2004-10-12',2,1),
    (7,'灭绝',60,'财务总监',8500,'2002-09-12',1,3),
    (8,'周芷若',19,'会计',4800,'2006-06-02',7,3),
    (9,'丁敏君',23,'出纳',5250,'2009-05-12',7,3),
    (10,'赵敏',20,'市场部总监',12500,'2002-02-05',1,2),
    (11,'鹿杖客',56,'职员',3750,'2006-12-05',10,2),
    (12,'鹤笔翁',19,'职员',3750,'2006-05-25',10,2),
    (13,'方东白',19,'职员',5500,'2002-11-05',10,2),
    (14,'张三丰',88,'销售总监',14000,'2003-06-15',1,4),
    (15,'俞莲舟',38,'销售',4600,'2003-07-05',14,4),
    (16,'宋远桥',40,'销售',4600,'2004-09-18',14,4),
    (17,'陈友谅',42,null,2000,'2011-10-12',1,null);

insert into emp values
    (1,'金庸',66,'总裁',20000,'2000-01-01',null,5),
    (2,'张无忌',20,'项目经理',12500,'2005-12-05',1,1),
    (3,'杨逍',33,'开发',8400,'2000-11-03',2,1),
    (4,'韦一笑',48,'开发',11000,'2002-02-05',2,1),
    (5,'常遇春',43,'开发',10500,'2004-07-09',3,1),
    (6,'小昭',19,'程序员鼓励师',6600,'2004-10-12',2,1);

##添加外届约束阶段
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id);
#此处执行后dept表中的数据就不可删除了，因为他是从表

#删除外键
alter table  emp drop foreign key fk_emp_dept_id;

#外键的删除和更新行为
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id) on update cascade on delete cascade ;
#以上语句代表 当在父表中删除/更新对应记录时，首先检查该记录是否有对应外键，如果有，则也删除/更新外键在子表中的记录。

alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id) on update set null on delete set null ;
#以上语句表示置null


###4.8第五章多表查询
###多对多
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

###一对一
create table tb_user(
    id int auto_increment  primary key comment '主键ID',
    name varchar(10) comment '姓名',
    age int comment '年龄',
    gender char(1) comment '1: 男, 2: 女',
    phone char(11) comment '手机号'
)comment '用户基本信息表';

create table tb_user_edu(
    id int auto_increment  primary key comment '主键ID',
    degree varchar(20) comment '学历',
    major varchar(50) comment '专业',
    primaryschool varchar(50) comment '小学',
    middleschool varchar(50) comment '中学',
    university varchar(50) comment '大学',
    userid int unique comment '用户ID',#唯一的
    constraint  fk_userid foreign key (userid) references  tb_user(id)
)comment '用户教育信息表';

insert into tb_user(id, name, age, gender, phone) values
    (null,'黄渤',45,'1','18800001111'),(null,'冰冰',35,'2','18800002222'),(null,'码云',55,'1','18800008888'),(null,'李彦宏',50,'1','18800009999');

insert into tb_user_edu(id, degree, major, primaryschool, middleschool, university, userid) VALUES
    (null,'本科','舞蹈','静安区第一小学','静安区第一中学','北京舞蹈学院',1),(null,'硕士','表演','朝阳区第一小学','朝阳区第一中学','北京电影学院',2),
    (null,'本科','英语','杭州市第一小学','杭州市第一中学','杭州师范大学',3),(null,'本科','应用数学','阳泉区第一小学','阳泉区第一中学','清华大学',4);

create table emp(
    id int auto_increment comment 'ID' primary key ,
    name varchar(50) not null comment '姓名',
    age int comment '年龄',
    job varchar(20) comment '职位',
    salary int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id int comment '部门ID'
)comment '员工表';

###多表查询
use itcast;

drop table tb_user

drop table emp;
create table emp(
    id int auto_increment comment 'ID' primary key ,
    name varchar(50) not null comment '姓名',
    age int comment '年龄',
    job varchar(20) comment '职位',
    salary int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id int comment '部门ID'
)comment '员工表';
insert into emp values
    (1,'金庸',66,'总裁',20000,'2000-01-01',null,5),
    (2,'张无忌',20,'项目经理',12500,'2005-12-05',1,1),
    (3,'杨逍',33,'开发',8400,'2000-11-03',2,1),
    (4,'韦一笑',48,'开发',11000,'2002-02-05',2,1),
    (5,'常遇春',43,'开发',10500,'2004-07-09',3,1),
    (6,'小昭',19,'程序员鼓励师',6600,'2004-10-12',2,1),
    (7,'灭绝',60,'财务总监',8500,'2002-09-12',1,3),
    (8,'周芷若',19,'会计',4800,'2006-06-02',7,3),
    (9,'丁敏君',23,'出纳',5250,'2009-05-12',7,3),
    (10,'赵敏',20,'市场部总监',12500,'2002-02-05',1,2),
    (11,'鹿杖客',56,'职员',3750,'2006-12-05',10,2),
    (12,'鹤笔翁',19,'职员',3750,'2006-05-25',10,2),
    (13,'方东白',19,'职员',5500,'2002-11-05',10,2),
    (14,'张三丰',88,'销售总监',14000,'2003-06-15',1,4),
    (15,'俞莲舟',38,'销售',4600,'2003-07-05',14,4),
    (16,'宋远桥',40,'销售',4600,'2004-09-18',14,4),
    (17,'陈友谅',42,null,2000,'2011-10-12',1,null);

create table salgrade(
    grade int,
    losal int,
    hisal int
)comment '薪资等级表';

insert into salgrade values (1,0,3000);
insert into salgrade values (2,3001,5000);
insert into salgrade values (3,5001,8000);
insert into salgrade values (4,8001,10000);
insert into salgrade values (5,10001,15000);
insert into salgrade values (6,15001,20000);
insert into salgrade values (7,20001,25000);
insert into salgrade values (8,25001,30000);

###多表查询
select *from emp;##单表查询
select * from emp,dept;##多表查询会出现17✖6=102个数据
##以上称为笛卡尔乘积情况（实际是排列组合）
##下一步消除掉无效的笛卡尔积，因为两张表是通过DEPT_ID联系起来的，所以让两者相等即可
select * from emp,dept where emp.dept_id = dept.id;##会出现16条记录，因为有一条是null

#内链接演示
#1.查询每个员工的姓名以及相关部门的名称（隐式连接实现）
#分析：表结构： emp dept
      #链接条件：emp.dept_id=dept.id
select * from emp,dept where emp.dept_id = dept.id;
select emp.name ,dept.name from emp,dept where emp.dept_id = dept.id;

#起别名
select e.name, d.name from emp e, dept d where e.dept_id = d.id;

#内链接演示
#2.查询每个员工的姓名以及相关部门的名称（显式连接实现）
#分析：表结构： emp dept
      #链接条件：emp.dept_id=dept.id
select e.name,d.name from emp e inner join dept d on e.dept_id = d.id;##inner可省略

#外连接演示
#1.查询emp所有数据和对应部门的信息（左外连接）
#分析：表结构： emp dept
      #链接条件：emp.dept_id=dept.id
select  e.* from emp e left outer join dept d on e.dept_id = d.id;
select  *,d.name from emp e left outer join dept d on e.dept_id = d.id;##会查出17个，因为第十七个在emp表中有
#2.查询emp所有数据和对应部门的信息（右外连接）
select  d.*, e.* from emp e right outer join dept d on e.dept_id = d.id;
#右也可以改为左
select  d.*, e.* from dept d left outer join emp e on e.dept_id = d.id;

##自连接
#查询员工及其所属领导的名字
#分析：表结构：emp（链接其两次）因为领导也是员工
select a.name, b.name from emp a ,emp b where a.managerid = b.id;
#2.查询所有员工emp及其领导的名字emp，如果员工没有领导也要查询出来
select  a.name '员工', b.name '领导' from emp a left join emp b on a.managerid = b.id;

##联合查询 union all, union
#1.将薪资低于5000的员工和年龄大于50的员工全部查询出来；
select * from emp where  salary < 5000
union all
select * from emp where  age > 50;
##以上会出现两次的路张可因为他两个都满足
select * from emp where  salary < 5000
union
select * from emp where  age > 50;
##union all直接合并，union合并后去重
##联合查询的多张列表数据必须一致，列数必须一致，字段类型也必须一致

###子查询
##标量子查询
#1.查询销售部的所有员工信息
#步骤：a.查询销售部门id
select id from dept where name = '销售部';
# #b.根据销售部门id查询员工信息
select * from emp where dept_id = 4;

select * from emp where dept_id = (select id from dept where name = '销售部');##因为括号里就一个数值 4

##2.查询在’东方白‘入职之后的员工信息
#步骤：a查询东方白的信息
select entrydate from emp where name = '方东白';
# #b查询指定日期之后的员工信息
select * from emp where entrydate > '2002-11-05';

select * from emp where entrydate > (select entrydate from emp where name = '方东白');

##列子查询
##1.查询销售部和市场部的所有员工信息
##a查询销售部们和市场部门的id
select id from dept where name='销售部' or name='市场部' ;
##b根据部门id查询员工信息
select *from emp where dept_id in (2,4);
select *from emp where dept_id in (select id from dept where name='销售部' or name='市场部');
##2.查询比财务部所有人工资都高得员工信息
##a查询所有财务部工资
select id from dept where name='财务部';
select salary from emp where dept_id = 3;
select salary from emp where dept_id = (select id from dept where name='财务部');
##b查询比最高工资更高的工资
select * from emp where salary > all (select salary from emp where dept_id = (select id from dept where name='财务部')) ;

###3.查询比研发部任意一人工资高的员工信息
select salary from emp where dept_id = (select id from dept where name='研发部');

select * from emp where salary > any (select salary from emp where dept_id = (select id from dept where name='研发部'));
##此时的any可换为some

###行子查询
##查询与张无忌薪资及直属领导相同的员工信息
##a。查询张无忌以及直属领导
select salary, managerid from emp where name = '张无忌';
##查询与张无忌薪资及直属领导相同的员工信息
select * from emp where salary = 12500 and managerid = 1;

select * from emp where (salary , managerid) = (12500,1);
select * from emp where (salary , managerid) = (select salary, managerid from emp where name = '张无忌');

###表子查询
##1.查询与路张可和宋远桥的职位和薪资相同的员工
##a查询两个人的薪资和职位
select job , salary from emp where name = '鹿杖客' or  name = '宋远桥';
##b查询相同
select * from emp where (job,salary) in (select job , salary from emp where name = '鹿杖客' or  name = '宋远桥');

###2.查询入职日期是2006-01-01之后的员工信息及其部门信息
##a。先找出入职期是这之后的员工
select * from emp where entrydate > '2006-01-01';
##b，查询这部分员工对应的部门信息
select e.name, d.name from (select * from emp where entrydate > '2006-01-01') e left join dept d on e.dept_id=d.id;

###练习内容
#1.查询员工的姓名、年龄、职位、部门信息。
select e.name,e.age,e.job,d.name from emp e ,dept d where e.dept_id=d.id;
#2．查询年龄小于30岁的员工姓名、年龄、职位、部门信息。
select e.name,e.age,e.job,d.name from emp e inner join dept d on e.dept_id = d.id where age < 30;
#3．查询拥有员工的部门ID、部门名称。(人事部没有员工，实际就是求交集 内连接)
select d.id,d.name from emp e,dept d where e.dept_id = d.id;
select distinct d.id,d.name from emp e,dept d where e.dept_id = d.id;##使用distinct去除重复
#4．查询所有年龄大于40岁的员工，及其归属的部门名称;如果员工没有分配部门,也需要展示出来。
select  e.*, d.name from emp e left outer join dept d on e.dept_id = d.id where  e.age > 40;
#5．查询所有员工的工资等级。
##连接条件 薪资大于最低小于最高 e.salary >= s.losal and e.salary <= s.hisal
select e.*, s.grade,s.hisal,s.losal from emp e ,salgrade s where e.salary >= s.losal and e.salary <= s.hisal;

select e.*, s.grade,s.hisal,s.losal from emp e ,salgrade s where e.salary between s.losal and s.hisal;#(写法二)

#6．查询"研发部"所有员工的信息及工资等级。
##比第五个多了一个条件，根据名称去查
##涉及到的表结构：三个都有
##链接条件：1.e.salary >= s.losal and e.salary <= s.hisal（或者e.salary between s.losal and s.hisal;）2.e.dept_id= dept.id
##查询条件：dept.name='研发部'
select e.*, s.grade from emp e,dept d, salgrade s where e.dept_id = d.id and (e.salary between s.losal and s.hisal) and d.name = '研发部';

select e.*, s.grade
from emp e,
     dept d,
     salgrade s
where e.dept_id = d.id
  and (e.salary between s.losal and s.hisal)
  and d.name = '研发部';
#7.查询"研发部"员工的平均工资。
select avg(e.salary) from emp e,dept d where e.dept_id=d.id and d.name= '研发部';
#8．查询工资比"灭绝"高的员工信息。
select  salary from emp where name = '灭绝';
select  * from emp where salary > (select  salary from emp where name = '灭绝');
#9.查询比平均薪资高的员工信息。
select  * from emp where salary > (select avg(salary) from emp);
#10.查询低于本部门平均工资的员工信息。
##算法步骤a查询每个部门的平均薪资
select avg(e1.salary) from emp e1 where e1.dept_id = 1;
select avg(e1.salary) from emp e1 where e1.dept_id = 2;#--------

#select * from emp where salary < (select avg(e1.salary) from emp e1 where e1.dept_id = 1)
select *,(select avg(e1.salary) from emp e1 where e1.dept_id = e2.dept_id) '平均' from emp e2 where e2.salary < (select avg(e1.salary) from emp e1 where e1.dept_id = e2.dept_id);

#11.查询所有的部门信息,并统计部门的员工人数。
select id,name from dept;
select id, name,id '人数' from dept;
select count(*) from emp where dept_id = 1;

select d.id,d.name, (select count(*) from emp e where e.dept_id = d.id) '人数' from dept d;

#12.查询所有学生的选课情况,展示出学生名称,学号,课程名称
#表：student course student-course
#链接条件student.id = student_course.studentid,course.id = student_course.courseid
select s.name,s.no,c.name from student s,student_course sc,course c where s.id = sc.studentid and sc.courseid = c.id;

###4.9事务
create table account(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    money int comment '余额'
)comment '账户表';

insert into account(id, name, money) VALUES (null ,'张三',2000),(null,'李四',2000);

update account set money = 2000 where name = '张三' or name = '李四';

###4.9事务
select @@autocommit;##此时autocommit显示值为1

set @@autocommit = 0;##将事务设置为手动提交 此时再执行select ##auto会显示值为0

-----方式一：手动提交
##转账操作-正常流程（张三给李四转账1000）
-- 1. 查询张三账户余额
select  * from account where name = '张三';
-- 2. 给张三余额-1000
update  account set money = money-1000 where name = '张三';
-- 3. 给李四账户余额+1000
update  account set money = money + 1000 where name = '李四';

select  * from account where name = '张三' or name = '李四';

-- 提交事务
commit ;###运行commit命令后数据才会更新

##转账操作-异常流程（张三给李四转账1000）
-- 1. 查询张三账户余额
select  * from account where name = '张三';
-- 2. 给张三余额-1000
update  account set money = money-1000 where name = '张三';
程序执行报错
-- 3. 给李四账户余额+1000
update  account set money = money + 1000 where name = '李四';

select  * from account where name = '张三' or name = '李四';

-- 提交事务
commit ;###运行commit命令后数据才会更新
-- 回滚事务（程序执行报错后，可保证数据的完整性和正确性）
rollback ;

--------方式二 自动提交：
set @@autocommit = 1;##将事务设置为自动提交 此时再执行select ##auto会显示值为0
select @@autocommit;##此时autocommit显示值为1

---- 开启事务
start transaction ;#开启事务

---- 1. 查询张三账户余额
select  * from account where name = '张三';
-- 2. 给张三余额-1000
update  account set money = money-1000 where name = '张三';
程序执行报错
-- 3. 给李四账户余额+1000
update  account set money = money + 1000 where name = '李四';

------ 提交事务
commit ;
----- 回滚事务
rollback ;

------ 事务的四大特性
--- 1.原子性 2.一致性 3.隔离性 4.持久性
----- 并发事务问题
--- 1.脏读 2. 不可重复读 3. 幻读

----- 查看事务隔离级别
select @@transaction_isolation;#默认REPEATABLE-READ

------- 设置事务的隔离级别
set session transaction isolation level read uncommitted;###session 针对当前会话

set session transaction isolation level repeatable read ;


####------------------基础部分已完结