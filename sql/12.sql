/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */
select bts.title
from (
	select title 
	from film
	where 'Behind the Scenes' in (
		select unnest(special_features) 
		from film f1
		where film.film_id = f1.film_id
	)
) as bts
join (
	select title
	from film
	where 'Trailers' in (
		select unnest(special_features)
		from film f2
		where film.film_id = f2.film_id
	)
) as trailer
on bts.title = trailer.title
order by bts.title;
