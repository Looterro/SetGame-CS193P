# SetGame-CS193P

Standford's CS193P assignment 3 project - The Set Game Clone iOS app, written using SwiftUI.

## Live Demo

https://user-images.githubusercontent.com/73793088/208236397-e4bee88d-5be0-485d-aa60-ca840667435e.mp4

## Specification:

- The game uses animation to make dealing cards feel more natural to the eye. To start new game again user can use "New Game" button.

- User is able to select and deselect cards. If three cards are chosen, the model checks if they are all the same or different, with types varying between shading, color, number of shapes and symbols.

- Game uses 81 cards, player can add more cards to table from deck using card deck button in the shape of a card. If a set was already possible with given cards on table, player is penalized 3 points for each possible configuration after drawing from deck. User can add up to 21 cards to the table.

- Cards are laid out using AspectVGrid, which allows for all the properly scaled content to be displayed on one view, without the need of scrolling.

- User can use cheat button to display a possible set, which is displayed with applying cards foreground changed to yellow. Player is penalized 1 point for each possible set that the cheat mechanic identified, although only one set is shown to the user (the last found by the algorithm).

- The algorithm automatically checks if there are no more sets at the end of the game and if that is the case it calculates the highest score.
