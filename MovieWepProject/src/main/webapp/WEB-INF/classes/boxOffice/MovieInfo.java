package boxOffice;
	
	import java.util.List;
	
	public class MovieInfo {
	    private String movieTitle;
	    private String directorName;
	    private String nation;
	    private String plot;
	    private String repRlsDate;
	    private String genre;
	    private String prodYear;
	    
	
		public String getRepRlsDate() {
			return repRlsDate;
		}
	
		public void setRepRlsDate(String repRlsDate) {
			this.repRlsDate = repRlsDate;
		}
	
		private List<String> posters;
		private List<String> actors;
	
	    public List<String> getActors() {
			return actors;
		}
	
		public void setActors(List<String> actors) {
			this.actors = actors;
		}
	
		public MovieInfo(String movieTitle, String directorName, String nation, String plot,String repRlsDate,String genre, String prodYear) {
	        this.movieTitle = movieTitle;
	        this.directorName = directorName;
	        this.nation = nation;
	        this.plot = plot;
	        this.repRlsDate = repRlsDate;
	        this.genre= genre;
	        this.prodYear=prodYear;
	    }
	
	    public String getMovieTitle() {
	        return movieTitle;
	    }
	
	    public String getPlot() {
			return plot;
		}
	
		public void setPlot(String plot) {
			this.plot = plot;
		}
		
	    public void setMovieTitle(String movieTitle) {
	        this.movieTitle = movieTitle;
	    }
	
	    public String getDirectorName() {
	        return directorName;
	    }
	
	    public void setDirectorName(String directorName) {
	        this.directorName = directorName;
	    }
	
	    public String getNation() {
	        return nation;
	    }
	
	    public void setNation(String nation) {
	        this.nation = nation;
	    }
	    
	    public String getGenre() {
	        return genre;
	    }
	    
	    public void setGenre(String genre) {
	        this.genre= genre;
	    }
	
	    public String getProdYear() {
			return prodYear;
		}
	
		public void setProdYear(String prodYear) {
			this.prodYear = prodYear;
		}
	
		public List<String> getPosters() {
	        return posters;
	    }
	
	    public void setPosters(List<String> posters) {
	        this.posters = posters;
	    }
	
	}