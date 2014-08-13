window.onload = function(){

  var teams = [];
  var players

  $.get('./scripts/data.json', function(data){
    players = data;

    createPlayerLists(players, 'players');
    var teams = assignTeams(2);
    console.log(teams);
    createTeamsList(players, teams, 'teams');
    addStartGameFunctionality();
  });

  function createPlayerLists(players, id){
    var listItems = players;
    var listContainer = document.getElementById(id);

    listItems.forEach(function(player){
      var playerContainer = document.createElement('div');
      var playerName = document.createElement('h3');
      var playerClues = document.createElement('ul');

      playerContainer.appendChild(playerName);
      playerName.textContent = player.name;

      playerContainer.appendChild(playerClues);
      player.clues.forEach(function(clue){
        var clueLi = document.createElement('li');
        clueLi.textContent = clue;
        playerClues.appendChild(clueLi);
      });

      listContainer.appendChild(playerContainer)
    });
  }

  function createTeamsList(players, teams, id){
    var listItems = teams;
    var listContainer = document.getElementById(id);

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

      listContainer.appendChild(teamContainer);
    });
  }

  function addStartGameFunctionality() {
    // Game starts on with min num of players
    var start = document.getElementById('start');
    start.onclick = function(e){
      alert('let\'s get started!');
    }
  }

  function assignTeams(count) {
    var numTeams = count;
    var playersToAssign = players;
    var extraPlayers;

    if ( playersToAssign.length % numTeams !== 0 ) {
      // deal with remainders
      extraPlayers = playersToAssign.length % numTeams;
    }

    var playersPerTeam = Math.floor(playersToAssign.length / numTeams);

    // randomly assign a team to each player that isn't part of extraPlayers
    // remove player from playersToAssign after they join a team
    for ( var i = 0; i < numTeams; i++ ) {
      var team = [];
      for ( var j = 0; j < playersPerTeam; j++ ) {
        var player = playersToAssign[Math.floor(Math.random() * playersToAssign.length)];
        team.push(player);
        var toRemove = playersToAssign.indexOf(player);
        playersToAssign.splice(toRemove, 1);
      }
      teams.push(team);
    }

    // assign extraPlayers to random teams
    for ( var k = 0; k < extraPlayers; k++ ) {
      var randomTeam = teams[Math.floor(Math.random() * teams.length)];
      randomTeam.push(playersToAssign[k]);
      playersToAssign.splice(k, 1);
    }

    // debugging
    for ( var l = 0; l < teams.length; l++ ) {
      teams[l].name = 'team-' + l;
    }

    return teams;
  }

  function displayClue (clues) {

  }
  // randomizeClue
  // advanceToNextClue
  // skipClue
};
