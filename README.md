# MFallingWords
App that helps in learning the language with fun!!

## Implementation Details
- Total time invested => 6Hrs

### Time Distribution (concept, model layer, view(s), game mechanics)
- Decision making for the Concept, Approach to be followed, Architecture to be followed, Features going to be implemented etc.. => 1:30Hrs

### Technical Implementation:
- Data Layer => 00:45 Hrs
- Model Layer => 1:30 Hrs
- View Layer => 1:30 Hrs
- Unit Testing => 30 Min

### Decisions made to solve certain aspects of the game:
- Criteria on how the game ends: A minimum score limit of -1000 where a player will lose the game and +1000 where the player is deemed to have won the game.
- Counting of correct/wrong/no answer is based on when the user has selected the answer, Used the concept of falling word itself to calculate the score, the sooner the player identifies the word the higher the score addition ( ranging from 100 to 10).
- A Visual indicator of the score changes and the current progress to the user
- The speed of the falling word depends on the user current score, so the higher the score of user the faster the falling word!! just to make it a bit more interesting :)
- Shuffling of the word translations to make sure that the correct word translations are equally distributed.

### Decisions made because of restricted time:
- Local Fetch of the words data (from json file) instead of fetching from the database, as remote fetching involves Network availability and display of the corresponding error screens, retry mechanism etc.

- Controls like Pause, Resume, Restart features are not implemented.

- The User Overall Game progress is not maintained, basically increasing the difficulty of the words etc based on the Levels ( Level 1 to Level 10 etc..)

### What would be the first thing to improve or add if there had been more time => 
- I think pronounciation of the translated word (while falling) is kind of a useful feature.


## Steps to Run the Project.
- The project uses Pods as the dependency management, Please run 

```sh
$ cd <path to the project>
$ pod install
```
Post successfull creation of pods project Run the generated .xcworkspace and there you go!!
