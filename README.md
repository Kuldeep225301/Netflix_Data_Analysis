#  Netflix Data Analysis Using SQL

## 📌 Project Overview

Netflix's catalog spans thousands of movies and TV shows across countries, genres, and decades. This project uses SQL to explore that catalog and answer practical questions: *What kind of content does Netflix have the most of? Which countries and directors produce the most content? How has the library grown over time?*

---

## 🗂️ Dataset

| Detail | Info |
|---|---|
| **Total Records** | 8,790 |
| **Total Tables** | 1 |
| **Database** | MySQL |

### Table Schema

| Table | Key Columns |
|---|---|
| `netflix_data` | `type`, `title`, `director`, `country`, `date_added`, `release_year`, `rating`, `duration`, `listed_in` |

### Data Cleaning

- Converted `date_added` from text (`MM/DD/YYYY`) to a proper SQL `DATE` type using `STR_TO_DATE`, then altered the column type.

---

## 🛠️ Tools & SQL Concepts Used

- **Database:** MySQL
- **Aggregations:** `COUNT`, `GROUP BY`, `ORDER BY`, `HAVING`, `LIMIT`
- **String Functions:** `SUBSTRING_INDEX`, `CAST`, `LIKE`
- **Date Functions:** `STR_TO_DATE`, `DATE_FORMAT`
- **Window Functions:** `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)`
- **Data Cleaning:** `ALTER TABLE`, `UPDATE`

---

## ❓ Business Questions Solved

| # | Question |
|---|---|
| 1 | What is the total number of Movies and TV Shows on Netflix? |
| 2 | Which country has produced the most content? (Top 5) |
| 3 | How many movies and TV shows were released in 2020? |
| 4 | What are the titles of all movies directed by Kirsten Johnson? |
| 5 | Which content rating is the most common on Netflix? |
| 6 | Which TV Shows have 5 or more seasons? |
| 7 | Which movies from India belong to the Comedies category? |
| 8 | How many new shows/movies were released each year? |
| 9 | Who are the top 5 directors by number of movies directed? |
| 10 | In which year did Netflix add the most content to the platform? |
| 11 | Which are the 5 oldest movies released in India on Netflix? |
| 12 | Which Documentaries were released in 2015? |
| 13 | Which movie has the longest duration on Netflix? |
| 14 | What is the most recently released movie for each country? |
| 15 | In which years were more than 50 Indian movies released? |

---

## 💻 Sample Queries

### Data Cleaning: Fixing `date_added`
```sql
UPDATE netflix_data
SET date_added = STR_TO_DATE(date_added, '%m/%d/%Y')
WHERE date_added LIKE '%/%/%';

ALTER TABLE netflix_data
MODIFY date_added DATE;
```

### Movies vs TV Shows
```sql
SELECT type, COUNT(*) AS Total_Counts
FROM netflix_data
GROUP BY type;
```

### Top 5 Directors by Movie Count
```sql
SELECT director, COUNT(*) AS Total_Movies
FROM netflix_data
WHERE type = 'Movie' AND director != ''
GROUP BY director
ORDER BY Total_Movies DESC
LIMIT 5;
```

### Most Recent Movie per Country (Window Function)
```sql
WITH Rnks AS (
    SELECT country, title, release_year,
           ROW_NUMBER() OVER (PARTITION BY country ORDER BY release_year DESC) AS rnk
    FROM netflix_data
    WHERE type = 'Movie' AND country != ''
)
SELECT country, title AS Latest_Movie, release_year
FROM Rnks
WHERE rnk = 1;
```

### Longest Movie by Duration
```sql
SELECT title,
       CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS Duration_Minutes
FROM netflix_data
WHERE type = 'Movie'
ORDER BY Duration_Minutes DESC
LIMIT 1;
```

> 📄 The complete set of queries is in [`Netflix_SQL_Project.sql`](./Netflix_SQL_Project.sql).

---

## 📊 Results

### 🔑 Key Metrics
| Metric | Result |
|---|---|
| 🎥 Total Movies | **6,126** |
| 📺 Total TV Shows | **2,664** |
| 📅 Content released in 2020 | **953** |
| 🏆 Most common rating | **TV-14 — 2,157 titles** |
| ⏱️ Longest movie | **Black Mirror: Bandersnatch — 312 minutes** |
| 📈 Year with most content added | **2019 — 2,016 titles** |

### 🌍 Top 5 Countries by Content
| Rank | Country | Total Content |
|---|---|---:|
| 1 | United States | 3,240 |
| 2 | India | 1,057 |
| 3 | United Kingdom | 638 |
| 4 | Pakistan | 421 |
| 5 | *(blank/unlisted)* | 287 |

### 🎬 Top 5 Directors by Movies Directed
| Rank | Director | Movies |
|---|---|---:|
| 1 | Rajiv Chilaka | 19 |
| 2 | Raúl Campos & Jan Suter | 18 |
| 3 | Suhas Kadav | 16 |
| 4 | Marcus Raboy | 15 |
| 5 | Jay Karas | 14 |

### ⭐ Content Rating Breakdown
| Rating | Total Titles |
|---|---:|
| TV-14 | 2,157 |
| TV-PG | 861 |
| R | 799 |
| PG-13 | 490 |
| TV-Y7 | 333 |
| TV-Y | 306 |
| PG | 287 |
| TV-G | 220 |
| NR | 79 |
| G | 41 |
| TV-Y7-FV | 6 |

### 📅 Content Released Per Year (Top 10)
| Year | Total Releases |
|---|---:|
| 2021 | 592 |
| 2020 | 953 |
| 2019 | 1,030 |
| 2018 | 1,146 |
| 2017 | 1,030 |
| 2016 | 901 |
| 2015 | 555 |
| 2014 | 352 |
| 2013 | 286 |
| 2012 | 236 |

### 🇮🇳 India: Years with 50+ Movies Released
| Year | Movies |
|---|---:|
| 2017 | 105 |
| 2018 | 94 |
| 2019 | 88 |
| 2016 | 74 |
| 2013 | 59 |
| 2020 | 62 |
| 2015 | 58 |
| 2014 | 50 |

### 🇮🇳 5 Oldest Indian Movies on Netflix
| Title | Release Year |
|---|---:|
| Ujala | 1959 |
| Singapore | 1960 |
| Professor | 1962 |
| Sangam | 1964 |
| Amrapali | 1966 |

### 🌎 Most Recent Movie Per Country (Sample)
| Country | Latest Movie | Year |
|---|---|---:|
| Argentina | Soy Rada: Serendipity | 2021 |
| Australia | Penguin Bloom | 2021 |
| Austria | The Strange House | 2020 |
| Bangladesh | Sincerely Yours - Dhaka | 2018 |
| Belgium | Misha and the Wolves | 2021 |
| Brazil | Carnaval | 2021 |
| Bulgaria | Day of the Dead: Bloodline | 2018 |
| Cambodia | First They Killed My Father | 2017 |
| Cameroon | The Fisherman's Diary | 2020 |
| Canada | Vivo | 2021 |

### 📺 TV Shows with 5+ Seasons (Sample)
| Title | Seasons |
|---|---:|
| The Great British Baking Show | 9 |
| Nailed It | 6 |
| The Flash | 7 |
| Club Friday The Series 8 | 8 |
| Club Friday The Series 6 | 9 |
| Club Friday The Series 7 | 7 |
| Men on a Mission | 6 |
| Call the Midwife | 9 |
| Supernatural | 15 |
| Arrow | 8 |

### 🎥 Only Kirsten Johnson Movie Found
**Dick Johnson Is Dead**

---

## 💡 Key Insights

- **Movies dominate the catalog:** at 6,126 titles vs. 2,664 TV Shows, movies make up about **70%** of everything on Netflix.
- **The US and India lead content production**, together accounting for roughly **49%** of the top-5-country total — but 287 titles have no country listed, a data-quality gap worth noting.
- **TV-14 is the dominant rating** (2,157 titles, ~25% of the catalog), suggesting Netflix's library skews toward a teen/adult audience rather than young children.
- **2018 was the peak release year** (1,146 titles), while **2019 was the peak year for titles being added to the platform** (2,016) — these are different things, since older content can be added in a later year.
- **India's movie output surged between 2016–2019**, peaking at 105 movies in 2017, before slowing in 2020.
- **Black Mirror: Bandersnatch**, an interactive film, is the longest "movie" at 312 minutes — a reflection of its branching-narrative format rather than a typical runtime.

---

## 🎯 Business Recommendations

1. **Diversify content from underrepresented regions** — the long tail of countries (beyond the top 5) likely has thin libraries and opportunity for growth.
2. **Clean the `country` field** — 287 titles have missing/blank country data, which limits accurate regional analysis.
3. **Expand TV Show offerings** — movies outnumber TV shows 2.3:1, but long-running shows (5+ seasons) tend to drive retention.
4. **Leverage top directors** like Rajiv Chilaka and Raúl Campos & Jan Suter for future content deals, given their prolific output.
5. **Re-promote older catalog hits** — content added in peak years like 2019 may include older titles worth resurfacing to subscribers.

---

## 📁 Repository Structure

```
├── Netflix_SQL_Project.sql   # All 15 SQL queries + data cleaning
├── screenshots/              # Query output screenshots
└── README.md                 # Project documentation
```

---

## 🚀 How to Run

1. Clone this repository
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   ```
2. Create the `netflix_data` table in MySQL and import the dataset (8,790 records).
3. Open `Netflix_SQL_Project.sql` in MySQL Workbench and run the queries in order (data cleaning queries first).

---

## 📚 Skills Demonstrated

`SQL` · `Data Cleaning` · `Data Analysis` · `Window Functions` · `String & Date Functions` · `Business Intelligence`

---

## 👤 Author

**Your Name**
🔗 [LinkedIn](https://www.linkedin.com/in/kuldeep-kumar-a82833269/) · 💻 [GitHub](https://github.com/Kuldeep225301/Netflix_Data_Analysis)

⭐ If you found this project useful, please give it a star!
