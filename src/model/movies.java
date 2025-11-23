package model;
import java.sql.Date;
public class movies {
    private String movieId;
    private String movieName;
    private String type;
    private int duration;
    private String description;
    private Date releaseDate;
    public Movie(){}
    public Movie(String movieId, String movieName, String type, int duration, String description, Date releaseDate) {
        this.movieId = movieId;
        this.movieName = movieName;
        this.type = type;
        this.duration = duration;
        this.description = description;
        this.releaseDate = releaseDate;
    }
    // Getter và Setter
    public String getMovieId() { return movieId; }
    public void setMovieId(String movieId) { this.movieId = movieId; }

    public String getMovieName() { return movieName; }
    public void setMovieName(String movieName) { this.movieName = movieName; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getReleaseDate() { return releaseDate; }
    public void setReleaseDate(Date releaseDate) { this.releaseDate = releaseDate; }
    @Override
    public String toString() {
        return movieName;
    }
}
