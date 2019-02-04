CREATE SEQUENCE seq_notice_idx
MAXVALUE 9999;

CREATE TABLE notice
(
	idx NUMBER(9) PRIMARY KEY,
	user_id VARCHAR2(20) NOT NULL,
	title VARCHAR2(100) NOT NULL,
	contents CLOB NOT NULL,
	writedate DATE DEFAULT SYSDATE,
	readnum NUMBER(4) DEFAULT 0,
    filename VARCHAR2(200)
);

CREATE OR REPLACE PROCEDURE sp_notice_insert
(
    v_user_id         IN       notice.user_id%TYPE,
    v_title         IN       notice.title%TYPE,
    v_contents         IN       notice.contents%TYPE
)
IS
BEGIN
    INSERT INTO notice(idx, user_id, title, contents)
    VALUES (SEQ_notice_IDX.nextval, v_user_id, v_title, v_contents);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_notice_select_all
(
    rec_notice       OUT      SYS_REFCURSOR,
    v_start             IN          NUMBER,
	v_end               IN          NUMBER
)
AS
BEGIN
    OPEN rec_notice FOR
	SELECT B.idx, user_id, title, writedate, readnum
	FROM
		(SELECT rownum AS rnum, A.idx, A.user_id, A.title, A.writedate, A.readnum
			FROM
				(SELECT idx, user_id, title, writedate, readnum
					FROM notice ORDER BY idx DESC) A
			WHERE rownum <= v_end) B
	WHERE B.rnum >= v_start;
END;

CREATE OR REPLACE PROCEDURE sp_notice_select_one
(
    v_idx           IN       notice.idx%TYPE,
    rec_notice       OUT      SYS_REFCURSOR
)
AS
BEGIN
    OPEN rec_notice FOR
    SELECT idx, user_id, title, contents, TO_CHAR(writedate, 'yyyy-mm-dd') AS writedate, readnum
    FROM notice
    WHERE idx = v_idx;
END;

create or replace PROCEDURE sp_notice_update
(
    v_title     IN      notice.title%TYPE,
    v_contents  IN      notice.contents%TYPE,
    v_idx      IN      notice.idx%TYPE
)
IS
BEGIN
    UPDATE notice SET title = v_title, contents = v_contents
    WHERE idx = v_idx;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_notice_total_count
(
    v_count     OUT     Number
)
IS
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM notice;
END;

CREATE OR REPLACE PROCEDURE sp_notice_delete
(
    v_idx      IN      notice.idx%TYPE
)
IS
BEGIN
    DELETE FROM notice WHERE idx = v_idx;
    COMMIT;
END;