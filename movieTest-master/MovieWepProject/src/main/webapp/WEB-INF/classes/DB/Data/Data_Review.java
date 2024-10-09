package DB.Data;

import java.sql.Date;

import DB.DatabaseConnection;

public class Data_Review extends DatabaseConnection {
	int no = 0;
	String userid = "";
	String title = "";
	String DOCID = "";
	int score = 0;
	String review = "";
	Date date = null;

	public Data_Review() {

	}
 
	public Data_Review(String[] datas) {

		this.no = StringParseInt(datas[0]);
		this.userid = datas[1];
		this.title = datas[2];
		this.DOCID = datas[3];
		this.score = Integer.parseInt(datas[4]);
		this.review = datas[5];
		this.date = transStringDate(datas[6]);
	}

	public Data_Review(String no, String userid, String title, String DOCID, String score, String review) {
		super();
		this.no = StringParseInt(no);
		this.userid = userid;
		this.title = title;
		this.DOCID = DOCID;
		this.score = Integer.parseInt(score);
		this.review = review;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDOCID() {
		return DOCID;
	}

	public void setDOCID(String DOCID) {
		this.DOCID = DOCID;
	}

	public int getScore() {
		// System.out.println("getScore : " + score);
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "Data_Review [userid=" + userid + ", title=" + title + ", DOCID=" + DOCID + ", score=" + score
				+ ", review=" + review + ", date=" + date + "]";
	}

}
