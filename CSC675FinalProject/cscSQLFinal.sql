SELECT Track.length, Album.title, Album.year_released, Album.title FROM Track INNER JOIN Album ON Track.album=Album.album_id;