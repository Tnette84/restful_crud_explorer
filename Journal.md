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