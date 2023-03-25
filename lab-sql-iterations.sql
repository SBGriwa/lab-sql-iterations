USE sakila;
drop procedure if exists total_bussiness_each_store;
drop procedure if exists total_sales_valuee;

-- Write a query to find what is the total business done by each store.
select s.store_id, sum(p.amount) as total_amount from staff s
join payment p on s.staff_id = p.staff_id
group by s.store_id;


-- Convert the previous query into a stored procedure.
DELIMITER //
create procedure total_bussiness_each_store()
begin
select s.store_id, sum(p.amount) as total_amount from staff s
join payment p on s.staff_id = p.staff_id
group by s.store_id;
end //
DELIMITER ;

call total_bussiness_each_store();

drop procedure if exists total_bussiness_each_store;


-- Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
DELIMITER //
create procedure total_bussiness_each_store(in x int)
begin
select s.store_id, sum(p.amount) from staff s
join payment p on s.staff_id = p.staff_id
where store_id = x
group by s.store_id;
end //
DELIMITER ;

call total_bussiness_each_store(1);

drop procedure if exists total_bussiness_each_store;


-- Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.
DELIMITER //
create procedure total_bussiness_each_store(in x int)
begin
declare total_sales_value float default 0.0;
select sum(p.amount) as total_amount into total_sales_value from staff s
join payment p on s.staff_id = p.staff_id
where store_id = x
group by s.store_id;

select total_sales_value;

end //
DELIMITER ;

call total_bussiness_each_store(1);

drop procedure if exists total_bussiness_each_store;


-- In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.
DELIMITER //
create procedure total_bussiness_each_store(in param1 int, out param2 float, out param3 varchar(20))
begin
declare total_sales_value float default 0.0;
declare flag varchar(20) default "";
select sum(p.amount) as total_amount into total_sales_value from staff s
join payment p on s.staff_id = p.staff_id
where store_id = param1
group by s.store_id;

select total_sales_value;

 if total_sales_value > 30000 then
    set flag = 'green_flag';
  else
    set flag = 'red_flag';
  end if;
  
  select total_sales_value into param2;
  select flag into param3;
  
end //
DELIMITER ;

call total_bussiness_each_store(1, @total_sales_value, @flag_value);