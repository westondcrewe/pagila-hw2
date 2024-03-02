/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
select title
from film
left join (
        select distinct title from film
        join inventory using (film_id)
        join rental using (inventory_id)
        join customer using (customer_id)
        join address using (address_id)
        join city using (city_id)
        join country using (country_id)
        where country = 'United States'
) as domestic using (title)
where domestic.title is null
and film.film_id in (
        select film_id
        from inventory)
order by title;

