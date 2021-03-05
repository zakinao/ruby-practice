require './message_dialog'

class GamesController
  include MessageDialog

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  def battle(**params)
    build_characters(params)

    brave = params[:brave]
    monster = params[:monster]

    loop do
      brave.attack(@monster)
      break if battle_end?
      monster.attack(@brave)
      break if battle_end?
    end

    battle_judgment
  end

  private
    def build_characters(**params)
      @brave = params[:brave]
      @monster = params[:monster]
    end

    def battle_end?
      @brave.hp <= 0 || @monster.hp <= 0
    end

    def brave_win?
      @brave.hp > 0
    end

    def battle_judgment
        result = calculate_of_exp_and_gold
        end_message(result)
    end

    def calculate_of_exp_and_gold
      exp = (@monster.offense + @monster.defense) * EXP_CONSTANT
      gold = (@monster.offense + @monster.defense) * GOLD_CONSTANT
      result = {exp: exp, gold: gold}
      result
    end
end
