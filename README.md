# Ten-pin Bowling Score
This is a Ruby CLI Program that receives a file with records of the amount of knocked down pins achieved on every launch in a 10-pin bowling game. The program computes the score and builds the scoreboard for you.

## Install
1. Clone this repository
`git clone git@github.com:mapra99/ten-pin-bowling.git`

2. cd to the project's folder
`cd ten-pin-bowling`

3. Install dependencies
`bundle install`

## Usage
To run the program, you have to execute the following command
`bundle exec ruby ./bin/main.rb <file_path>`

### Input File Format
The input file must use the following format:
- Two values per row: Name and Amount of Knocked down Pins. Values are tab-separated.
- The amount of knocked down pins can be an integer between 0 and 10, and can also be an F for fault.
- The amount of rows must correspond to exactly 10 frames played.
- There must be at least 2 Players.

In this repo, in `./data/` you will find some sample files

### Example
Run `bundle exec ruby ./bin/main.rb ./data/test_set1`

You'll get the following output:
```
Frame    1     2     3     4     5     6      7      8      9      10      
Jeff                                                                       
Pinfalls    X  7  /  9  0     X  0  8  8   /  0   6      X      X  /   8 1 
Score    20    39    48    66    74    84     90     120    148    167     
John                                                                       
Pinfalls 3  /  6  3     X  8  1     X      X  9   0  7   /  4   4  /   9 0 
Score    16    25    44    53    82    101    110    124    132    151     
```

## Testing
This project uses RSpec for testing.
To execute the tests, run:
`rspec spec`

Also, you can use Guard to automate testing execution while programing:
`bundle exec guard`

## Dependencies
- Ruby ~> 2.5
- RSpec
