class JoinsController
  def join_game session, params
    session["joined_player"] = {
      status: "joined",
      email: params["join_email"],
      clues: [
        params["clue_1"],
        params["clue_2"],
        params["clue_3"],
        params["clue_4"],
        params["clue_5"]
      ]
    }
  end
end


