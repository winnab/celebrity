window.onload = function(){
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
        'Shquille O\'Neal'
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

  console.log(players)

  function displayPlayers(data){
    var players = data
    var playersContainer = document.getElementById('players');

    players.forEach(function(player){
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
      })

      playersContainer.appendChild(playerContainer)
    })
  }

  function addStartGameFunctionality() {
    // Game starts on with min num of players
    var start = document.getElementById('start');
    start.onclick = function(e){
      alert('let\'s get started!');
    }
  }

  function assignTeams(num) {
    var playersToAssign = players;

    if ( playersToAssign.length % num !== 0 ) {
      // deal with remainders
      var extraPlayers = playersToAssign.length % num;
      console.log('extraPlayers', extraPlayers);
    }

    var playersPerTeam = Math.floor(playersToAssign.length / num);

    console.log('playersPerTeam', playersPerTeam);

    var teams = [];
    for ( var j = 0; j < num; j++ ) {
      var team = [];
      console.log('-----')
      console.log(j)
      for ( var i = 0; i < playersPerTeam; i++ ) {
        var player = playersToAssign[Math.floor(Math.random() * playersToAssign.length)];
        team.push(player);
        console.log('player', player.name);
        var toRemove = playersToAssign.indexOf(player);
        playersToAssign.splice(toRemove, 1);
      };
      teams.push(team);
    }

    for ( var i = 0; i < extraPlayers; i++ ) {
      var team = teams[Math.floor(Math.random() * teams.length)];
      team.push(playersToAssign[i]);
      playersToAssign.splice(i, 1);
    }

    for ( var i = 0; i < teams.length; i++ ) {
      var team;
      console.log('---------')
      teams[i].name = 'team-' + i;
      console.log(teams[i]);
    }
  }

  displayPlayers(players);
  addStartGameFunctionality();
  assignTeams(2);
};
