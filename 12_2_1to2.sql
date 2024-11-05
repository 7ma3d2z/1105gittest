-- 部署テーブルの作成
CREATE TABLE dept (
    deptno      char(2)     primary key,
    deptname    varchar(40) unique not null,
)

-- 役職テーブルの作成
create table pos(
    poscode     char(1)     primary key,
    posname     varchar(20) unique not null,
)

-- 社員テーブルの作成
create table emp(
    empno       char(5)    primary key, 
    empname     varchar(40) not null,
    poscode     char(1)     not null references pos(poscode),
    age         integer     check(age >= 0)
)

-- 部員テーブルの作成
create table member (
    deptno      char(2)     not null references dept(deptno),
    empno       char(5)     not null references emp(empno), primary key(deptno, empno)
)