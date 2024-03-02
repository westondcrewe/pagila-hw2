/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

select rank, title, revenue, "total revenue",
case
	when 100*"total revenue"/sum(revenue) over () = 100 then trim('100.00')
	else trim(to_char(100*"total revenue"/sum(revenue) over (), '00.00')) end as "percent revenue"
from (
	select rank() over (
        order by coalesce(sum(amount), 0.00) desc
        ) as "rank",
        title,
        coalesce(sum(amount), 0.00) as "revenue",
        sum(coalesce(sum(amount), 0.00)) over (
                order by coalesce(sum(amount), 0.00) desc
        ) as "total revenue"
	from film
	left join inventory using (film_id)
	left join rental using (inventory_id)
	left join payment using (rental_id)
	group by title
) as sub
order by rank, title;
