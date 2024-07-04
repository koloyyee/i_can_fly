# i_can_fly CST2335 Mobile Final Project


### Architecture


### Entities

Customer: id, first_name, last_name, birthday, address, last_login, created_at
Airline: id, name, code
Airplane: id, manufacturer, type, max_speed, max_passengers, max_range
Flight: id, destination_city, departure_city, airplane_id, departure_time, arrival_time, airline_id

Route? : id, destination_city, departure_city
Reservation: user_id, flight_id, 




# TODO list 

## Remarks MUST HAVE

1. You must have a ListView that lists items that were inserted by the user.
2. There must be a TextField along with a button that lets the user insert items into the ListView.
3. You must use a database to store items that were inserted into the ListView to repopulate the list when the application is restarted.
4. Selecting items from the ListView should show details about the item that was selected. On a phone would use the whole screen to show the details but on a Tablet or Desktop screen, it would show the details beside the ListView.
5. Each activity must have at least 1 Snackbar, and 1 AlertDialog to show some kind of notification.
6. Each activity must use EncryptedSharedPreferences to save something about what was typed in the EditText for use the next time the application is launched.
7. Each person’s project must have an ActionBar with ActionItems that displays an AlertDialog with instructions for how to use the interface.
8. There must be at least 1 other language supported by your part of the project. If you are not bilingual, then you must support both British and American English (words like colour, color, neighbour, neighbor, etc). If you know a language other than English, then you can support that language in your application and don’t need to support American English.All activities must be integrated into a single working application, on a single device or emulator. You should use GitHub for merging your code by creating pull requests.
9. The interfaces must look professional, with GUI elements properly laid out and aligned.
10. The functions and variables you write must be properly documented using JavaDoc comments. You must create the JavaDocs in a JavaDocs folder like you did in the labs.

## 4 Parts of the Project

### Customer list page
This page will be for adding new customers to a database of customers. You will be able to add, view, update, and delete customers.

Your application should have a button for adding a new customer. When the user presses this button, there is a page that lets the user enter the customer’s first and last name, address and birthday. You should check that all fields have a value before letting the user submit the new customer.

Once a customer is added, they should appear in a list of customers, as well as be inserted in a database. Selecting a user from the list should show the customer’s details in the same page as when creating the customer. However now instead of a submit button, there should be an Update and Delete button. The update button just saves the customer’s updated information and delete removes the customer from the list and database.

When a user adds a new customer, the user should have a choice to copy the fields from the previous customer or start with a blank page. You should use EncryptedSharedPreferences to save the data from the previously created customer in case they want to copy the information.

#### TODO
1. [] - Create page (example);


### Airplane list page
This page will simulate an airline keeping a list of airplanes that it has in the company. You should be able to add new planes to your company’s list of planes, view current planes or delete planes that were sold or are too old to fly anymore.

Your application should have a button for adding a new airplane. When the user presses this button, there is a page that lets the user enter the airplane type (Airbus A350, A320, Boeing 777, etc), the number of passengers, the maximum speed, and the range or distance the plane can fly. You should check that all fields have a value before letting the user submit the new airplane type.

Once an airplane is added, they should appear in a list of all airplanes available to a company, as well as be inserted in a database. Selecting an airplane from the list should show that plane’s details in the same page as when creating the airplane. However now instead of a submit button, there should be an Update and Delete button.

#### TODO
1. [] - Create page (example);

### Flight list page

This page will simulate an airline keeping a list of flights between two cities. You should be able to add new flights to your company’s list of routes, view current flights or delete flights that are no longer offered.

Your application should have a button for adding a new flight. When the user presses this button, there is a page that lets the user enter the departure and destination cities, as well as the departure and arrival times. You should check that all fields have a value before letting the user submit the new airplane type.

Once a flight is added, they should appear in a list of all flights available to a company, as well as be inserted in a database. Selecting a flight from the list should show that flights’ details in the same page as when creating the flight. However now instead of a submit button, there should be an Update and Delete button. The update button just saves the flight’s updated information and delete removes the flight from the list and database.

#### TODO
1. [] - Create page (example);

### Reservation page
This page will simulate an airline booking a customer on a flight. You should be able to add new reservations for customers on a given flights.

Your application should have a button for adding a reservation. When the user presses this button, there is a page that lets the user select an existing customer onto an existing flight, on a certain day. Assume that a flight only happens once per day, and the flights repeat every day, meaning that you don’t have to worry about the case where flights are only available on certain days, like Wednesday and Fridays. Assume that flights happen every day. If you want multiple flights between the same cities, but at different departure times, then those would have to be entered as different flights (for example AC 456, AC 457, AC 345 could all be travelling from Toronto to Vancouver but have different departure times)

Once a reservation is added, they should appear in a list of all reservations made with a company, as well as be inserted in a database. Selecting a reservation from the list should show the reservations details like customer name, departure and destination cities, as well as departure and arrival times.

#### TODO
1. [] - Create page (example);
