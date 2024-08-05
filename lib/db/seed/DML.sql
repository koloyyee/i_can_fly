-- admins
INSERT INTO admins (email, password, createdAt) VALUES ('peter@example.com', 'password', '2023-01-01T00:00:00');
INSERT INTO admins (email, password, createdAt) VALUES ('paul@example.com', 'password', '2023-01-01T00:00:00');
INSERT INTO admins (email, password, createdAt) VALUES ('mary@example.com', 'password', '2023-01-01T00:00:00');
INSERT INTO admins (email, password, createdAt) VALUES ('bill@example.com', 'password', '2023-01-01T00:00:00');
INSERT INTO admins (email, password, createdAt) VALUES ('john@example.com', 'password', '2023-01-01T00:00:00');


-- airlines 
INSERT INTO airlines (code,companyName) VALUES
	 ('AA','American Airlines'),
	 ('UA','United Airlines'),
	 ('DL','Delta Air Lines'),
	 ('SWA','Southwest Airlines'),
	 ('BA','British Airways');

--  airplane
INSERT INTO airplanes ("type",capacity,maxSpeed,maxRange) VALUES
	 ('Boeing 747',416,988,13000),
	 ('Airbus A380',555,1020,15200),
	 ('Boeing 777',396,905,17400),
	 ('Airbus A350',440,945,16100),
	 ('Boeing 737',215,842,12300);

-- customers
INSERT INTO customers (
  name, email, password, firstName, lastName, birthday, address, createdAt
) VALUES (
  'John Doe', 'john.doe@example.com', 'password123', 'John', 'Doe', '1985-05-15', '123 Main St, Anytown, USA', '2023-10-01T12:00:00'
);

INSERT INTO customers (
  name, email, password, firstName, lastName, birthday, address, createdAt
) VALUES (
  'Jane Smith', 'jane.smith@example.com', 'securepassword', 'Jane', 'Smith', '1990-08-25', '456 Elm St, Othertown, USA', '2023-10-01T12:00:00'
);

-- flights
INSERT INTO flights (
  airplaneType, arrivalCity, departureCity, departureDateTime, arrivalDateTime
) VALUES (
  'Boeing 737', 'Los Angeles', 'New York', '2023-12-01T10:00:00', '2023-12-01T14:00:00'
);

INSERT INTO flights (
  airplaneType, arrivalCity, departureCity, departureDateTime, arrivalDateTime
) VALUES (
  'Airbus A320', 'Chicago', 'San Francisco', '2023-12-02T08:00:00', '2023-12-02T12:00:00'
);