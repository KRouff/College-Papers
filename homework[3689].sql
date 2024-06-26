select * from publishers;
select * from authors;
select * from titles;
select * from sales;
select * from stores;

--1 For each book published by New Moon Books, list the book title and price. 
select p.pub_name, t.title, t.price from publishers p join titles t on p.pub_id=t.pub_id and p.pub_name='New Moon Books';

--2 Turn Question 1 into a view named NewMoonBooks.
drop procedure NewMoonBooks go create procedure NewMoonBooks @title varchar(100), @price int, @pub_name varchar(100)
AS BEGIN SELECT p.pub_name, t.title, t.price from publishers p join titles t on p.pub_id=t.pub_id and p.pub_name=@pub_name;

--3 Query this view for all books that cost more than $8.
select p.pub_name, t.title, t.price from publishers p join titles t on p.pub_id=t.pub_id and t.price>=8;

--4. List the book title and price of each book published by New Moon Books that has a book price of at least $10. 
select p.pub_name, t.title, t.price from publishers p join titles t on p.pub_id=t.pub_id and p.pub_name='New Moon Books' and t.price>=10;

--5. List the book title for each book that has the type psychology and that is published by Binnet & Hardley.
select p.pub_name, t.title, t.type from publishers p join titles t on p.pub_id=t.pub_id and p.pub_name='Binnet & Hardley' and t.type='psychology';

--6. Find the book title for each book written by Ann Dull. Use the IN operator in your query. 
select titles.title from titles join titleauthor on titles.title_id=titleauthor.title_id join authors on titleauthor.au_id=authors.au_id where authors.au_fname in ('Ann') and authors.au_lname in ('Dull');

--7. Repeat Exercise 6, but this time use the EXISTS operator in your query. 
SELECT t.title FROM titles t join titleauthor ta on t.title_id=ta.title_id WHERE EXISTS (SELECT a.au_id FROM authors a WHERE ta.au_id=a.au_id and a.au_fname in ('Ann') and a.au_lname in ('Dull')); 

--8. Find the book title for each book sold at Doc-U-Mat and written by Charlene Locksley. 
select t.title, au.au_fname, au_lname, s.stor_name from stores s, titles t join titleauthor ta on t.title_id=ta.title_id join authors au on ta.au_id=au.au_id where au.au_fname='Charlene' and au.au_lname='Locksley' and s.stor_name='Doc-U-Mat: Quality Laundry and Books'

--9. List the title for each pair of books that have the same price. ( For example, one such pair would be �Fifty Years in Buckingham Palace Kitchens� and �Cooking with Computers�, because the price of both books is $11.95.) The first book code listed should be the major sort key, and the second book code should be the minor sort key.   Exclude duplicates.

--10. Find the book title and author last name for all books published in the USA. 
select titles.title, publishers.country from titles left outer join publishers on titles.pub_id=publishers.pub_id where publishers.country='USA';

--11. Repeat Exercise 10, but this time list only business books. 
select titles.title, titles.type, publishers.country from titles left outer join publishers on titles.pub_id=publishers.pub_id where publishers.country='USA' and titles.type='business';

--12. Find the book title for each book whose price is more than $10 or that was published in Boston. 
select titles.title, titles.price, publishers.city from titles, publishers where price>='10' or city='Boston';

--13. Find the book title for each book whose price is more than $10 and that was published in Boston. 
select titles.title, titles.price, publishers.city from titles, publishers where price>='10' and city='Boston';

--14. Find the book title for each book whose price is more than $10 but that was not published in Boston.
select titles.title, titles.price, publishers.city from titles, publishers where price>='10' and NOT city='Boston';

--15. Find the book title for each book whose price is greater than the book price of every book that has the type business. 
SELECT * FROM titles WHERE price=(select max(price) from titles t where t.type='business')

--16. Find the book title for each book whose price is greater than the price of at least one book that has the type business. 
select MAX(titles.price), titles.title from titles where type='business' group by titles.type, titles.title;

--17. List the book title and qty (sales table) for each book sold at Barnum�s . Be sure each book is included, regardless of whether there are any copies of the book currently sold by Barnum�s. Order the output by title_id.
select t.title, coalesce(s.qty,0) from titles t left outer join sales s on t.title_id=s.title_id left outer join stores st on st.stor_id=s.stor_id and st.stor_name='Barnum''s'