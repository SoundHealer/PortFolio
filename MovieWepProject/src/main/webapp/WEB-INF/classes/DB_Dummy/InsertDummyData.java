package DB_Dummy;

import java.sql.*;
import java.util.*;

import DB.DatabaseConnection;

public class InsertDummyData extends DatabaseConnection {
	Connection conn = null;
	PreparedStatement pstmt = null;

	class movieData {
		String title;
		String docid;
		movieData(String docid, String title) {
			this.title = title;
			this.docid = docid;
		}
		public String getTitle() { return title; }
		public String getDocid() { return docid; }
	}

	ArrayList<movieData> movieList = new ArrayList<movieData>();
	int insertCount = 0;

	public static void main(String[] args) {
		new InsertDummyData();
	}

	InsertDummyData() {

		// System.out.println(movieList.size());
		// movieListCopy = movieList;
		// System.out.println(movieListCopy.size());
		conn = getConnection();
		for (int idCount = 1; idCount <= 200; idCount++) {
			String id = createUserId(idCount);

			listReset();
			System.out.println(id + "의 데이터 추가중");
			insertSql(id);
		}
		System.err.println("추가 완료 : " + insertCount);

	}

	public void listReset() {
		movieList = new ArrayList<movieData>();
		/* 드라마 */ movieList.add(new movieData("요절 프로젝트", "K35064"));
		movieList.add(new movieData("가디언스 오브 더 포뮬라", "F59330"));
		/* 첩보 */ movieList.add(new movieData("선물", "K10141"));
		movieList.add(new movieData("겟 스마트", "F21871"));
		/* 옴니버스 */ movieList.add(new movieData("관계의 일변", "K32497"));
		movieList.add(new movieData("우스운게 딱! 좋아!", "K29064"));
		/* 뮤직 */ movieList.add(new movieData("사이퍼", "B11259"));
		movieList.add(new movieData("서태지 25주년 라이브 타임: 트래블러", "A12456"));
		/* 동성애 */ movieList.add(new movieData("120 BPM", "F39412"));
		movieList.add(new movieData("과호흡", "K16467"));
		/* 로드무비 */ movieList.add(new movieData("배틀트립 투 그리스", "F40957"));
		movieList.add(new movieData("잉여들의 히치하이킹", "A05972"));
		/* 아동 */ movieList.add(new movieData("건전지 아빠", "K25186"));
		movieList.add(new movieData("나쁜 친구", "K25155"));
		/* 하이틴(고교) */ movieList.add(new movieData("컴다운", "F31149"));
		movieList.add(new movieData("오란고교 호스트부", "F30751"));
		/* 전기 */ movieList.add(new movieData("러빙", "F35644"));
		movieList.add(new movieData("내 어깨 위 고양이, 밥", "F37424"));
		/* 청춘영화 */ movieList.add(new movieData("3류 취준생", "K28319"));
		movieList.add(new movieData("귀로", "K28268"));
		/* 재난 */ movieList.add(new movieData("무인지대", "B06381"));
		movieList.add(new movieData("사라진 풍경의 기억들", "B06380"));
		/* 문예 */ movieList.add(new movieData("가시를 삼킨 장미", "K03381"));
		movieList.add(new movieData("광염소나타", "K03369"));
		/* 연쇄극 */ movieList.add(new movieData("87 영자의 전성시대", "K04019"));
		/* 신파 */ movieList.add(new movieData("무성영화 변사극 이수일과 심순애", "K13028"));
		movieList.add(new movieData("늑대의 유혹", "K06199"));
		/* 활극 */ movieList.add(new movieData("검객이야기", "K04991"));
		movieList.add(new movieData("귀천도", "K04860"));
		/* 반공/분단 */ movieList.add(new movieData("비화 6.15", "A04265"));
		movieList.add(new movieData("태극기 휘날리며", "K06113"));
		/* 군사 */ movieList.add(new movieData("아가씨와 사관", "K03829"));
		movieList.add(new movieData("팀스피리트 84", "A01324"));
		/* 계몽 */ movieList.add(new movieData("착한 비디오", "K11410"));
		movieList.add(new movieData("순환", "K07682"));
		/* 사회물(경향) */ movieList.add(new movieData("연극하는 날", "A09985"));
		movieList.add(new movieData("재춘언니", "A09968"));
		/* 스포츠 */ movieList.add(new movieData("풀카운트", "K29135"));
		movieList.add(new movieData("1승", "K27564"));
		/* 합작(번안물) */ movieList.add(new movieData("안개속에서 2분 더", "K04781"));
		movieList.add(new movieData("스타체이서-오린의 전설", "K06068"));
		/* 종교 */ movieList.add(new movieData("쓰리, 몬스터", "K06243"));
		movieList.add(new movieData("스퀴시", "K06175"));
		/* 무협 */ movieList.add(new movieData("301호 모텔 살인사건", "K35291"));
		movieList.add(new movieData("발레리나", "K35286"));
		/* 미스터리 */ movieList.add(new movieData("무빙", "K35110"));
		movieList.add(new movieData("림버스", "K34524"));
		/* SF */ movieList.add(new movieData("인성검사", "K35195"));
		movieList.add(new movieData("15분", "K34805"));
		/* 코메디 */ movieList.add(new movieData("업보", "K34519"));
		movieList.add(new movieData("막걸리가 알려줄거야", "K35426"));
		/* 느와르 */ movieList.add(new movieData("무빙 18-20부", "K35313"));
		movieList.add(new movieData("바람개비", "K34282"));
		/* 액션 */ movieList.add(new movieData("잔고: 분노의 적자", "K29238"));
		movieList.add(new movieData("발레리나", "K35286"));
		/* 범죄 */ movieList.add(new movieData("그녀의 취미생활", "K33987"));
		movieList.add(new movieData("최악의 악", "K35138"));
		/* 어드벤처 */ movieList.add(new movieData("치치핑핑의 쿵쿵따 탐험대", "A12336"));
		movieList.add(new movieData("도적: 칼의 소리", "K35197"));
		/* 가족 */ movieList.add(new movieData("과화만사성", "K34911"));
		movieList.add(new movieData("둥지", "K34950"));
		/* 에로 */ movieList.add(new movieData("잘 주는 이웃집 여자", "K35046"));
		movieList.add(new movieData("스와핑 : 나쁜처제", "K33966"));
		/* 멜로/로맨스 */ movieList.add(new movieData("뜨끈한 뜨개질", "K34887"));
		movieList.add(new movieData("로맨스 바이 로맨스", "K34734"));
		/* 공포 */ movieList.add(new movieData("업보", "K34519"));
		movieList.add(new movieData("뉴 노멀", "K29234"));
		/* 뮤지컬 */ movieList.add(new movieData("플레이 뮤지컬 핑크퐁과 아기상어의 생일파티 대소동", "A12364"));
		movieList.add(new movieData("별을헤다", "K34447"));
		/* 시대극/사극 */ movieList.add(new movieData("1947 보스톤", "K22320"));
		movieList.add(new movieData("도적: 칼의 소리", "K35197"));
		/* 실험 */ movieList.add(new movieData("영화", "A12416"));
		movieList.add(new movieData("에스레베르", "A12412"));
		/* 스릴러 */ movieList.add(new movieData("거미집", "K34516"));
		movieList.add(new movieData("어웨이", "K34525"));
		/* 서부 */ movieList.add(new movieData("잔고: 분노의 적자", "K29238"));
		movieList.add(new movieData("철암계곡의 혈투", "K12886"));
		/* 전쟁 */ movieList.add(new movieData("여공의 밤", "A12496"));
		movieList.add(new movieData("되살아나는 목소리", "A12495"));
		/* 갱스터 */ movieList.add(new movieData("얼굴없는 보스", "K20496"));
		movieList.add(new movieData("서랍속의 시체", "K25708"));
		/* 판타지 */ movieList.add(new movieData("바얌섬", "K35423"));
		movieList.add(new movieData("레디", "K34907"));
		/* 해양액션 */ movieList.add(new movieData("마린보이", "K10079"));
		movieList.add(new movieData("블루", "K05895"));

	}

	public void insertSql(String id) {
		for (int i = 0; i < 5; i++) {
			System.out.println("insertSql[" + i + "] : " + movieList.size());
			int index = rand(0, movieList.size() - 1);
			String docid = movieList.get(index).getDocid();
			String title = movieList.get(index).getTitle();

			int score = rand(0, 10);
//			System.out.println("insertSql : " + score);
			String sql = setSql(docid, id, title, score);
			insertDummyReviews(sql);
			movieList.remove(index);
		}
	}

	public String setSql(String docid, String userid, String title, int score) {
		String review = userid + "가 작성한 영화[" + title + "]에 대한 " + score + "점 리뷰 입니다.";
		return "insert into moviedb.review(docid,userid,score,review) value(\'" + docid.trim() + "\',\'" + userid.trim()
				+ "\'," + score + ",\'" + review.trim() + "\')";
	}

	public String createUserId(int c) {

		String count = c + "";
		while (count.length() <= 3) {
			count = "0" + count;
		}

		return "user" + count;
	}

	public int rand(int in_min, int in_max) {
		Random rand = new Random();
		int min = Math.min(in_min, in_max);
		int max = Math.max(in_min, in_max);
		return rand.nextInt((max - min) + 1) + min;
	}

	public void insertDummyReviews(String sql) {

		try {
			// "SELECT * FROM moviedb.review WHERE ? = ?"
			String checkIdSql = sql;

			pstmt = conn.prepareStatement(checkIdSql);

			int rs = pstmt.executeUpdate();
			insertCount++;
			if (rs > 0) {
				// System.out.println("추가 완료 : " + insertCount++);
			}

		} catch (SQLException e) {
			System.out.println("에러발생 : " + sql);
			e.printStackTrace();
		}
	}
}
