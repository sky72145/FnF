package store.fnfm.vo;

public class PageDTO2 {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria2 cri2;
	
	public PageDTO2(Criteria2 cri2, int total) {
		this.cri2 = cri2;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri2.getPageNum() / 10.0))*10;
		this.startPage = this.endPage - 9;
		int realEnd = (int) (Math.ceil((total * 1.0) / cri2.getAmount()));
		if(realEnd<this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getTotal() {
		return total;
	}

	public Criteria2 getCri2() {
		return cri2;
	}

	@Override
	public String toString() {
		return "PageDTO2 [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", cri2=" + cri2 + "]";
	}
	
}
