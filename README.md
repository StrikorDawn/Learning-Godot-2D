# Overview

This is version 0.2.0 of my Learning Godot Project. The purpose behind this project to help me learn
the necissary mechanics I need to help me begin building my first fully developed 2D Game. I am also
using this project to help me get more familiar with GDScript and the Godot Game Engine.
I have been wanting to make my own game since I was 15, so this project marks the beginning of my
journey as a Game Dev.

[V0.1.0 Demo Video](https://youtu.be/gqNWMZb7zOo)
[V0.2.0 Demo Video](https://youtu.be/EafxfHYhIGg)

## Development Environment

* [Godot 4.2.1](https://godotengine.org/)

* GDScript

## Useful Websites

* [Good Jump Code](https://www.youtube.com/watch?v=IOe1aGY6hXA)
* [Godot Documentation](https://docs.godotengine.org/en/stable/)
* [The Ultimate Controler](https://www.youtube.com/watch?v=3sWTzMsmdx8)
* [Variable Jump Height](https://www.youtube.com/watch?v=eXmx3SQ_wBo)
* [Coyote Time](https://www.youtube.com/watch?v=4Vhcqh9S2LM)
* [Jump Buffer](https://www.youtube.com/watch?v=hRQW580zEJE)
* [Super Mario Mechanics](https://www.youtube.com/watch?v=ZeEs4dhDp6E&list=PL4vjw0qHwNZKRgg6GxTkcu2zdeVMbZra0&pp=iAQB)

## Version Progress
* Restructured the entirty of main_character.gd to accomidate new features.
* Added player Lives mechanic
* Added player Death Mechanic and animation
* Added Enemies with player interaction
* Added sound to collectables
* In the prossece of Remaking levels 1-3
* Adjusted player movement to make the player feel like they have more control over the character
* Changed the Game_Manager.gd to Global.gd
* Made Globle.gd load on launch for a constant live and collectable tracker.

## Known Bugs
* If you start the game after completeing all 3 levels without closing the application
it keeps your number of collectables and live at the start of level 1
* Halfway fixed player collision with enemies on death, Player no longer kills enemies during
death animation, but still collides with them sometimes causeing the enemy to be ripped off
screen.

## Future Work
* Add more movement options such as sprinting, ducking, and wall jumping.
* Create a timer for speed running and as an additional fail case for each level in the game.
* Add more levels and get a very basic story established.
* Create pause and settings menus.
