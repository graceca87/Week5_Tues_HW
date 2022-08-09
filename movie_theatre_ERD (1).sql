
-- Create customer table
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100),
	rewards_member BOOLEAN);

-- Create ticket table
CREATE TABLE ticket(
	ticket_id SERIAL PRIMARY KEY,
	day_ DATE,
	showtime TIME,
	movie_id INTEGER,
	child_or_senior BOOLEAN,
	price NUMERIC(4,2),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id));
--	theatre_id INTEGER NOT NULL
--	FOREIGN KEY theatre_id REFERENCES theatre(theatre_id)   -- need to add in after creating theater table

-- Create concession table
CREATE TABLE concession(
	concession_id SERIAL PRIMARY KEY, 
	amount_spent NUMERIC(5,2),
	popcorn BOOLEAN,
	drink BOOLEAN,
	candy BOOLEAN,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id));

-- Create movie table
CREATE TABLE movie(
	movie_id SERIAL PRIMARY KEY,
	title VARCHAR(200),
	release_year SMALLINT,
	rating VARCHAR(5),
	theatre_id INTEGER NOT NULL,
	concession_id INTEGER NOT NULL,
--	FOREIGN KEY(theatre_id) REFERENCES theatre(theatre_id)),         -- need to add in after creating theatre table
	FOREIGN KEY(concession_id) REFERENCES concession(concession_id));

-- Create theatre table
CREATE TABLE theatre(
	theatre_id SERIAL PRIMARY KEY,
	theatre_name VARCHAR(50),
	address VARCHAR(200),
	concession_id INTEGER NOT NULL,
	FOREIGN KEY(concession_id) REFERENCES concession(concession_id)); 


ALTER TABLE ticket 
ADD COLUMN theatre_id INTEGER NOT NULL;

ALTER TABLE ticket 
ADD FOREIGN KEY(theatre_id) REFERENCES theatre(theatre_id);

ALTER TABLE movie
ADD FOREIGN KEY(concession_id) REFERENCES concession(concession_id); <-- accidentally added this twice to movie table

-- Need to drop one concession_id foreign key from movie table
ALTER TABLE movie 
DROP CONSTRAINT concession_id; <-- This is how I'm seeing you should do it via google for postgresql but it isn't working  

ALTER TABLE movie 
DROP FOREIGN KEY(concession_id);  <-- This also doesn't work

--Need to add foreign key for theatre_id to movie table
ALTER TABLE movie
ADD FOREIGN KEY(theatre_id) REFERENCES theatre(theatre_id);








