require('../styles/main.scss');

import React from 'react';
import { createStore } from 'redux';
import { Provider, connect } from 'react-redux';
import Turn from './Turn';

// React component
class Game extends React.Component {
  render(){
    const { value, onIncreaseClick } = this.props;
    return (
      <Turn
        clues={["a", "b"]}
        endTurnURL={"/"}
        secondsRemaining={"60"}
        onClick={onIncreaseClick}
      />
    );
  }
}

// Action:
const increaseAction = {type: 'increase'};

// Reducer:
function increaseScore(state, action) {
  console.log('state', state)
  console.log('action', action)
  let teamAScore = state.teamAScore;
  switch(action.type){
    case 'increase':
      return {teamAScore: teamAScore+1};
    default:
      return state;
  }
}

// Store:
let store = createStore(increaseScore);

// Map Redux state to component props
function mapStateToProps(state)  {
  return {
    teamAScore: state.teamAScore,
    teamBScore: state.teamBScore
  };
}

// Map Redux actions to component props
function mapDispatchToProps(dispatch) {
  return {
    onIncreaseClick: () => dispatch(increaseAction({state:{teamAScore: 0}}))
  };
}

// Connected Component:
let App = connect(
  mapStateToProps,
  mapDispatchToProps
)(Game);

React.render(
  <Provider store={store}>
    {() => <App />}
  </Provider>,
  document.getElementById('react')
);
