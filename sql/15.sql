/*
 * Compute the total revenue for each film.
 */
select title, coalesce(sum(amount), 0.00) as revenue
from film
left join inventory using (film_id)
left join rental using (inventory_id)
left join payment using (rental_id)
group by title
order by revenue desc;
