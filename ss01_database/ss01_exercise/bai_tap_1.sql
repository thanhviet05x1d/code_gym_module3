create database exercise_1;

use exercise_1;

create table classroom(
 `id` int auto_increment primary key,
 `name` varchar(50)
);

create table teacher(
 `id` int auto_increment primary key,
 `name` varchar(50),
 `age` int, 
 `country` varchar(50)
);