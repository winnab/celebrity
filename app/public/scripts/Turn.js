var Turn = React.createClass({
  displayName: 'Turn',
  propTypes: {
    clues: React.PropTypes.array
  },
  getInitialState: function() {
    return {
      currentClue: this.props.clues[0],
      remainingClues: this.props.clues.slice(1),
      completedClues: [],
      score: 0
    };
  },
  getClues: function(clues){
    return (
      <ul>
        { clues.map(function(clue, i) {
            return <li key={i}>{ clue }</li>
          })
        }
      </ul>
    )
  },
  addClueToCompleted: function(clue) {
    var completed = this.state.completedClues.slice()
    completed.push(clue)
    this.setState({
      completedClues: completed,
    });
  },
  skipToNextClue: function(clue) {
    var clueToShuffleIn = clue;
    var remaining = this.state.remainingClues.slice();

    var randomIndex = this.getRandomIndex();
    remaining.splice(randomIndex, 0, clueToShuffleIn);

    var nextClue = remaining[0];
    var remainingWithoutNext = remaining.slice(1);
    console.log('remainingWithoutNext', remainingWithoutNext.length)

    this.setState({
      currentClue: nextClue,
      remainingClues: remainingWithoutNext
    })
  },
  removeCurrentClueFromRemaining: function() {
    var remaining = this.state.remainingClues.slice().slice(1)
    console.log('remaining', remaining.length)
    this.setState({
      remainingClues: remaining
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
      currentClue: this.state.remainingClues[0]
    })
  },
  gotIt: function() {
    if (!this.state.remainingClues.length) {
      return this.setState({
        currentClue: "All done!"
      })
    }
    var currentClue = this.state.currentClue;
    this.addClueToCompleted(currentClue);
    this.getNextClue();
    this.removeCurrentClueFromRemaining();
    this.increaseScore();
  },
  getRandomIndex: function() {
    return Math.floor(Math.random() * this.state.remainingClues.length);
  },
  skippedIt: function() {
    this.skipToNextClue(this.state.currentClue);
    this.decreaseScore();
  },
  render: function() {
    return (
      <div>
        <Timer secondsRemaining="10" />
        <h6>Score: {this.state.score}</h6>
        <h3>Clue</h3>
        <p>{this.state.currentClue}</p>
        <button onClick={this.gotIt}>Got it</button>
        <button onClick={this.skippedIt}>Skip it</button>

        <h5>{this.state.completedClues.length} Completed</h5>
        <h5>{this.state.remainingClues.length} Remaining</h5>
        {/*
        { this.getClues(this.state.completedClues) }
        { this.getClues(this.state.remainingClues) }
        */}
      </div>
    );
  }
});
