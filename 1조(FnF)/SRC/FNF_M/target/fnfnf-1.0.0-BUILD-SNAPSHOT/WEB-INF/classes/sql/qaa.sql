CREATE SEQUENCE seq_qaa_idx
MAXVALUE 9999;

CREATE TABLE Qaa
(
	idx NUMBER(9) PRIMARY KEY,
	user_id VARCHAR2(20) NOT NULL,
	password VARCHAR2(30),
	title VARCHAR2(100) NOT NULL,
	contents CLOB NOT NULL,
	writedate DATE DEFAULT SYSDATE,
	readnum NUMBER(4) DEFAULT 0,
	grp NUMBER(5) NOT NULL,
	lev NUMBER(1) DEFAULT 0,
	step NUMBER(4) DEFAULT 0,
    status NUMBER(1) DEFAULT 0
);

CREATE OR REPLACE PROCEDURE sp_qaa_insert
(
    v_user_id         IN       Qaa.user_id%TYPE,
    v_title         IN       Qaa.title%TYPE,
    v_contents         IN       Qaa.contents%TYPE,
    v_filename         IN       Qaa.filename%TYPE
)
IS
BEGIN
    INSERT INTO Qaa(idx, user_id, title, contents, filename, grp)
    VALUES (SEQ_qaa_IDX.nextval, v_user_id, v_title, v_contents, v_filename, SEQ_qaa_IDX.currval);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_qaa_select_all
(
    rec_qaa       OUT      SYS_REFCURSOR,
    v_start             IN          NUMBER,
	v_end               IN          NUMBER
)
AS
BEGIN
    OPEN rec_qaa FOR
	SELECT B.idx, grp, user_id, title, writedate, readnum, lev, step
	FROM
		(SELECT rownum AS rnum, A.idx, A.grp, A.user_id, A.title, A.writedate, A.readnum, A.lev, A.step
			FROM
				(SELECT idx, grp, user_id, title, writedate, readnum, lev, step
					FROM Qaa ORDER BY grp DESC, step ASC) A
			WHERE rownum <= v_end) B
	WHERE B.rnum >= v_start;
END;

CREATE OR REPLACE PROCEDURE sp_qaa_select_one
(
    v_idx           IN       Qaa.idx%TYPE,
    rec_qaa       OUT      SYS_REFCURSOR
)
AS
BEGIN
    OPEN rec_qaa FOR
    SELECT idx, user_id, title, contents, filename, TO_CHAR(writedate, 'yyyy-mm-dd') AS writedate, readnum, grp, lev, step
    FROM Qaa
    WHERE idx = v_idx;
END;

create or replace PROCEDURE sp_qaa_update
(
    v_title     IN      Qaa.title%TYPE,
    v_contents  IN      Qaa.contents%TYPE,
    v_idx      IN      Qaa.idx%TYPE,
    v_filename IN       Qaa.filename%TYPE
)
IS
BEGIN
    UPDATE Qaa SET title = v_title, contents = v_contents, filename = v_filename
    WHERE idx = v_idx;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE sp_qaa_delete
(
    v_idx      IN      Qaa.idx%TYPE
)
IS
BEGIN
    DELETE FROM Qaa WHERE idx = v_idx;
    COMMIT;
END;