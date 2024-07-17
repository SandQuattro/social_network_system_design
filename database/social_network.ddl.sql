-- Создаем базы данных
CREATE DATABASE user_db;
CREATE DATABASE core_db;
CREATE DATABASE views_db;

\connect user_db;

-- Таблица users
CREATE TABLE "users"
(
    "id"         bigserial PRIMARY KEY,
    "username"   varchar(50) UNIQUE,
    "email"      varchar(100) UNIQUE,
    "password"   varchar(255),
    "created_at" timestamp
);

-- Таблица user_profiles
CREATE TABLE "user_profiles"
(
    "id"        bigserial PRIMARY KEY,
    "user_id"   bigint references "users" ("id"),
    "about"     text,
    "location"  varchar(100),
    "photo_url" varchar(255)
);

\connect core_db;

-- enum типа данных для media_type
CREATE TYPE media_type AS ENUM ('photo', 'image');

-- Таблица posts
CREATE TABLE "posts"
(
    "id"         bigserial PRIMARY KEY,
    "user_id"    bigint references "users" ("id"),
    "content"    text,
    "created_at" timestamp,
    "latitude"   float,
    "longitude"  float
);

-- Таблица media
CREATE TABLE "media"
(
    "id"         bigserial PRIMARY KEY,
    "post_id"    bigint references "posts" ("id"),
    "media_url"  varchar(255),
    "media_type" media_type
);

-- Таблица likes
CREATE TABLE "likes"
(
    "id"      bigserial PRIMARY KEY,
    "user_id" bigint references "users" ("id"),
    "post_id" bigint references "posts" ("id")
);

-- Таблица comments
CREATE TABLE "comments"
(
    "id"         bigserial PRIMARY KEY,
    "post_id"    bigint references "posts" ("id"),
    "user_id"    bigint references "users" ("id"),
    "reply_id"   bigint references comments (id),
    "content"    text,
    "created_at" timestamp

);

-- Таблица friends
CREATE TABLE "friends"
(
    "user_id"   bigint,
    "friend_id" bigint,
    primary key (user_id, friend_id),
    foreign key (user_id) references "users" ("id"),
    foreign key (friend_id) references "users" ("id")
);

-- Таблица messages
CREATE TABLE "messages"
(
    "id"          bigserial PRIMARY KEY,
    "sender_id"   bigint references "users" ("id"),
    "receiver_id" bigint references "users" ("id"),
    "content"     text,
    "is_read"     boolean default false,
    "created_at"  timestamp
);

\connect views_db;

-- Таблица views
CREATE TABLE "views"
(
    "id"        bigserial PRIMARY KEY,
    "user_id"   bigint references "users" ("id"),
    "post_id"   bigint references "posts" ("id"),
    "view_time" timestamp
);

COMMENT ON COLUMN user_profiles.user_id IS 'Foreign key referencing users.id';
COMMENT ON COLUMN posts.user_id IS 'Foreign key referencing user_db.users.id';
COMMENT ON COLUMN posts.latitude IS 'geo latitude';
COMMENT ON COLUMN posts.longitude IS 'geo longitude';
COMMENT ON COLUMN media.post_id IS 'Foreign key referencing posts.id';
COMMENT ON COLUMN media.media_type IS 'image, audio, etc.';
COMMENT ON COLUMN likes.user_id IS 'Foreign key referencing user_db.users.id';
COMMENT ON COLUMN likes.post_id IS 'Foreign key referencing posts.id';
COMMENT ON COLUMN comments.post_id IS 'Foreign key referencing post_db.posts.id';
COMMENT ON COLUMN comments.user_id IS 'Foreign key referencing user_db.users.id';
COMMENT ON COLUMN friends.user_id IS 'Foreign key referencing user_db.users.id';
COMMENT ON COLUMN friends.friend_id IS 'Foreign key referencing user_db.users.id';
COMMENT ON COLUMN messages.sender_id IS 'Foreign key referencing user_db.users.id';
COMMENT ON COLUMN messages.receiver_id IS 'Foreign key referencing user_db.users.id';
COMMENT ON COLUMN views.user_id IS 'Foreign key referencing user_db.users.id';
COMMENT ON COLUMN views.post_id IS 'Foreign key referencing post_db.posts.id';