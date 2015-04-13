class Clues
  def initialize
    @clues = CLUES
  end

  def random
    random_clues = @clues[0...5]
    @clues = @clues[5...@clues.length]
    return random_clues
  end

  private

  CLUES = [
    "Johnny Cash",
    "Elvis",
    "Dolly Parton",
    "The Beatles",
    "Hank Williams",
    "Queen",
    "Erasure",
    "Squeeze",
    "The Cure",
    "George Michael",
    "Zadie Smith",
    "Michael Ondaatje",
    "Aravind Adiga",
    "J.M. Coetzee",
    "Maya Angelou",
    "Jonah Hill",
    "Seth Rogan",
    "Michael Cera",
    "Emma Stone",
    "James Franco",
    "Jennifer Lawrence",
    "James McAvoy",
    "Michael Fassbender",
    "Nicholas Hoult",
    "Ellen Page",
    "Elizabeth Banks",
    "Will Arnett",
    "Chris Pratt",
    "Cobie Smulders",
    "Shaquille O'Neal",
    "Chris Evans",
    "Samuel L. Jackson",
    "Scarlett Johansson",
    "Sebastian Stan",
    "Robert Redford"
  ]
end
