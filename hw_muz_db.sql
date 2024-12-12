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