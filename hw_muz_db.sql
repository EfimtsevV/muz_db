--БД для музыкального магазина

create table if not exists Genre(
id_genre SERIAL primary key,
name_genre varchar(20) not null
);

create table if not exists Executor(
id_executor SERIAL primary key,
name_executor varchar(20) not null
);

create table if not exists Album(
id_album SERIAL primary key,
name_album varchar(30) not null,
year_release integer not null
);

create table if not exists Collection(
id_collection SERIAL primary key,
name_collection varchar(20) not null,
year_release integer not null
);

create table if not exists Track(
id_track SERIAL primary key,
name_track varchar(30) not null,
length time not null,
id_album integer not null references Album(id_album)
);

create table if not exists genre_executor(
id_genre_executor SERIAL primary key,
id_genre integer not null references Genre(id_genre),
id_executor integer not null references Executor(id_executor)
);

create table if not exists executor_album(
id_executor_album SERIAL primary key,
id_executor integer not null references Executor(id_executor),
id_album integer not null references Album(id_album)
);

create table if not exists collection_track(
id_collection_track SERIAL primary key,
id_collection integer not null references Collection(id_collection),
id_track integer not null references Track(id_track)
);


--INSERT запросы (задание 1)

insert into executor(name_executor)
values('Баста'),('AK-47'),('Комбинация'),('КИНО');

select * from executor;

insert into genre(name_genre)
values('Rap'),('Pop'),('Rock');

select * from genre; 

insert into album(name_album, year_release)
values('Баста 3', 2010),('Мегаpolice',2010),('Московская прописка', 2004),('45', 2018),('Группа крови', 1988);

select * from album;

insert into track(name_track, length, id_album)
values('Урбан','00:04:12',1),
('Оля Лукина', '00:03:19',2),
('Бухгалтер','00:04:13',3),
('Спокойная ночь','00:06:12',5),
('Солнца не видно','00:04:58',1),
('Московская прописка','00:03:39',3),
('Восьмиклассница','00:02:45',4);

select * from track;

insert into collection(name_collection, year_release)
values('Легендарные песни',2004),
('Хиты Баста', 2016),
('Вокал Треп, том 1', 2011),
('Легенда', 2018);

select *from collection;

insert into genre_executor(id_genre, id_executor)
values(1, 1), (1, 2), (2, 3), (3, 4),(3,1);

insert into executor_album(id_executor, id_album)
values(1,1),(2,2),(3,3),(4,4),(4,5);

insert into collection_track(id_collection,id_track)
values (1,3),(1,6),(2,1),(3,2),(4,4),(4,7), (2,5);


--select запросы (задание 2)

--Название и продолжительность самого длинного трека
select name_track, length
from track
order by length desc
limit 1;

--Название треков, продолжительность которых не менее 3,5 минут.
select name_track
from track 
where length >= '00:03:30';

--Названия сборников, вышедших в период с 2018 по 2020 год включительно
select name_collection
from collection
where collection.year_release between 2018 and 2020;

--Исполнители, чьё имя состоит из одного слова
select name_executor
from executor
where name_executor not like '% %' and name_executor not like '%-%';

--Название треков, которые содержат слово «мой» или «my».

insert into album(name_album, year_release)
values('Баста+', 2013);

insert into track(name_track, length, id_album)
values('Мой стиль','00:04:15', 6);

select name_track
from track 
where name_track like '%Мой%' or name_track like '%My%' or name_track like '%мой%' or name_track like '%my%';

--select запросы (задание 3)

--Количество исполнителей в каждом жанре.
select  genre.name_genre, count(genre_executor.id_executor) AS executor_count
from genre 
left join genre_executor ON genre.id_genre = genre_executor.id_genre
left join Executor  ON genre_executor.id_executor = executor.id_executor
group by genre.name_genre;

--Количество треков, вошедших в альбомы 2019–2020 годов.

insert into executor(id_executor, name_executor)
values(5, 'Скриптонит')

insert into genre_executor(id_genre, id_executor)
values(1,5)

insert into album(name_album, year_release)
values('2004',2020)



insert into track(name_track, length, id_album)
values('Москва любит...', '00:03:25', 7),
('Ты это серьезно?', '00:03:17',7);



select count(t.id_track) as track_count
from album a
join track t on a.id_album = t.id_album
where a.year_release between 2019 and 2020;


--Средняя продолжительность треков по каждому альбому.
select a.id_album, a.name_album, AVG(t.length) AS avg_length
from album a
join track t on a.id_album = t.id_album
group by a.id_album, a.name_album
order by avg_length desc;

--Все исполнители, которые не выпустили альбомы в 2020 году.

insert into executor_album(id_executor, id_album)
values(5,7);

SELECT  distinct e.name_executor 
FROM executor e
LEFT JOIN executor_album ea ON e.id_executor = ea.id_executor
LEFT JOIN album a ON a.id_album = ea.id_album AND a.year_release = 2020
WHERE a.id_album IS NULL;

--Названия сборников, в которых присутствует конкретный исполнитель (Баста).
insert into collection_track(id_collection,id_track)
values (3,1),(3,5);

select distinct c.id_collection, c.name_collection
from collection c
join collection_track ct on c.id_collection = ct.id_collection
join track t on ct.id_track = t.id_track
join executor_album ea on t.id_album = ea.id_album
join Executor e on ea.id_executor = e.id_executor
where e.name_executor = 'Баста'
order by c.id_collection;

--select запросы (4 задание)
--Названия альбомов, в которых присутствуют исполнители более чем одного жанра. Выводит альбомы Басты т.к он поет в двух жанрах.
insert into executor_album(id_executor, id_album)
values(1,6);

select a.name_album
from album a 
join executor_album ea on a.id_album = ea.id_album 
join genre_executor ge on ea.id_executor = ge.id_executor 
group by a.id_album, a.name_album 
having count(distinct ge.id_genre) > 1;

--Наименования треков, которые не входят в сборники.
insert into track(name_track, length, id_album)
values('Бездельник №1','00:03:14', 4);

select t.id_track, t.name_track
from track t
left join collection_track ct on t.id_track = ct.id_track
where ct.id_collection is null;


--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
select e.name_executor
from executor e
join executor_album ea on e.id_executor = ea.id_executor
join album a on ea.id_album = a.id_album
join track t on a.id_album = t.id_album
where t.length = (
    select min(length)
    from track
);

--Названия альбомов, содержащих наименьшее количество треков.
select a.id_album, a.name_album
from album a
join track t on a.id_album = t.id_album
group by  a.id_album, a.name_album
having count(t.id_track) = (
    select min(track_count)
    from (
        select count(id_track) as track_count
        from track
        group by id_album
    ) as track_counts
);
