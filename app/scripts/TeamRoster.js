var TeamRoster = React.createClass({
  displayName: 'TeamRoster',
  propTypes: {
    currentPlayer: React.PropTypes.string,
    players: React.PropTypes.array.isRequired,
    name: React.PropTypes.string.isRequired
  },
  getDefaultProps: function() {
    return {};
  },
  getInitialState: function() {
    return {};
  },
  isCurrentPlayer: function(player) {
    return player === this.props.currentPlayer;
  },
  render: function() {
    return (
      <div>
        <h1>{this.props.name}</h1>
        <ul>
          {this.props.players.map(function(player, i) {
            return (
              <li
                className={this.isCurrentPlayer(player) ? "current-player" : null}
                key={i}
              >
                <span>{player}</span>
                { this.isCurrentPlayer(player) ?
                  <a href={this.props.startTurnUrl}>Start Turn</a> : null }
              </li>
            );
          }, this)}
        </ul>
      </div>
    );
  }
});
