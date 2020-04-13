# System Design

## Global Architecture

The MVC Architecture will be adopted for this challenge, splitting the tasks in the following way:

- Models: Classes are going to be defined here, following the SOLID principles

- Controller: Actions that involved in the application will be defined here, interacting with the necessary models and view
- View: The code associated to the render work is defined in this component.

## Models

### `PinFall`

#### Responsability

Represents the amount of pins that the player was able to knock down on one single chance. 

#### Attributes



#### Methods

### `Score`

### `Frame`

### `Player`

## Testing

Unit and Integration Tests are implemented using RSpec