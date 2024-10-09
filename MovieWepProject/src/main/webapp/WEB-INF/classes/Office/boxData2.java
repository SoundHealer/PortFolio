package Office;

import java.util.List;

public class boxData2 {
    private String rank;
    private String rankInten;
    private String rankOldAndNew;
    private String movieCd;
    private String movieNm;
    private String openDt;
    private String salesAmt; //해당일 매출액
    private String salesChange;
    private String audiCnt; //해당일 관객수
    private String audiAcc;//누적매출액
    private String audiInten;//누적매출액
    private String audiChange;
	private List<String> directors;//감독명
    private List<String> directorsEn; // 영문 감독 이름을 저장할 리스트 추가
    private String posterUrl;
    private String salesShare; //해당일자 상영작의 매출총액 대비 해당 영화의 매출비율을 출력합니다.
    private String watchGradeNm; // 관람등급
    private String showTm; // 상영시간
    private String nationNm; // 제작국가명
    private String prdtStatNm; // 제작상태
    private String salesAcc;
    
    public String getSalesAcc() {
		return salesAcc;
	}

	public void setSalesAcc(String salesAcc) {
		this.salesAcc = salesAcc;
	}

	public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getAudiInten() {
		return audiInten;
	}

	public void setAudiInten(String audiInten) {
		this.audiInten = audiInten;
	}

	public String getAudiChange() {
		return audiChange;
	}

	public String getRankOldAndNew() {
		return rankOldAndNew;
	}

	public void setRankOldAndNew(String rankOldAndNew) {
		this.rankOldAndNew = rankOldAndNew;
	}

	public void setAudiChange(String audiChange) {
		this.audiChange = audiChange;
	}
	
    public String getRankInten() {
		return rankInten;
	}

	public void setRankInten(String rankInten) {
		this.rankInten = rankInten;
	}

	public List<String> getDirectorsEn() {
        return directorsEn;
    }

    public void setDirectorsEn(List<String> directorsEn) {
        this.directorsEn = directorsEn;
    }

    public String getSalesShare() {
        return salesShare;
    }

    public void setSalesShare(String salesShare) {
        this.salesShare = salesShare;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public List<String> getDirectors() {
        return directors;
    }

    public void setDirectors(List<String> directors) {
        this.directors = directors;
    }

    public String getMovieCd() {
        return movieCd;
    }

    public void setMovieCd(String movieCd) {
        this.movieCd = movieCd;
    }

    public String getMovieNm() {
        return movieNm;
    }

    public void setMovieNm(String movieNm) {
        this.movieNm = movieNm;
    }

    public String getOpenDt() {
        return openDt;
    }

    public void setOpenDt(String openDt) {
        this.openDt = openDt;
    }

    public String getSalesAmt() {
        return salesAmt;
    }

    public void setSalesAmt(String salesAmt) {
        this.salesAmt = salesAmt;
    }

    public String getSalesChange() {
        return salesChange;
    }

    public void setSalesChange(String salesChange) {
        this.salesChange = salesChange;
    }

    public String getAudiCnt() {
        return audiCnt;
    }

    public void setAudiCnt(String audiCnt) {
        this.audiCnt = audiCnt;
    }

    public String getAudiAcc() {
        return audiAcc;
    }

    public void setAudiAcc(String audiAcc) {
        this.audiAcc = audiAcc;
    }

    public String getWatchGradeNm() {
        return watchGradeNm;
    }

    public void setWatchGradeNm(String watchGradeNm) {
        this.watchGradeNm = watchGradeNm;
    }

    public String getShowTm() {
        return showTm;
    }

    public void setShowTm(String showTm) {
        this.showTm = showTm;
    }

    public String getNationNm() {
        return nationNm;
    }

    public void setNationNm(String nationNm) {
        this.nationNm = nationNm;
    }

    public String getPrdtStatNm() {
        return prdtStatNm;
    }

    public void setPrdtStatNm(String prdtStatNm) {
        this.prdtStatNm = prdtStatNm;
    }
}