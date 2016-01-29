#ruby-chess

A desktop application that simulates the game ["chess"](https://en.wikipedia.org/wiki/Chess)
Made for the ruby course in The Faculty of Mathematics and Informatics of Sofia University (FMI)

##Summary

The game has two usable interfaces - console and graphical(using Gosu) interface. The game can be played against another player on the same computer or with a mentally challenged AI. There is a save/load functionality.

##Installation

1. clone the repository(``` git clone https://github.com/dimiturtrz/ruby-course-project.git ```)
2. run main.rb(``` ruby main.rb ```)
3. choose an interface(**for graphical see below**)
4. choose wether you want to play against another player or an AI(simple minded)

Graphical interface (optional)
If you want to play with the graphical interface you will have to install the Gosu gem if you don't have it
- [Linux installation](https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux)
- [Mac-OS installation](https://github.com/gosu/gosu/wiki/Getting-Started-on-OS-X)
- [Windows installation](https://github.com/gosu/gosu/wiki/Getting-Started-on-Windows)

##Usage

### Console
In the console interface you play by typing commands in your console. They are:
- to move a piece: ``` move [piece_abbreviation][number] [destination_square] ```
  * piece_abbreviation - the first character of a piece name(P - pawn, R - rook etc.) with the exception of the knight. It's H(as in "horse"(because of the "K" king))
  * number - for plural pieces(bishops, pawns and everything except king and queen). It's the digit next to the piece icon on the table
  * destination_square - in chess the board coordinates are described with a letter and a number specifying the row and column of the piece(e.g. B7, G5, D2)
  * to take an enemy piece just move yours over it
  * Examples:
    - move P5 E4
    - move K D6
    - move H2 E4
- to save/load: ``` save ``` to save and ```load``` to load game state
- to surrender: ``` surrender ``` - ends the game and opponent wins

##Tests
To run full tests run ``` rspec full_spec.rb --colour --format documentation ```
To test the separate features run rspec for the other spec files 
