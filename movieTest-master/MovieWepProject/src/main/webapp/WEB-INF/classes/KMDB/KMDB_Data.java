package KMDB;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class KMDB_Data {
	
	@Override
	public String toString() {
		return "KMDB_Data [ALIAS=" + ALIAS + ", audiAcc=" + audiAcc + ", Awards1=" + Awards1 + ", Awards2=" + Awards2
				+ ", company=" + company + ", DOCID=" + DOCID + ", episodes=" + episodes + ", fLocation=" + fLocation
				+ ", genre=" + genre + ", keywords=" + keywords + ", kmdbUrl=" + kmdbUrl + ", modDate=" + modDate
				+ ", movieId=" + movieId + ", movieSeq=" + movieSeq + ", nation=" + nation + ", openThtr=" + openThtr
				+ ", posters=" + Arrays.toString(posters) + ", prodYear=" + prodYear + ", ratedYn=" + ratedYn
				+ ", rating=" + rating + ", regDate=" + regDate + ", repRatDate=" + repRatDate + ", repRlsDate="
				+ repRlsDate + ", runtime=" + runtime + ", salesAcc=" + salesAcc + ", screenArea=" + screenArea
				+ ", screenCnt=" + screenCnt + ", soundtrack=" + soundtrack + ", statDate=" + statDate + ", statSouce="
				+ statSouce + ", stlls=" + Arrays.toString(stlls) + ", themeSong=" + themeSong + ", title=" + title
				+ ", titleEng=" + titleEng + ", titleEtc=" + titleEtc + ", titleOrg=" + titleOrg + ", type=" + type
				+ ", use=" + use + "]";
	}

	ArrayList<rating> ratings;
	ArrayList<plot> plots;
	ArrayList<director> directors;
	ArrayList<actor> actors;
	ArrayList<staff> staffs;
	ArrayList<vod> vods;

	public ArrayList<rating> getRatings() {
		return ratings;
	}

	public ArrayList<plot> getPlots() {
		return plots;
	}

	public ArrayList<director> getDirectors() {
		return directors;
	}

	public ArrayList<actor> getActors() {
		return actors;
	}

	public ArrayList<staff> getStaffs() {
		return staffs;
	}

	public ArrayList<vod> getVods() {
		return vods;
	}

	public void setRatings(org.json.simple.JSONObject ratings) {
		
		ArrayList<rating> list = new ArrayList<rating>();
		
		JSONObject getArray = (JSONObject) ratings.get("ratings");
		
		JSONArray arrayResult = (JSONArray) getArray.get("rating");

		for (int i = 0; i < arrayResult.size(); i++) {
			JSONObject result = (JSONObject) arrayResult.get(i);
			
			rating data = new rating();
			data.setRatingDate((String)result.get("ratingDate"));
			data.setRatingGrade((String)result.get("ratingGrade"));
			data.setRatingMain((String)result.get("ratingMain"));
			data.setRatingNo((String)result.get("ratingNo"));
			data.setReleaseDate((String)result.get("releaseDate"));
			data.setRuntime((String)result.get("runtime"));

			
			list.add(data);
		}
		this.ratings = list;
	}

	public void setPlots(org.json.simple.JSONObject plots) {
		ArrayList<plot> list = new ArrayList<plot>();
		
		JSONObject getArray = (JSONObject) plots.get("plots");
		
		JSONArray arrayResult = (JSONArray) getArray.get("plot");

		for (int i = 0; i < arrayResult.size(); i++) {
			JSONObject result = (JSONObject) arrayResult.get(i);
			
			plot data = new plot();
			data.setPlotLang((String)result.get("plotLang"));
			data.setPlotText((String)result.get("plotText"));
			
			list.add(data);
		}
		this.plots = list;
	}

	public void setDirectors(org.json.simple.JSONObject directors) {

		ArrayList<director> list = new ArrayList<director>();
		
		JSONObject getArray = (JSONObject) directors.get("directors");
		
		JSONArray arrayResult = (JSONArray) getArray.get("director");

		for (int i = 0; i < arrayResult.size(); i++) {
			JSONObject result = (JSONObject) arrayResult.get(i);
			String directorEnNm = (String)result.get("directorEnNm");
			String directorId = (String)result.get("directorId");
			String directorNm = (String)result.get("directorNm");
			directorNm = directorNm.replaceAll("!HE", "").replaceAll("!HS", "").replaceAll("\\s+", " ").trim();
			
			director data = new director();
			data.setDirectorEnNm(directorEnNm);
			data.setDirectorId(directorId);
			data.setDirectorNm(directorNm);
			//System.out.println(directorNm + "추가됨");
			list.add(data);
		}

		this.directors = list;
	}

	public void setActors(org.json.simple.JSONObject actors) {
		
		ArrayList<actor> list = new ArrayList<actor>();
		
		JSONObject getArray = (JSONObject) actors.get("actors");
		
		JSONArray arrayResult = (JSONArray) getArray.get("actor");

		for (int i = 0; i < arrayResult.size(); i++) {
			JSONObject result = (JSONObject) arrayResult.get(i);
			
			actor data = new actor();
			data.setActorEnNm((String)result.get("actorEnNm"));
			data.setActorId((String)result.get("actorId"));
			data.setActorNm((String)result.get("actorNm"));

			
			list.add(data);
		}
		
		this.actors = list;
	}

	public void setStaffs(org.json.simple.JSONObject staffs) {
		ArrayList<staff> list = new ArrayList<staff>();
		
		JSONObject getArray = (JSONObject) staffs.get("staffs");
		
		JSONArray arrayResult = (JSONArray) getArray.get("staff");

		for (int i = 0; i < arrayResult.size(); i++) {
			JSONObject result = (JSONObject) arrayResult.get(i);
			
			staff data = new staff();
			data.setStaffEnNm((String)result.get("staffEnNm"));
			data.setStaffEtc((String)result.get("staffEtc"));
			data.setStaffId((String)result.get("staffId"));
			data.setStaffNm((String)result.get("staffNm"));
			data.setStaffRole((String)result.get("staffRole"));
			data.setStaffRoleGroup((String)result.get("staffRoleGroup"));

			
			list.add(data);
		}
		this.staffs = list;
	}

	public void setVods(org.json.simple.JSONObject vods) {
		ArrayList<vod> list = new ArrayList<vod>();
		
		JSONObject getArray = (JSONObject) vods.get("staffs");
		
		JSONArray arrayResult = (JSONArray) getArray.get("staff");

		for (int i = 0; i < arrayResult.size(); i++) {
			JSONObject result = (JSONObject) arrayResult.get(i);
			
			vod data = new vod();
			data.setVodClass((String)result.get("vodClass"));
			data.setVodUrl((String)result.get("vodUrl"));
			
			list.add(data);
		}
		this.vods = list;
	}

	String ALIAS;
	String audiAcc;
	String Awards1;
	String Awards2;
	String company;
	String DOCID;
	String episodes;
	String fLocation;
	String genre;
	String keywords;
	String kmdbUrl;
	String modDate;
	String movieId;
	String movieSeq;
	String nation;
	String openThtr;
	String[] posters;
	String prodYear;
	String ratedYn;
	String rating;
	String regDate;
	String repRatDate;
	String repRlsDate;
	String runtime;
	String salesAcc;
	String screenArea;
	String screenCnt;
	String soundtrack;
	String statDate;
	String statSouce;
	String[] stlls;
	String themeSong;
	String title;
	String titleEng;
	String titleEtc;
	String titleOrg;
	String type;
	String use;

	public String getALIAS() {
		return ALIAS;
	}

	public String getAudiAcc() {
		return audiAcc;
	}

	public String getAwards1() {
		return Awards1;
	}

	public String getAwards2() {
		return Awards2;
	}

	public String getCompany() {
		return company;
	}

	public String getDOCID() {
		return DOCID;
	}

	public String getEpisodes() {
		return episodes;
	}

	public String getfLocation() {
		return fLocation;
	}

	public String getGenre() {
		return genre;
	}

	public String getKeywords() {
		return keywords;
	}

	public String getKmdbUrl() {
		return kmdbUrl;
	}

	public String getModDate() {
		return modDate;
	}

	public String getMovieId() {
		return movieId;
	}

	public String getMovieSeq() {
		return movieSeq;
	}

	public String getNation() {
		return nation;
	}

	public String getOpenThtr() {
		return openThtr;
	}

	public String[] getPosters() {
		return posters;
	}

	public String getProdYear() {
		return prodYear;
	}

	public String getRatedYn() {
		return ratedYn;
	}

	public String getRating() {
		return rating;
	}

	public String getRegDate() {
		return regDate;
	}

	public String getRepRatDate() {
		return repRatDate;
	}

	public String getRepRlsDate() {
		return repRlsDate;
	}

	public String getRuntime() {
		return runtime;
	}

	public String getSalesAcc() {
		return salesAcc;
	}

	public String getScreenArea() {
		return screenArea;
	}

	public String getScreenCnt() {
		return screenCnt;
	}

	public String getSoundtrack() {
		return soundtrack;
	}

	public String getStatDate() {
		return statDate;
	}

	public String getStatSouce() {
		return statSouce;
	}

	public String[] getStlls() {
		return stlls;
	}

	public String getThemeSong() {
		return themeSong;
	}

	public String getTitle() {
		return title;
	}

	public String getTitleEng() {
		return titleEng;
	}

	public String getTitleEtc() {
		return titleEtc;
	}

	public String getTitleOrg() {
		return titleOrg;
	}

	public String getType() {
		return type;
	}

	public String getUse() {
		return use;
	}

	public void setALIAS(String aLIAS) {
		ALIAS = aLIAS;
	}

	public void setAudiAcc(String audiAcc) {
		this.audiAcc = audiAcc;
	}

	public void setAwards1(String awards1) {
		Awards1 = awards1;
	}

	public void setAwards2(String awards2) {
		Awards2 = awards2;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public void setDOCID(String dOCID) {
		DOCID = dOCID;
	}

	public void setEpisodes(String episodes) {
		this.episodes = episodes;
	}

	public void setfLocation(String fLocation) {
		this.fLocation = fLocation;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public void setKmdbUrl(String kmdbUrl) {
		this.kmdbUrl = kmdbUrl;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public void setMovieId(String movieId) {
		this.movieId = movieId;
	}

	public void setMovieSeq(String movieSeq) {
		this.movieSeq = movieSeq;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public void setOpenThtr(String openThtr) {
		this.openThtr = openThtr;
	}

	public void setPosters(String posters) {

		this.posters = posters.split("\\|");
		if(this.posters.length == 0) {
			this.posters[0] = "resource/images/흑백로고.png";
		}
	}

	public void setProdYear(String prodYear) {
		this.prodYear = prodYear;
	}

	public void setRatedYn(String ratedYn) {
		this.ratedYn = ratedYn;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public void setRepRatDate(String repRatDate) {
		this.repRatDate = repRatDate;
	}

	public void setRepRlsDate(String repRlsDate) {
		this.repRlsDate = repRlsDate;
	}

	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}

	public void setSalesAcc(String salesAcc) {
		this.salesAcc = salesAcc;
	}

	public void setScreenArea(String screenArea) {
		this.screenArea = screenArea;
	}

	public void setScreenCnt(String screenCnt) {
		this.screenCnt = screenCnt;
	}

	public void setSoundtrack(String soundtrack) {
		this.soundtrack = soundtrack;
	}

	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}

	public void setStatSouce(String statSouce) {
		this.statSouce = statSouce;
	}

	public void setStlls(String stlls) {
		this.stlls = stlls.split("\\|");
	}

	public void setThemeSong(String themeSong) {
		this.themeSong = themeSong;
	}

	public void setTitle(String title) {
		
		String str = title.replaceAll("!HS", "").replaceAll("!HE", "").replaceAll("\\s+", " ").trim();
		
		this.title = str;
	}

	public void setTitleEng(String titleEng) {
		this.titleEng = titleEng;
	}

	public void setTitleEtc(String titleEtc) {
		this.titleEtc = titleEtc;
	}

	public void setTitleOrg(String titleOrg) {
		this.titleOrg = titleOrg;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setUse(String use) {
		this.use = use;
	}

	/*------------------------------------------------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------------------------------------------------*/
	/*----------------------------------------------------------------내부 클래스------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------------------------------------------------*/

	public class actor {
		public actor(String actorEnNm, String actorId, String actorNm) {
			super();
			this.actorEnNm = actorEnNm;
			this.actorId = actorId;
			this.actorNm = actorNm;
		}

		public actor() {
		}

		String actorEnNm;
		String actorId;
		String actorNm;

		public String getActorEnNm() {
			return actorEnNm;
		}

		public String getActorId() {
			return actorId;
		}

		public String getActorNm() {
			return actorNm;
		}

		public void setActorEnNm(String actorEnNm) {
			this.actorEnNm = actorEnNm;
		}

		public void setActorId(String actorId) {
			this.actorId = actorId;
		}

		public void setActorNm(String actorNm) {
			this.actorNm = actorNm;
		}
	}

	public class director {
		public director(String directorEnNm, String directorId, String directorNm) {
			super();
			this.directorEnNm = directorEnNm;
			this.directorId = directorId;
			this.directorNm = directorNm;
		}

		public director() {
		}

		String directorEnNm;
		String directorId;
		String directorNm;

		public String getDirectorEnNm() {
			return directorEnNm;
		}

		public String getDirectorId() {
			return directorId;
		}

		public String getDirectorNm() {
			return directorNm;
		}

		public void setDirectorEnNm(String directorEnNm) {
			this.directorEnNm = directorEnNm;
		}

		public void setDirectorId(String directorId) {
			this.directorId = directorId;
		}

		public void setDirectorNm(String directorNm) {
			this.directorNm = directorNm;
		}
	}

	public class plot {
		public plot(String plotLang, String plotText) {
			super();
			this.plotLang = plotLang;
			this.plotText = plotText;
		}

		public plot() {
			// TODO Auto-generated constructor stub
		}

		String plotLang;
		String plotText;

		public String getPlotLang() {
			return plotLang;
		}

		public String getPlotText() {
			return plotText;
		}

		public void setPlotLang(String plotLang) {
			this.plotLang = plotLang;
		}

		public void setPlotText(String plotText) {
			this.plotText = plotText;
		}
	}

	public class rating {
		public rating(String ratingDate, String ratingGrade, String ratingMain, String ratingNo, String releaseDate,
				String runtime) {
			super();
			this.ratingDate = ratingDate;
			this.ratingGrade = ratingGrade;
			this.ratingMain = ratingMain;
			this.ratingNo = ratingNo;
			this.releaseDate = releaseDate;
			this.runtime = runtime;
		}

		public rating() {
			// TODO Auto-generated constructor stub
		}

		String ratingDate;
		String ratingGrade;
		String ratingMain;
		String ratingNo;
		String releaseDate;
		String runtime;

		public String getRatingDate() {
			return ratingDate;
		}

		public String getRatingGrade() {
			return ratingGrade;
		}

		public String getRatingMain() {
			return ratingMain;
		}

		public String getRatingNo() {
			return ratingNo;
		}

		public String getReleaseDate() {
			return releaseDate;
		}

		public String getRuntime() {
			return runtime;
		}

		public void setRatingDate(String ratingDate) {
			this.ratingDate = ratingDate;
		}

		public void setRatingGrade(String ratingGrade) {
			this.ratingGrade = ratingGrade;
		}

		public void setRatingMain(String ratingMain) {
			this.ratingMain = ratingMain;
		}

		public void setRatingNo(String ratingNo) {
			this.ratingNo = ratingNo;
		}

		public void setReleaseDate(String releaseDate) {
			this.releaseDate = releaseDate;
		}

		public void setRuntime(String runtime) {
			this.runtime = runtime;
		}
	}

	public class staff {
		public staff(String staffEnNm, String staffEtc, String staffId, String staffNm, String staffRole,
				String staffRoleGroup) {
			super();
			this.staffEnNm = staffEnNm;
			this.staffEtc = staffEtc;
			this.staffId = staffId;
			this.staffNm = staffNm;
			this.staffRole = staffRole;
			this.staffRoleGroup = staffRoleGroup;
		}

		public staff() {
			// TODO Auto-generated constructor stub
		}

		String staffEnNm;
		String staffEtc;
		String staffId;
		String staffNm;
		String staffRole;
		String staffRoleGroup;

		public String getStaffEnNm() {
			return staffEnNm;
		}

		public String getStaffEtc() {
			return staffEtc;
		}

		public String getStaffId() {
			return staffId;
		}

		public String getStaffNm() {
			return staffNm;
		}

		public String getStaffRole() {
			return staffRole;
		}

		public String getStaffRoleGroup() {
			return staffRoleGroup;
		}

		public void setStaffEnNm(String staffEnNm) {
			this.staffEnNm = staffEnNm;
		}

		public void setStaffEtc(String staffEtc) {
			this.staffEtc = staffEtc;
		}

		public void setStaffId(String staffId) {
			this.staffId = staffId;
		}

		public void setStaffNm(String staffNm) {
			this.staffNm = staffNm;
		}

		public void setStaffRole(String staffRole) {
			this.staffRole = staffRole;
		}

		public void setStaffRoleGroup(String staffRoleGroup) {
			this.staffRoleGroup = staffRoleGroup;
		}

	}

	public class vod {
		public vod(String vodClass, String vodUrl) {
			super();
			this.vodClass = vodClass;
			this.vodUrl = vodUrl;
		}

		public vod() {
			// TODO Auto-generated constructor stub
		}

		String vodClass;
		String vodUrl;

		public String getVodClass() {
			return vodClass;
		}

		public String getVodUrl() {
			return vodUrl;
		}

		public void setVodClass(String vodClass) {
			this.vodClass = vodClass;
		}

		public void setVodUrl(String vodUrl) {
			this.vodUrl = vodUrl;
		}

	}

}
