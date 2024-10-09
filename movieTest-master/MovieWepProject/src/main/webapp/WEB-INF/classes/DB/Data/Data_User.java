package DB.Data;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.json.simple.parser.ParseException;

import DB.DatabaseConnection;

public class Data_User extends DatabaseConnection {

	private String id = "";
	private String pw = "";
	private String name = "";
	private Date birthday = Date.valueOf("2000-01-01");
	private String email = "";
	private String address = "";
	private String genre_1 = "";
	private String genre_2 = "";
	private String genre_3 = "";
	private String genre_4 = "";

	public Data_User() {
		this.id = "";
		this.pw = "";
		this.name = "";
		this.birthday = Date.valueOf("1900-01-01");
		this.email = "";
		this.address = "";
		this.genre_1 = "";
		this.genre_2 = "";
		this.genre_3 = "";
		this.genre_4 = "";
	}

	public Data_User(String[] datas) {

		this.id = datas[0];
		this.pw = datas[1];
		this.name = datas[2];
		this.birthday = transStringDate(datas[3]);
		this.email = datas[4];
		this.address = datas[5];
		this.genre_1 = datas[6];
		this.genre_2 = datas[7];
		this.genre_3 = datas[8];
		this.genre_4 = datas[9];

	}

	@Override
	public String toString() {
		return "Data_User [id=" + id + ", pw=" + pw + ", name=" + name + ", birthday=" + birthday + ", email=" + email
				+ ", address=" + address + ", genre_1=" + genre_1 + ", genre_2=" + genre_2 + ", genre_3=" + genre_3
				+ ", genre_4=" + genre_4 + "]";
	}

	public Data_User(String id, String pw) {
		super();
		this.id = id;
		this.pw = pw;
	}

	public Data_User(String id, String pw, String name, Date birthday, String email, String address, String genre_1,
			String genre_2, String genre_3, String genre_4) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.birthday = birthday;
		this.email = email;
		this.address = address;
		this.genre_1 = genre_1;
		this.genre_2 = genre_2;
		this.genre_3 = genre_3;
		this.genre_4 = genre_4;
	}

	public String getEmail() {
		return email;
	}

	public String getGenre_1() {
		return genre_1;
	}

	public void setGenre_1(String genre_1) {
		this.genre_1 = genre_1;
	}

	public String getGenre_2() {
		return genre_2;
	}

	public void setGenre_2(String genre_2) {
		this.genre_2 = genre_2;
	}

	public String getGenre_3() {
		return genre_3;
	}

	public void setGenre_3(String genre_3) {
		this.genre_3 = genre_3;
	}

	public String getGenre_4() {
		return genre_4;
	}

	public void setGenre_4(String genre_4) {
		this.genre_4 = genre_4;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date date) {
		this.birthday = date;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
