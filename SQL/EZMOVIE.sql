CREATE SEQUENCE movie_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000000
NOCYCLE;

CREATE TABLE movie(
    movie_cd number(10),
    movie_title varchar2(100),
    movie_url varchar2(300),
    trailer_url varchar2(300),
    release_date date,
    running_time number(3),
    film_rate number(2)
);

CREATE TABLE movie_info(
    movie_cd number(10),
    synopsis varchar2(2000),
    director varchar2(50),
    cast varchar2(100),
    distributor varchar(50)
);


ALTER TABLE movie
    ADD CONSTRAINT movie_movie_cd_pk PRIMARY KEY(movie_cd);
    
ALTER TABLE movie_info
    ADD CONSTRAINT movie_info_movie_cd_pk PRIMARY KEY(movie_cd);

ALTER TABLE movie_info
    ADD FOREIGN KEY(movie_cd)REFERENCES movie;
    
-- 테스트 겸 넣을 데이터임 지우지마셈
--INSERT INTO movie (movie_cd, movie_title, movie_url, trailer_url, release_date,running_time, film_rate)
--    VALUES(movie_seq.NEXTVAL, '영화제목','링크1', '링크2', '2022/02/16' ,100, 5 );
    
CREATE TABLE member( 
    mem_id varchar2(50),
    mem_pw varchar2(2000),
    mem_birth date,
    mem_address varchar2(100),
    mem_phone varchar(12), -- -포함
    join_date date,
    mem_salt varchar2(250) -- 비번 salt 암호화
);

ALTER TABLE member
    ADD CONSTRAINT member_mem_id_pk PRIMARY KEY(mem_id);