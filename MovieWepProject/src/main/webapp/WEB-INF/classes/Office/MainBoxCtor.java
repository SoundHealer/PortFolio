package Office;

import java.util.List;

public class MainBoxCtor {
	@Override
	public String toString() {
		return "MainBoxCtor [rank=" + rank + ", movieNm=" + movieNm + ", openDt=" + openDt + ", posterUrl=" + posterUrl
				+ ", movieDOCID=" + movieDOCID + "]";
	}

	private String rank;
	private String movieNm;
	private String openDt;
	private String posterUrl;
	private String movieDOCID;

	public String getMovieDOCID() {
		return movieDOCID;
	}

	public void setMovieDOCID(String DOCID) {
		this.movieDOCID = DOCID;
	}

	public String getPosterUrl() {
		return posterUrl;
	}

	public void setPosterUrl(String posterUrl) {
		this.posterUrl = posterUrl.equals("") ? "resource/images/흑백로고.png" : posterUrl;
	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
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
    	String[] dates = openDt.split("-");
    	String result = "";
    	if(openDt.equals("")) {
    		result = "-";
    	}
    	if(dates.length == 3) {
    		result = dates[0] + "-" + dates[1] + "-" + dates[2];
    	}
    	if(openDt.length() == 8) {
    		result = openDt.substring(0,4) + "-" + openDt.substring(4,6) + "-" + openDt.substring(6,8);
    	}
        this.openDt = result;
    }

}
