--INSERT запросы (задание 1)

insert into executor(name_executor)
values('Баста'),('AK-47'),('Комбинация'),('КИНО'),('Скриптонит'),('test');

--select * from executor;

insert into genre(name_genre)
values('Rap'),('Pop'),('Rock');

--select * from genre; 

insert into album(name_album, year_release)
values('Баста 3', 2010),('Мегаpolice',2010),('Московская прописка', 2004),('45', 2018),('Группа крови', 1988), ('Баста+', 2013),('2004',2020), ('test',2025);

--select * from album;

insert into track(name_track, length, id_album)
values('Урбан','00:04:12',1),
('Оля Лукина', '00:03:19',2),
('Бухгалтер','00:04:13',3),
('Спокойная ночь','00:06:12',5),
('Солнца не видно','00:04:58',1),
('Московская прописка','00:03:39',3),
('Восьмиклассница','00:02:45',4),
('Москва любит...', '00:03:25', 7),
('Ты это серьезно?', '00:03:17',7),
('Бездельник №1','00:03:14', 4),
('Мой стиль','00:04:15', 6),
('my own','00:01:01',8),
('own my', '00:02:02',8),
('my','00:03:03',8),
('myself','00:02:03',8),
('by myself', '00:02:04',8),
('myself by', '00:02:03',8),
('by myself by', '00:02:01',8),
('beemy', '00:02:05',8),
('premyne', '00:02:07',8);

--select * from track;

insert into collection(name_collection, year_release)
values('Легендарные песни',2004),
('Хиты Баста', 2016),
('Вокал Треп, том 1', 2011),
('Легенда', 2018);

--select *from collection;

insert into genre_executor(id_genre, id_executor)
values(1, 1),(1, 2),(1,5),(1,6),(2, 3),(3, 4),(3,1);

insert into executor_album(id_executor, id_album)
values(1,1),(2,2),(3,3),(4,4),(4,5),(5,7),(6,8);

insert into collection_track(id_collection,id_track)
values (1,3),(1,6),(2,1),(3,2),(4,4),(4,7), (2,5),(3,1),(3,5);
