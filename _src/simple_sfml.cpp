#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>

int main() {
    std::cout << "Starting SFML application..." << std::endl;
    
    // Create a window with dimensions 800x600 and the title "SFML Windows App"
    sf::RenderWindow window(sf::VideoMode(800, 600), "SFML Windows App");

    // Main loop that continues until the window is closed
    while (window.isOpen())
    {
        std::cout << "running" << std::endl;
        sf::Event event;
        // Process events
        while (window.pollEvent(event))
        {
            // Close the window when the close event is received
            if (event.type == sf::Event::Closed)
                window.close();
        }
	
	    window.clear();
        
        sf::CircleShape shape(50); // Create a circle shape with a radius of 50
        shape.setFillColor(sf::Color::Green); // Set the fill color to green
        shape.setPosition(375, 275); // Set the position of the circle in the window

        window.draw(shape); // Draw the circle shape
        
        // Display the window (no drawing, just window management)
        window.display();
    }
    
    return 0;
}
