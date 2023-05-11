# sokoban

A remake of Sokoban using LÖVE2D plus a level editor to make new levels.

### A note about the level editor
I designed the level editor as a learning exercise and to help me add levels to the game quickly. Level's can be saved, edited and deleted. However, levels are not validated before saving and thus the game will crash if levels do not meet the game requirements of:
- adding a player to the map
- closing off walls
- matching the number of boxes to dots

Future update may fix this feature to be more error-resistant. Some refactoring also required.

Free assets sourced from [Kenney's Assets](https://kenney.nl/assets)
