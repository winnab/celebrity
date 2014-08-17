window.onload = function(){
  $.get('./scripts/data.json', function(data){
    var players = data;
    var globalPlayers = data;
    
    var displayPlayersOnPage = createPlayerLists(players, 'players');

    console.log(globalPlayers.length);

    var teams = assignTeams(2, globalPlayers);
    createTeamsList(globalPlayers, teams, 'teams');
    addStartGameFunctionality();
    var clues = populateClues(globalPlayers);

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

    function assignTeams(count, players) {
      var numTeams = count,
          playersToAssign = players.slice(), //gives copy of players
          remainder = playersToAssign.length % numTeams,
          playersPerTeam = Math.floor(playersToAssign.length / numTeams),
          teams = [];

      // randomly assign a team to each player that isn't part of extraPlayers
      // remove player from playersToAssign after they join a team
      for ( var i = 0; i < numTeams; i++ ) {
        var team = [];
        for ( var j = 0; j < playersPerTeam; j++ ) {
          var player = randomElement(playersToAssign);
          team.push(player);
          var assignedPlayerIndex = playersToAssign.indexOf(player);
          playersToAssign.splice(assignedPlayerIndex, 1);
        }

        teams.push(team);
      }

      // assign extraPlayers to random teams
      if ( remainder !== 0 ) {
        // deal with remainders
        for ( var k = 0; k < remainder; k++ ) {
          var randomTeam = randomElement(teams);
          randomTeam.push(playersToAssign[k]);
          // var indexToRemove = playersToAssign.indexOf()
          playersToAssign.splice(k, 1);
        }
      }

      // assign names to teams:
      teams.forEach(function(team, index){
        team.name = 'team-' + index
      });

      return teams;
    }

    function populateClues(players) {
      var clues = players.reduce(function(ret, player){
        return ret.concat(player.clues);
      }, []);
      return clues;
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

    function displayClue(clues){
      var randomClues = randomize(clues);
      var randomClue = randomElement(randomClues);
      var clueElement = document.createElement('p');
      var clueContainer = document.getElementById('clue').appendChild(clueElement);
      clueElement.textContent = randomClue;
      return randomClue;
    }

    var currentTeam;
    function pickTurn(){
      currentTeam = randomize(teams);
    }

    $("#startTurn").on("click", function(){

      var playedClues = [];
      // console.log("clicked startTurn");
      //show clue:
      var currentClue = displayClue(clues);
      // set up an tem unavaialbele array to keep track
      playedClues.push(currentClue);
      //start timer:
      // ...
      //
    });

    // var playerContainer = document.createElement('div');
    //     var playerName = document.createElement('h3');
    //     var playerClues = document.createElement('ul');

    //     playerContainer.appendChild(playerName);
    //     playerName.textContent = player.name;









  }); // END $.get

  // start game
  // start turn
  // randomizeClues
  // display clue
  // advanceToNextClue
  // increment score
  // skipClue
  // decrement score

}; // END window.onload
