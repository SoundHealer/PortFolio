package boxOffice;

import java.util.ArrayList;

import org.json.simple.JSONObject;

public class BoxOfficeData {
	String audiAcc = ""; // 누적관객수를 출력합니다.
	String audiChange = ""; // 전일 대비 관객수 증감 비율을 출력합니다.
	String audiCnt = ""; // 해당일의 관객수를 출력합니다.
	String audiInten = ""; // 전일 대비 관객수 증감분을 출력합니다.
	String movieCd = ""; // 영화의 대표코드를 출력합니다.
	String movieNm = ""; // 영화명(국문)을 출력합니다.
	String openDt = ""; // 영화의 개봉일을 출력합니다.
	String rank = ""; // 해당일자의 박스오피스 순위를 출력합니다.
	String rankInten = ""; // 전일대비 순위의 증감분을 출력합니다.
	String rankOldAndNew = ""; // 랭킹에 신규진입여부를 출력합니다.
	String rnum = ""; // 순번을 출력합니다.
	String salesAcc = ""; // 누적매출액을 출력합니다.
	String salesAmt = ""; // 해당일의 매출액을 출력합니다.
	String salesChange = ""; // 전일 대비 매출액 증감 비율을 출력합니다.
	String salesInten = ""; // 전일 대비 매출액 증감분을 출력합니다.
	String salesShare = ""; // 해당일자 상영작의 매출총액 대비 해당 영화의 매출비율을 출력합니다.
	String scrnCnt = ""; // 해당일자에 상영한 스크린수를 출력합니다.
	String showCnt = ""; // 해당일자에 상영된 횟수를 출력합니다.
	
	public String getAudiAcc() { return audiAcc; }
	public void setAudiAcc(String audiAcc) { this.audiAcc = audiAcc; }
	public String getAudiChange() { return audiChange; }
	public void setAudiChange(String audiChange) { this.audiChange = audiChange; }
	public String getAudiCnt() { return audiCnt; }
	public void setAudiCnt(String audiCnt) { this.audiCnt = audiCnt; }
	public String getAudiInten() { return audiInten; }
	public void setAudiInten(String audiInten) { this.audiInten = audiInten; }
	public String getMovieCd() { return movieCd; }
	public void setMovieCd(String movieCd) { this.movieCd = movieCd; }
	public String getMovieNm() { return movieNm; }
	public void setMovieNm(String movieNm) { this.movieNm = movieNm; }
	public String getOpenDt() { return openDt; }
	public void setOpenDt(String openDt) { this.openDt = openDt; }
	public String getRank() { return rank; }
	public void setRank(String rank) { this.rank = rank; }
	public String getRankInten() { return rankInten; }
	public void setRankInten(String rankInten) { this.rankInten = rankInten; }
	public String getRankOldAndNew() { return rankOldAndNew; }
	public void setRankOldAndNew(String rankOldAndNew) { this.rankOldAndNew = rankOldAndNew; }
	public String getRnum() { return rnum; }
	public void setRnum(String rnum) { this.rnum = rnum; }
	public String getSalesAcc() { return salesAcc; }
	public void setSalesAcc(String salesAcc) { this.salesAcc = salesAcc; }
	public String getSalesAmt() { return salesAmt; }
	public void setSalesAmt(String salesAmt) { this.salesAmt = salesAmt; }
	public String getSalesChange() { return salesChange; }
	public void setSalesChange(String salesChange) { this.salesChange = salesChange; }
	public String getSalesInten() { return salesInten; }
	public void setSalesInten(String salesInten) { this.salesInten = salesInten; }
	public String getSalesShare() { return salesShare; }
	public void setSalesShare(String salesShare) { this.salesShare = salesShare; }
	public String getScrnCnt() { return scrnCnt; }
	public void setScrnCnt(String scrnCnt) { this.scrnCnt = scrnCnt; }
	public String getShowCnt() { return showCnt; }
	public void setShowCnt(String showCnt) { this.showCnt = showCnt; }
	
	
	
	@Override
	public String toString() {
		return "BoxOfficeData [audiAcc=" + audiAcc + ", audiChange=" + audiChange + ", audiCnt=" + audiCnt
				+ ", audiInten=" + audiInten + ", movieCd=" + movieCd + ", movieNm=" + movieNm + ", openDt=" + openDt
				+ ", rank=" + rank + ", rankInten=" + rankInten + ", rankOldAndNew=" + rankOldAndNew + ", rnum=" + rnum
				+ ", salesAcc=" + salesAcc + ", salesAmt=" + salesAmt + ", salesChange=" + salesChange + ", salesInten="
				+ salesInten + ", salesShare=" + salesShare + ", scrnCnt=" + scrnCnt + ", showCnt=" + showCnt + "]";
	}
	public ArrayList<BoxOfficeData> resultBoxOfficeData(org.json.simple.JSONArray dataArray){
		//ArrayList<BoxOfficeData>
		//System.out.println(dataArray.size());
		
		ArrayList<BoxOfficeData> List = new ArrayList<BoxOfficeData>();
		
		for(int i = 0; i<dataArray.size();i++) {
			
			JSONObject resultObj = (JSONObject)dataArray.get(i);
			
			//System.out.println(resultObj);
			//System.out.println("[" + i + "] : " + resultObj.get("audiCnt"));
			
			BoxOfficeData data = new BoxOfficeData();
			data.setAudiAcc((String)resultObj.get("audiAcc"));
			data.setAudiChange((String)resultObj.get("audiChange"));
			data.setAudiCnt((String)resultObj.get("audiCnt"));
			data.setAudiInten((String)resultObj.get("audiInten"));
			data.setMovieCd((String)resultObj.get("movieCd"));
			data.setMovieNm((String)resultObj.get("movieNm"));
			data.setOpenDt((String)resultObj.get("openDt"));
			data.setRank((String)resultObj.get("rank"));
			data.setRankInten((String)resultObj.get("rankInten"));
			data.setRankOldAndNew((String)resultObj.get("rankOldAndNew"));
			data.setRnum((String)resultObj.get("rnum"));
			data.setSalesAcc((String)resultObj.get("salesAcc"));
			data.setSalesAmt((String)resultObj.get("salesAmt"));
			data.setSalesChange((String)resultObj.get("salesChange"));
			data.setSalesInten((String)resultObj.get("salesInten"));
			data.setSalesShare((String)resultObj.get("salesShare"));
			data.setScrnCnt((String)resultObj.get("scrnCnt"));
			data.setShowCnt((String)resultObj.get("showCnt"));

			List.add(data);
			
		}
		
		return List;
	}
	
}
