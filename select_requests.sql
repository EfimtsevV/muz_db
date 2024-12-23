
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

select name_track 
from track;

--Название треков, которые содержат слово «мой» или «my».
--Основной способ реализации на основе полученных знаний, который вы подсказали у меня полностью реализовать не получилось, нашел другой способ

select name_track
from track 
where name_track ilike '%мой %' 
or name_track ilike '% мой %' 
or name_track ilike '% мой%'
or name_track ilike 'мой'
or name_track ilike '%my %' 
or name_track ilike '% my%'
or name_track ilike '% my %'
or name_track ilike 'my';


--Второй способ(рабочий)

SELECT name_track
FROM track
WHERE name_track ~* '\mмой\M'
   OR name_track ~* '\mmy\M';

--select запросы (задание 3)

--Количество исполнителей в каждом жанре.
select  genre.name_genre, count(genre_executor.id_executor) AS executor_count
from genre 
left join genre_executor ON genre.id_genre = genre_executor.id_genre
left join Executor  ON genre_executor.id_executor = executor.id_executor
group by genre.name_genre;

--Количество треков, вошедших в альбомы 2019–2020 годов.
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
--Согласно условию, в выборку не должны попасть исполнители, у которых есть альбомы, выпущенные в 20-м году.
--Т.е. если у исполнителя, например, есть два альбома, один из которых выпущен в 20-м году, а другой в любом другом, то такой исполнитель не должен попасть в выборку.
--Данный запрос реализуется через вложенный запрос, где получаем исполнителей, которые выпустили альбомы в 20-м году, а потом выводим тех, кто не попадает в этот список.

select  distinct e.name_executor 
from executor e
left join executor_album ea ON e.id_executor = ea.id_executor
left join album a ON a.id_album = ea.id_album AND a.year_release = 2020
group by e.name_executor
HAVING  COUNT(a.id_album) = 0;

--Названия сборников, в которых присутствует конкретный исполнитель (Баста).
select distinct c.id_collection, c.name_collection
from collection c
join collection_track ct on c.id_collection = ct.id_collection
join track t on ct.id_track = t.id_track
join executor_album ea on t.id_album = ea.id_album
join Executor e on ea.id_executor = e.id_executor
where e.name_executor = 'Баста'
order by c.id_collection;

--select запросы (4 задание)

--Названия альбомов, в которых присутствуют исполнители более чем одного жанра. 
select a.name_album
from album a 
join executor_album ea on a.id_album = ea.id_album 
join genre_executor ge on ea.id_executor = ge.id_executor 
group by a.id_album, a.name_album, ea.id_executor
having count(distinct ge.id_genre) > 1;


--Наименования треков, которые не входят в сборники.
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
