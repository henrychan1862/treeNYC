-- retrieve roads within New York City
WITH 
boundaries AS (
    select county_name, county_geom, int_point_geom
    from `bigquery-public-data.geo_us_boundaries.counties`
    where county_name in ('Bronx', 'Kings', 'New York', 'Queens', 'Richmond') and state_fips_code = '36'),
roads as (
    SELECT full_name as road_name, road_geom
    FROM `bigquery-public-data.geo_us_roads.all_roads_36`)
SELECT *
FROM boundaries
JOIN roads
ON ST_WITHIN(roads.road_geom, boundaries.county_geom)

-- retrieve trees records in NYC, surveyed in 2015
SELECT tree_id, block_id, tree_dbh, health, address, boroname, latitude, longitude x_sp, y_sp
FROM `bigquery-public-data.new_york_trees.tree_census_2015`
WHERE status = 'Alive'