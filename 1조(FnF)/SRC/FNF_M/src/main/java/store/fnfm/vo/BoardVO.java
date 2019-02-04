package store.fnfm.vo;

public class BoardVO {
	private String board;
	private int idx;
	private String user_id;
	private String title;
	private String contents;
	private String writedate;
	private int readnum;
	
	public BoardVO() {}

	public BoardVO(String board, int idx, String user_id, String title, String contents, String writedate,
			int readnum) {
		this.board = board;
		this.idx = idx;
		this.user_id = user_id;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.readnum = readnum;
	}

	public String getBoard() {
		return board;
	}

	public void setBoard(String board) {
		this.board = board;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	

	
	
}
