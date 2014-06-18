window.onload = function(){

  var teams = [];
  var players = [
    {
    name: 'Neil',
      clues: [
        'Johnny Cash',
        'Elvis',
        'Dolly Parton',
        'The Beatles',
        'Hank Williams'
      ]
    }, {
    name: 'Winna',
      clues: [
        'Queen',
        'Erasure',
        'Squeeze',
        'The Cure',
        'George Michael'
      ]
    }, {
    name: 'Divya',
      clues: [
        'Zadie Smith',
        'Michael Ondaatje',
        'Aravind Adiga',
        'J.M. Coetzee',
        'Maya Angelou'
      ]
    }, {
    name: 'Gautam',
      clues: [
        'Jonah Hill',
        'Seth Rogan',
        'Michael Cera',
        'Emma Stone',
        'James Franco'
      ]
    }, {
    name: 'Maloney',
      clues: [
        'Jennifer Lawrence',
        'James McAvoy',
        'Michael Fassbender',
        'Nicholas Hoult',
        'Ellen Page'
      ]
    }, {
    name: 'Sophie',
      clues: [
        'Elizabeth Banks',
        'Will Arnett',
        'Chris Pratt',
        'Cobie Smulders',
        'Shaquille O\'Neal'
      ]
    }, {
    name: 'Neha',
      clues: [
        'Chris Evans',
        'Samuel L. Jackson',
        'Scarlett Johansson',
        'Sebastian Stan',
        'Robert Redford'
      ]
    }
  ];

  function createLists(data, id){
    var listItems = data;
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
      console.log('---------');
      teams[l].name = 'team-' + l;
      console.log(teams[l]);
    }
  }

  function displayTeams(){
    var teamsContainer = document.getElementById('teams');
  }

  createLists(players, 'players');
  addStartGameFunctionality();
  assignTeams(2);
};
