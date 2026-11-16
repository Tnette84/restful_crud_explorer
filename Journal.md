# RESTful CRUD Explorer

## Phase 0: The Blueprint
I plan to create a Flutter application that retrieves a list of albums from the JSONPlaceholder API. I will create an Album model to store the album ID, user ID, and title.

The application will display the albums in a scrollable list and allow the user to select an album to view its details. The application will also allow the user to delete a selected album.

I will use a loading indicator while waiting for data and display an error message if the request fails.

### Journal Reflection

The part I am most unsure about is communicating with the API and making sure the application updates correctly after an album is deleted.

## Phase 1 - Fetch and Display Albums

I created an Album model and an API service using the HTTP package. I used FutureBuilder to retrieve and display albums from the JSONPlaceholder REST API. I tested the application in Chrome and successfully displayed the album list.

## Phase 2 - Album Details and Navigation

I added a method to retrieve an individual album from the REST API. I created an album details screen and implemented navigation using Navigator.push. I successfully tested viewing album details and returning to the album list in Chrome.

## Phase 3 - Delete Albums

I implemented the HTTP DELETE method and added a delete button with a confirmation dialog. I successfully tested both canceling and deleting an album. The application updates the list and displays a success message. JSONPlaceholder simulates deletion without permanently removing the data from the server.

## Phase 4 - Validation and Reflection

## Phase 4 - Validation and Reflection

While developing and testing my application, I discovered duplicate ListTile code and a missing closing parenthesis and semicolon. My AI tutor suggested removing the duplicate code and correcting the syntax errors. It also suggested using a confirmation dialog before deleting an album and updating the displayed list after a successful deletion.

I chose to implement these suggestions because they improved the functionality of my application, prevented accidental deletions, and resolved coding errors.

After making these changes, I successfully tested the application in Chrome and ran Flutter Analyze with no issues found. This assignment helped me improve my understanding of REST APIs, debugging, and state management in Flutter.