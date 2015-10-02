import React from 'react';

var Turn = React.createClass({
  displayName: 'Turn',
  propTypes: {
    clues: React.PropTypes.array.isRequired,
    endTurnURL: React.PropTypes.string,
    secondsRemaining: React.PropTypes.string
  },
  getDefaultProps: function() {
    return {
      secondsRemaining: 60
    };
  },
  getInitialState: function() {
    return {
      cluesCompleted: [],
      currentClue: this.props.clues[0],
      cluesRemaining: this.addLastClue(this.props.clues.slice(1)),
      score: 0,
      secondsRemaining: this.props.secondsRemaining,
      showCompletedClues: false
    };
  },
  addLastClue: function(clues) {
    return clues.concat(["All done!"]);
  },
  componentDidMount: function() {
    this.setState({ secondsRemaining: this.props.secondsRemaining });
    this.interval = setInterval(this.tick, 1000);
  },
  componentWillUnmount: function() {
    clearInterval(this.interval);
  },
  addClueToCompleted: function(clue) {
    var completed = this.state.cluesCompleted.slice()
    completed.push(clue)
    this.setState({
      cluesCompleted: completed,
    });
  },
  skipToNextClue: function(clue) {
    var clueToShuffleIn = clue;
    var remaining = this.state.cluesRemaining.slice();

    var randomIndex = this.getRandomIndex();
    remaining.splice(randomIndex, 0, clueToShuffleIn);

    var nextClue = remaining[0];
    var remainingWithoutNext = remaining.slice(1);

    this.setState({
      currentClue: nextClue,
      cluesRemaining: remainingWithoutNext
    })
  },
  removeCurrentClueFromRemaining: function() {
    var remaining = this.state.cluesRemaining.slice().slice(1)
    this.setState({
      cluesRemaining: remaining
    });
  },
  increaseScore: function() {
    this.setState({
      score: this.state.score + 1
    })
  },
  decreaseScore: function() {
    this.setState({
      score: this.state.score - 1
    })
  },
  getNextClue: function() {
    this.setState({
      currentClue: this.state.cluesRemaining[0]
    })
  },
  gotIt: function() {
    var currentClue = this.state.currentClue;
    this.addClueToCompleted(currentClue);
    this.getNextClue();
    this.removeCurrentClueFromRemaining();
    this.increaseScore();
    this.dispatch(increaseAction({
      state: {teamAScore: 1},
      action: "increaseScore"
    }))
  },
  getRandomIndex: function() {
    return Math.floor(Math.random() * this.state.cluesRemaining.length);
  },
  skippedIt: function() {
    this.skipToNextClue(this.state.currentClue);
    this.decreaseScore();
  },
  tick: function() {
    this.setState({
      secondsRemaining: this.state.secondsRemaining - 1
    });

    if (this.state.secondsRemaining <= 0) {
      clearInterval(this.interval);
    }
  },
  finishTurn: function() {
    console.log('do something to go back to roster')
    debugger;
  },
  render: function() {
    var turnIsOver = this.state.secondsRemaining === 0 || this.state.currentClue === "All done!";

    return (
      <div className="turn">

        { !turnIsOver ?
          <div>
            <div className="timer">
              <h2>{this.state.secondsRemaining}</h2>
            </div>

            <h1>{this.state.currentClue}</h1>
            <button disabled={turnIsOver} onClick={this.gotIt}>Got it</button>
            <button disabled={turnIsOver} onClick={this.skippedIt}>Skip it</button>
            <div className="score">
              <h6>Score: {this.state.score}</h6>
            </div>
          </div>
          : null
        }

        { turnIsOver && this.state.cluesCompleted.length ?
          <div className="guessed-clues-review">
            <h3>Great Job!</h3>

            <div className="score">
              <h5>You got {this.state.score} points</h5>
            </div>

            <p>Your team guessed these clues correctly:</p>
            <ul>
              { this.state.cluesCompleted.map(function(clue){
                return (
                  <li>{clue}</li>
                );
              })}
            </ul>
            <button onClick={this.finishTurn}>Ready for next player</button>
          </div>
          : null
        }

        { turnIsOver && !this.state.cluesCompleted.length ?
          <div className="guessed-clues-review">
            <h3>Time is up!</h3>

            <div className="score">
              <h5>You got {this.state.score} points</h5>
            </div>
            <button onClick={this.finishTurn}>Ready for next player</button>
          </div>
          : null
        }

        <div style={{display:'none'}}>
          <form
            method="POST"
            action={this.props.endTurnURL}
          >
            <input type="text" value={this.state.cluesCompleted}/>
            <input id="end-turn-form" type="submit"/>
          </form>
        </div>

      </div>
    );
  }
});

export default Turn;
