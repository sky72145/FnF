CREATE SEQUENCE seq_faq_idx
MAXVALUE 9999;

CREATE TABLE Faq
(
	idx NUMBER(9) PRIMARY KEY,
	user_id VARCHAR2(20) NOT NULL,
	title VARCHAR2(100) NOT NULL,
	contents CLOB NOT NULL,
	writedate DATE DEFAULT SYSDATE,
	readnum NUMBER(4) DEFAULT 0,
    filename VARCHAR2(200)
);

CREATE OR REPLACE PROCEDURE sp_faq_insert
(
    v_user_id         IN       faq.user_id%TYPE,
    v_title         IN       faq.title%TYPE,
    v_contents         IN       faq.contents%TYPE,
    v_filename IN faq.filename%TYPE
)
IS
BEGIN
    INSERT INTO Faq(idx, user_id, title, contents, filename)
    VALUES (SEQ_faq_IDX.nextval, v_user_id, v_title, v_contents, v_filename);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_faq_select_all
(
    rec_faq       OUT      SYS_REFCURSOR,
    v_start             IN          NUMBER,
	v_end               IN          NUMBER
)
AS
BEGIN
    OPEN rec_faq FOR
	SELECT B.idx, user_id, title, writedate, readnum
	FROM
		(SELECT rownum AS rnum, A.idx, A.user_id, A.title, A.writedate, A.readnum
			FROM
				(SELECT idx, user_id, title, writedate, readnum
					FROM faq ORDER BY idx DESC) A
			WHERE rownum <= v_end) B
	WHERE B.rnum >= v_start;
END;

CREATE OR REPLACE PROCEDURE sp_faq_select_one
(
    v_idx           IN       Faq.idx%TYPE,
    rec_faq       OUT      SYS_REFCURSOR
)
AS
BEGIN
    OPEN rec_faq FOR
    SELECT idx, user_id, title, contents, filename, TO_CHAR(writedate, 'yyyy-mm-dd') AS writedate, readnum
    FROM Faq
    WHERE idx = v_idx;
END;

create or replace PROCEDURE sp_faq_update
(
    v_title     IN      Faq.title%TYPE,
    v_contents  IN      Faq.contents%TYPE,
    v_idx      IN      Faq.idx%TYPE,
    v_filename     IN      Faq.filename%TYPE
)
IS
BEGIN
    UPDATE Faq SET title = v_title, contents = v_contents, filename = v_filename
    WHERE idx = v_idx;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_faq_total_count
(
    v_count     OUT     Number
)
IS
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM faq;
END;

CREATE OR REPLACE PROCEDURE sp_faq_delete
(
    v_idx      IN      Faq.idx%TYPE
)
IS
BEGIN
    DELETE FROM faq WHERE idx = v_idx;
    COMMIT;
END;

create or replace PROCEDURE      Faq_SEARCH
(
  s_user_id               IN      faq.user_id%TYPE,
  s_title               IN      faq.title%TYPE,
  s_contents            IN         faq.contents%TYPE,
  faq_record          OUT       SYS_REFCURSOR,
  v_start             IN          NUMBER,
  v_end               IN          NUMBER
)
AS
BEGIN
   OPEN faq_record FOR
   SELECT B.idx, user_id, title, writedate, readnum, contents
   FROM
      (SELECT rownum AS rnum, A.idx, A.user_id, A.title, A.writedate, A.readnum, A.contents
   FROM
      (SELECT idx, user_id, title, writedate, readnum, contents
         FROM Faq ORDER BY idx DESC) A
         WHERE rownum <= v_end
      AND
      (
         user_id LIKE CONCAT('%',(CONCAT(s_user_id,'%')))
         AND title LIKE CONCAT('%',(CONCAT(s_title,'%')))
         AND contents LIKE CONCAT('%',(CONCAT(s_contents,'%')))
      )
      ) B
   WHERE B.rnum >= v_start;
END;

create or replace PROCEDURE Faq_SEARCH_TOTAL
(
	s_user_id			    IN		Faq.user_id%TYPE,
    s_title					IN		Faq.title%TYPE,
    s_contents				IN		Faq.contents%TYPE,
    v_count OUT Number
)
IS
BEGIN
	SELECT COUNT(*) INTO v_count
  FROM Faq
  WHERE 
 (
		user_id LIKE CONCAT('%',(CONCAT(s_user_id,'%')))
		AND title LIKE CONCAT('%',(CONCAT(s_title,'%')))
		AND contents LIKE CONCAT('%',(CONCAT(s_contents,'%')))
  )ORDER BY idx DESC;
END;

