require_relative "../lib/game"

describe Game do
  describe "#user_input" do
    context "when input invalid once" do
      subject(:invalid_input) { described_class.new }
      before do
        allow(invalid_input).to receive(:gets).and_return("f", "4")
      end
      it "returns error once" do
        first_message = " please enter where you want to go... (1-9)"
        second_message = " please enter a valid input (1-9), that is not taken..."
        expect(invalid_input).to receive(:puts).with(first_message).once
        expect(invalid_input).to receive(:puts).with(second_message).once
        invalid_input.user_input
      end
      it "returns correct input" do
        expect(invalid_input.user_input).to eq(4)
      end
    end
    context "when input valid" do
      subject(:valid_input) { described_class.new }
      before do
        allow(valid_input).to receive(:gets).and_return("4")
      end
      it "returns user input" do
        expect(valid_input.user_input).to eq(4)
      end
    end
  end
  describe "#game_over" do
    let(:player1) { instance_double("Player", name: "Bob", symbol: "x", score: 0) }
    let(:player2) { instance_double("Player", name: "Steve", symbol: "o", score: 0) }
    context "when player 1 wins" do
      let(:takenspaces) { ["x", "x", "x", " ", " ", " ", " ", " ", " "] }

      subject(:end_game) { described_class.new(player1, player2, takenspaces) }
      it "returns true and 'Bob'" do
        allow(player1).to receive(:score=)
        allow(end_game).to receive(:winner).with("Bob")
        expect(end_game.game_over).to be(true)
      end
    end
    context "when player 2 wins" do
      let(:takenspaces) { ["o", "o", "o", " ", " ", " ", " ", " ", " "] }

      subject(:end_game) { described_class.new(player1, player2, takenspaces) }
      it "returns true and 'Steve'" do
        allow(player2).to receive(:score=)
        allow(end_game).to receive(:winner).with("Steve")
        expect(end_game.game_over).to be(true)
      end
    end
    context "when all space are full and no one wins" do
      let(:takenspaces) { ["x", "o", "x", "x", "x", "o", "o", "x", "o"] }

      subject(:end_game) { described_class.new(player1, player2, takenspaces) }
      it "returns true and 'Cat'" do
        allow(player2).to receive(:score=)
        allow(end_game).to receive(:winner).with("Cat")
        expect(end_game.game_over).to be(true)
      end
    end
    context "when not all spaces are full and no one has won" do
      let(:takenspaces) { ["o", "o", "", " ", " ", " ", " ", " ", " "] }

      subject(:end_game) { described_class.new(player1, player2, takenspaces) }
      it "returns false" do
        expect(end_game.game_over).to be(false)
      end
    end
  end
end
