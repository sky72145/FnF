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
    v_contents         IN       faq.contents%TYPE
)
IS
BEGIN
    INSERT INTO Faq(idx, user_id, title, contents)
    VALUES (SEQ_faq_IDX.nextval, v_user_id, v_title, v_contents);
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
    SELECT idx, user_id, title, contents, TO_CHAR(writedate, 'yyyy-mm-dd') AS writedate, readnum
    FROM Faq
    WHERE idx = v_idx;
END;

create or replace PROCEDURE sp_faq_update
(
    v_title     IN      Faq.title%TYPE,
    v_contents  IN      Faq.contents%TYPE,
    v_idx      IN      Faq.idx%TYPE
)
IS
BEGIN
    UPDATE Faq SET title = v_title, contents = v_contents
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



