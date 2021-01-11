# Pokemons

1. The first screen is a list of Pokemon. To display the list of Pokemon, I decided to use a regular tableView.

2. The second screen is information about Pokemon. I also used a tableVIew to show information about Pokemon. To avoid violating the open close principe and Liscov principe, i added "CellItemProtocol" for each table view cell which stores information about cell. And now if I want to add a new cell to the table I won't need to edit the "cellForRowAt" method every time, but just create CellItem class and add it to cellItems array.

3. To check my Internet connection, I decided to use the Reachability framework. Because it has an easy and clear interface.

4. In order for the application to work offline, I save the latest Pokemon in the cache and get the Pokemon out of the cache when there is no Internet access.
