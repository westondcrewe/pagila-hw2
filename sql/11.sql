/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */
select distinct actor.first_name || ' ' || actor.last_name as "Actor Name" from actor
join film_actor using (actor_id)
join film using (film_id)
where 'Behind the Scenes' in (
	select unnest(special_features)
	from film as f1
	where f1.film_id = film.film_id
)
order by "Actor Name";
