window.onload = function(){

  // DOM element variables (those available onload):***********************
  var setupTeamsButton      = document.getElementById('setupTeams'),
      startRoundButton      = document.getElementById('startRound'),
      startTurnButton       = document.getElementById('startTurn'),
      teamListContainer     = document.getElementById('teams'),
      playerListContainer   = document.getElementById('players'),
      teamOrderContainer    = document.getElementById('order'),
      gotItButton           = document.getElementById('gotIt'),
      skipItButton          = document.getElementById('skipIt'),
      clueElement           = document.getElementById('clue'),
      counterContainer      = document.getElementById('counter'),
      counterElement        = document.createElement('time'),
      scoreContainer        = document.getElementById('scoreContainer'),
      scoreElement          = document.getElementById('score'),
      currentTeamContainer  = document.getElementById("currentTeam"),
      currentTeamMemberElement = document.getElementById("currentTeamMember");

  // ASYNC:**************************************************************
  $.get('./scripts/data.json', function(data){

    var globalPlayers = data,
        teams         = randomize(setupTeams(2, globalPlayers)),
        clues         = populateClues(globalPlayers),
        roundClues    = randomize(clues).slice(),
        roundTeams,
        currentTeam,
        currentTeamCopy,
        currentTeamMember,
        currentClue,
        currentIntervalId,
        countdown;

    createPlayerLists(globalPlayers);

    // EVENT listeners:**************************************************
    setupTeamsButton.onclick = function(){ 
      createTeamsList(globalPlayers, teams);
      displayTeamOrder(teams);
      setCurrentTeam(teams);
      displayCurrentTeam(currentTeam);
      setCurrentTeamMember();
      displayTeamMember(currentTeamMember, "Next");
      displayInitialCounter();
      displayScore();
      showIt(startTurnButton);
      hideIt(this);
      // TODO need to remove this listener for the rest of the game (this.removeEventListener('click', <handler>) )
    }

    startTurnButton.onclick = function(){
      hideIt(this);
      if (currentTeam.indexOf(currentTeamMember) == 0){
        currentClue = getRandomAndRemove(roundClues);
        clueContainer.appendChild(clueElement);
        displayClue(currentClue);
      } else {
        resetCounterElement();
        nextClue();
      }
      displayTeamMember(currentTeamMember, "Current");
      showControlButtons();
      setTimer();
  
      // TODO need to remove this listener for the rest of the round and reattach it for each round... (this.removeEventListener('click', <handler>) )
    }


    gotItButton.onclick = function(){
      nextClue(roundClues);
      currentTeam.score++;
      updateScore();
      console.log("score", currentTeam.score);
    }

    skipItButton.onclick = function(){
      console.log("skip");
      nextClue(roundClues);
    }



    // Qs:*********************************************************
    // do we need to display all clues in the beginning? team player names should be sufficient

    // NEXT todos:*************************************************
    
    // TODO: add change current team
    // line 45, 62
    // switch to jQuery, this is killing me :p
  



    // DATA dependant function defs:*******************************

    function setCurrentTeam(teams){
      roundTeams = teams.slice();
      currentTeam = roundTeams[0];
      currentTeamCopy = currentTeam.slice();
      console.log(currentTeamCopy);
      return currentTeam;
    }

    function setCurrentTeamMember(){
      currentTeamMember = currentTeamCopy.splice(0, 1)[0].name;
    }

    function displayInitialCounter(){
      var counterText = document.createElement('h4');
      counterText.textContent = "Counter: "
      counterContainer.appendChild(counterText);
      counterElement.textContent = "00:00"
      counterContainer.appendChild(counterElement);
    }

    function displayScore(){
      var scoreText = document.createElement('h4');
      scoreText.textContent = "Score: "
      scoreContainer.insertBefore(scoreText, scoreElement);
      scoreElement.textContent = currentTeam.score;
    }

    function updateCounter(){
      countdown++;
      if (countdown > 59){

        clearInterval(currentIntervalId);
        setCurrentTeamMember();
        displayTeamMember(currentTeamMember, "Next");
        showIt(startTurnButton);
        hideControlButtons();
        resetClue();
    
      } else {
        counterElement.textContent = "00:" + humanizeCountdown(countdown);
      }
    }

    function updateScore(){
      scoreElement.textContent = currentTeam.score;
    }

    function setTimer(){
      countdown = 0;
      currentIntervalId = setInterval(updateCounter, 1000);
    }
  
    function nextClue(){
      currentClue = getRandomAndRemove(roundClues);
      displayClue(currentClue);
    }    
    
  }); // END of ASYNC __________________________________________________




  //DOM dependant functions' defs:**************************************

  function displayTeamOrder(teams){
    var orderListContainer = document.createElement("ol");
    var listHeading = document.createElement("h3");
    listHeading.textContent = "Order of teams"
    teams.forEach(function(team){
      var teamContainer = document.createElement("li");
      teamContainer.textContent = team.name;
      orderListContainer.appendChild(teamContainer);
    });
    teamOrderContainer.appendChild(listHeading);
    teamOrderContainer.appendChild(orderListContainer);
  }

  function displayCurrentTeam(team){
    var element = document.createElement("h3");
    currentTeamContainer.appendChild(element);
    element.textContent = "Current team: " + team.name;
  }

  function displayTeamMember(member, status){
    currentTeamMemberElement.textContent = status + " player: " + member;
  }

  function displayClue(clue){
    console.log("displaying clue")
    console.log("clue ", clue)
    clueElement.textContent = "Your clue: " + clue;
  }

  function resetClue(){
    clueElement.textContent = "Your clue: ---";
  }

  function createPlayerLists(players){
    var listItems = players;
  
    listItems.forEach(function(player){
      var playerContainer = document.createElement('div');
      var playerName = document.createElement('h3');
      // var playerClues = document.createElement('ul');

      playerContainer.appendChild(playerName);
      playerName.textContent = player.name;

      // playerContainer.appendChild(playerClues);
      // player.clues.forEach(function(clue){
      //   var clueLi = document.createElement('li');
      //   clueLi.textContent = clue;
      //   playerClues.appendChild(clueLi);
      // });

      playerListContainer.appendChild(playerContainer)
    });
  }

  function createTeamsList(players, teams){
    var listItems = teams;

    listItems.forEach(function(team){
      var teamContainer = document.createElement('div');
      var teamName = document.createElement('h3');
      var teamPlayers = document.createElement('ul');

      teamContainer.appendChild(teamName);
      teamName.textContent = team.name;

      teamContainer.appendChild(teamPlayers);
      for (var i = 0; i < team.length; i++) {
        var playerLi = document.createElement('li');
        playerLi.textContent = team[i].name;
        teamPlayers.appendChild(playerLi);
      }
      teamListContainer.appendChild(teamContainer);
    });
  }

  function resetCounterElement(){
    counterElement.textContent = "00:00"
  }

  function showControlButtons(){
    showIt(gotItButton);
    showIt(skipItButton);
  }

  function hideControlButtons(){
    hideIt(gotItButton);
    hideIt(skipItButton);
  }

}; // END window.onload


//HELPERS:*********************************************************

function populateClues(players) {
  var clues = players.reduce(function(ret, player){
    return ret.concat(player.clues);
  }, []);
  return clues;
}

function setupTeams(numTeams, players) {
  var playersToAssign = players.slice(), //makes copy of players
      remainder = playersToAssign.length % numTeams,
      playersPerTeam = Math.floor(playersToAssign.length / numTeams),
      teams = [];

  // randomly assign a team to each player that isn't part of extraPlayers
  // remove player from playersToAssign after they join a team
  for ( var i = 0; i < numTeams; i++ ) {
    var team = [];
    for ( var j = 0; j < playersPerTeam; j++ ) {
      var player = getRandomAndRemove(playersToAssign);
      team.push(player);
    }

    teams.push(team);
  }

  // assign extraPlayers to random teams
  if ( remainder !== 0 ) {
    for ( var k = 0; k < remainder; k++ ) {
      var randomTeam = randomElement(teams);
      randomTeam.push(playersToAssign[k]);
      // var indexToRemove = playersToAssign.indexOf()
      playersToAssign.splice(k, 1);
    }
  }

  // assign names to teams:
  assignNamesAndScore(teams);

  return teams;
}

function assignNamesAndScore(teams){
  teams.forEach(function(team, index){
    team.name = 'team-' + (index+1);
    team.score = 0;
  });
}

function randomize(data){
  return data.sort(function(){
    return 0.5 - Math.random();
  });
}

function randomElement(data){
  var myArray = data;
  var index = Math.floor(Math.random() * myArray.length);
  return myArray[index];
}

function getRandomAndRemove(collection){
  collection = randomize(collection);
  var random = randomElement(collection);
  var indexOfRandom = collection.indexOf(random);
  collection.splice(indexOfRandom, 1);
  return random
}

function humanizeCountdown(countdown){
  var countdownString;
  if ( countdown < 10 ) {
    countdownString = "0" + countdown;
  } else {
    countdownString = countdown.toString();
  }
  return countdownString;
}



function showIt(element){
  element.style.display = "inline-block";
}

function hideIt(element){
  element.style.display = "none";
}

// does a good job shuffling but using randomize(), as that's simpler
// function shuffleTeams(teams){
//   var tempArray = teams.slice(),
//       shuffledTeams = [],
//       length = tempArray.length;
//   for (var i = 0; i < length; i++) {
//     var t = getRandomAndRemove(tempArray);
//     shuffledTeams.push(t);
//   }
//   return shuffledTeams;
// }

