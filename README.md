# Housemates-Ranking-Game-
Simple iOS App to display a leaderboard of the worst house mate, with the title of "Little boy" based on small infractions like being messy or not courteous. 

# What it does
The display contains a ranking of the top 3 "Littlest Boys" on the top of the page and a controller to update the score below.

Each housemate's information is stored in the Firebase Realtime Database including their first name, last name, profile photo, and their score. Scores are updated via the controller through a user anonomous reporting method, which updates the score for the Lad object who was selected in a picker view. 

This project is a simple, fun game to keep a group of 13 college friends accountable in a communal living environment.

# Installation
## Requirments
Xcode 11+
Access to web

## How-to
Clone the XCode project to local machine
Configure the XCode project to Firebase using cocoa-pods or by following instructions on Firebase website

# Work to be done:

- Generalize the player list via a user authentication object through the firebase auth library
- Update the UI to clean it up a bit
- Fix the bug where the stack view does not stay linked to the keyboard when the keyboard disappears
- Implement regex or basic ML functions for controlling the logic for offence_is_bad boolean to determine if an offence is worthy of adding a "little boy" point.


## Note that the phrase "Little boy" comes from the idea that failing to be courteous or doing basic tasks like washing one's dishes is childish. As college juniors and seniors, we should have matured out of that "little boy" phase of no accounatbalilty. 
