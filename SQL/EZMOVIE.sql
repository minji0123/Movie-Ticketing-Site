CREATE SEQUENCE movie_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000000
NOCYCLE;
--------------------------------------------------------------------------------------------------
CREATE TABLE movie(
    movie_cd number(10),-- pk
    movie_title varchar2(100),
    movie_url varchar2(300),
    trailer_url varchar2(300),
    release_date date,
    running_time number(3),
    film_rate number(2)
);


ALTER TABLE movie
    ADD CONSTRAINT movie_movie_cd_pk PRIMARY KEY(movie_cd);

--------------------------------------------------------------------------------------------------
CREATE TABLE movie_info(
    movie_cd number(10),-- fk -- pk
    synopsis varchar2(2000),
    director varchar2(50),
    cast varchar2(100),
    distributor varchar(50)
);
    
ALTER TABLE movie_info
    ADD CONSTRAINT movie_info_movie_cd_pk PRIMARY KEY(movie_cd);

ALTER TABLE movie_info
    ADD FOREIGN KEY(movie_cd)REFERENCES movie;
    
-- 테스트 겸 넣을 데이터임 지우지마셈
--INSERT INTO movie (movie_cd, movie_title, movie_url, trailer_url, release_date,running_time, film_rate)
--    VALUES(movie_seq.NEXTVAL, '영화제목','링크1', '링크2', '2022/02/16' ,100, 5 );
--------------------------------------------------------------------------------------------------
CREATE TABLE member( 
    mem_id varchar2(50),-- pk
    mem_pw varchar2(2000),
    mem_birth date,
    mem_address varchar2(100),
    mem_phone varchar(12), -- -포함
    join_date date,
    mem_salt varchar2(250) -- 비번 salt 암호화
);

ALTER TABLE member
    ADD CONSTRAINT member_mem_id_pk PRIMARY KEY(mem_id);
--------------------------------------------------------------------------------------------------
CREATE TABLE review( 
    mem_id varchar2(50), -- fk
    movie_cd number(10),-- fk
    review_date date,
    review_time timestamp,
    grade number(2,1),
    review_contents varchar(300)
);

ALTER TABLE review
    ADD FOREIGN KEY(mem_id)REFERENCES member;

ALTER TABLE review
    ADD FOREIGN KEY(movie_cd)REFERENCES movie;
--------------------------------------------------------------------------------------------------
CREATE TABLE screening_schedule( 
    screening_cd number(10),-- pk
    movie_cd number(10),-- fk
    screening_date date,
    theater_cd number(4)-- fk
);
ALTER TABLE screening_schedule
    ADD CONSTRAINT screening_schedule_screening_cd_pk PRIMARY KEY(screening_cd);
    
ALTER TABLE screening_schedule
    ADD FOREIGN KEY(movie_cd)REFERENCES movie;
    
ALTER TABLE screening_schedule
    ADD FOREIGN KEY(theater_cd)REFERENCES theater;
--------------------------------------------------------------------------------------------------
CREATE TABLE theater( 
    theater_cd number(4),-- pk
    cinema_cd number(3), -- fk
    theater_no number(2),
    theater_type varchar2(20)
);

ALTER TABLE theater
    ADD CONSTRAINT theater_theater_cd_pk PRIMARY KEY(theater_cd);
    
ALTER TABLE theater
    ADD FOREIGN KEY(cinema_cd)REFERENCES cinema;
    
--------------------------------------------------------------------------------------------------
CREATE TABLE cinema( 
    cinema_cd number(3), -- pk
    cinema_name varchar2(15),
    cinema_location varchar2(100),
    parking_info varchar2(100), 
    cinema_phone varchar2(12)
);

ALTER TABLE cinema
    ADD CONSTRAINT cinema_cinema_cd_pk PRIMARY KEY(cinema_cd);
    
--------------------------------------------------------------------------------------------------
CREATE TABLE seat( 
    seat_cd number(10), -- pk
    theater_cd number(4), -- fk
    seat_row_no char(1),
    seat_col_no number(2)
);

ALTER TABLE seat
    ADD CONSTRAINT seat_seat_cd_pk PRIMARY KEY(seat_cd);

ALTER TABLE seat
    ADD FOREIGN KEY(theater_cd) REFERENCES theater;
    
--------------------------------------------------------------------------------------------------    
--CREATE TABLE reserved_seat( 
--    seat_cd number(10), -- fk
--    screening_cd number(10), -- fk
--    ticket_cd number(15) -- fk
--);
 
--------------------------------------------------------------------------------------------------    
CREATE TABLE ticketing( 
    ticket_cd number(10), -- pk
    mem_id varchar2(50), -- fk
--    nomem_phone char(1),
    adult number(1),
    teenager number(1),
    child number(1),
    screening_cd number(10)-- fk
);
drop table ticketing;

ALTER TABLE ticketing
    ADD CONSTRAINT ticketing_ticket_cd_pk PRIMARY KEY(ticket_cd);

ALTER TABLE ticketing
    ADD FOREIGN KEY(mem_id) REFERENCES member;
    
ALTER TABLE ticketing
    ADD FOREIGN KEY(screening_cd) REFERENCES screening_schedule;
    
--------------------------------------------------------------------------------------------------    