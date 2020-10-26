INSERT INTO Users(Type, Email, Password, ID, FirstName, LastName, phone)
VALUES
(0,"user@gmail.com", "Test123",00134,"Sacred","User","(678)456-3311"),
(1,"Employee@gmail.com", "P@ssw0rd",331412, "Chosen", "Employee","4048882222"),
(2,"Admin@gmail.com", "!secretP@ss",234411, "Privileged", "Admin","760-217-8632"),
(3,"SystemAdmin@books.com", "BooksRUs",40502020, "Store", "Owner", "404-888-2222");


INSERT INTO Address(User, Street, City, State, Zipcode)
VALUES
("Employee@gmail.com", "105 Morton Walk Drive", "Johns Creek", "GA", 30022),
("SystemAdmin@books.com", "394 Oconee Street", "Athens", "GA", 30601);

INSERT INTO Payment(User, Type, Number, Expiration, CCV)
VALUES
("Admin@gmail.com","Visa", "1234-2222-1245-3333","2022-10-01", 637),
("Employee@gmail.com", "Amex", "5444111145212908","2025-08-01", 910);

INSERT INTO Promotions(User, Code, Message, Discount, Start, End)
VALUES
(234411, "A124B245C222D111", "Happy Halloween! 20% your next purchase!", 20, "2020-10-01","2020-10-31"),
(331412, "M234JULGYTRE", "50% your next purchase!", 10, "2020-09-01","2020-12-31");

INSERT INTO Orders(User, Address, Payment, Confirmation, Total, Date)
VALUES
(234411, 1, 1, 22146123, 12.35, "2020-10-25"),
(234411, 2, 2, 22146123, 56.95, "2020-10-25");

INSERT INTO CATEGORIES(Genre)
VALUES
("Action & Adventure"),
("Children's"),
("Classic"),
("Drama"),
("Fantasy"),
("Graphic Novel"),
("Horror"),
("Mystery & Crime"),
("Non-Fiction"),
("Romance"),
("Science Fiction");

INSERT INTO Books(ISBN, Title, Author, Edition, Publisher, Year, Genre, Image, MinThreshold, BuyPrice, SellPrice)
VALUES
("9781938235719","A Measure of Belonging: Twenty-One Writers of Color on the New American South (Paperback)",
"Ruuman Alam", 1, "Ecco","2020", 1, "https://images.booksense.com/images/books/632/667/FC9780062667632.JPG",
22.95, 17.95, 27.95),
("9780062667632","Leave the World Behind: A Novel (Hardcover)",
"Cinelle Barnes", 1,"Hub City Press","2020", 8,"https://images.booksense.com/images/books/719/235/FC9781938235719.JPG",
12.95, 7.95, 17.95);

INSERT INTO Sales(OrderID, Book)
VALUES
(1,"9781938235719"),
(1,"9780062667632");

INSERT INTO Cart(User, Book)
VALUES
(234411,""),
(331412,"");


