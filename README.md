# Sprint 2, Task 1, Data Structures and MySql

## Exercise Description:

### ***Level1:***

**Exercise 1: This project models an ER diagram for the optician "Cul d'Ampolla" to digitize client and eyewear sales management.**
It tracks:
- Eyewear suppliers (name, full address, phone, fax, NIF)
- Glasses (brand, lens prescription, frame type/color, lens color, price)
- Clients (name, address, phone, email, registration date, referrer)
- Sales (which employee sold each pair of glasses)
Each brand is linked to a single supplier, but suppliers may offer multiple brands.

**Exercise 2:**
This project models a database for an online food delivery web app.
It stores:
- Clients (unique ID, name, surname, address, postal code, locality, province, phone)
- Localities and provinces in separate tables (1:N relationship)
- Orders (unique ID, timestamp, delivery or pickup, product quantities, total price)
- Products (pizzas, burgers, drinks) with name, description, image, price
- Pizza categories (1:N relationship with pizzas)
- Stores (unique ID, address, postal code, locality, province)
- Employees (unique ID, name, surname, NIF, phone, role: cook or delivery)
- Each order is linked to one client, one store, and optionally one delivery employee with delivery timestamp

### ***Level2:***
**Exercise 1:**
This project models a simplified database for a reduced version of YouTube.

It stores:
- Users (unique ID, email, password, username, birthdate, gender, country, postal code)
- Videos (title, description, size, filename, duration, thumbnail, views, likes/dislikes, status, tags, publisher, publish timestamp)
- Channels (unique ID, name, description, creation date)
- Subscriptions (users can subscribe to other users' channels)
- Likes/dislikes (users can rate videos and comments once, with timestamp)
- Playlists (unique ID, name, creation date, public/private status)
- Comments (unique ID, text, timestamp, author, video)

### ***Level3:***
**Exercise 1:**
This project models a simplified database for a reduced version of Spotify.

It stores:
- Users (unique ID, email, password, username, birthdate, gender, country, postal code, type: free/premium)
- Subscriptions (start date, renewal date, payment method: credit card or PayPal)
- Payments (unique order number, date, total)
- Playlists (unique ID, title, song count, creation date, deletion date if marked as deleted, shared status)
- Playlist contributions (who added each song and when)
- Songs (unique ID, title, duration, play count, album)
- Albums (unique ID, title, release year, cover image, artist)
- Artists (unique ID, name, image, related artists)
- User interactions (followed artists, favorite albums and songs)

## **Technologies Used**
- MySQL Workbench 8.0 CE: Used for designing and modeling the relational database schema (ER diagrams).
- MySQL Server 8.0+: Required to run and test the database locally.
- SQL (Structured Query Language): Used to define tables, relationships, constraints, and sample queries.
- Git & GitHub

## **Requirements**
- MySQL Workbench 8.0 CE installed
- MySQL Server 8.0 or higher running locally or remotely

## **Installation**
n/a

## **Execution**
**Option A: Using the diagram:**
- Launch MySQL Workbench
- Open the .mwb file via File → Open Model
- Review and adjust the ER diagram if needed
- Go to Database → Forward Engineer
- Select your local MySQL connection
- Configure options (e.g., drop tables before create, generate INSERTs if needed)
- Click Execute to generate the schema in your MySQL database
- Open a new SQL tab
- Run sample INSERT, SELECT, or JOIN queries to validate relationships and constraints

**Option B: Without the diagram:**
- Launch MySQL Workbench
- Open a new SQL tab
- Open and execute Database creation script.
- Open and execute Database fulfillment and test scripts.

## **Deployment**
n/a

## **Contributions**
This code has been written by a novice, I will really appreciate your contributions:
1. Fork the repository
2. Create a new branch
3. Commit your contributions
4. Upload them to your branch
5. Execute a pull request
