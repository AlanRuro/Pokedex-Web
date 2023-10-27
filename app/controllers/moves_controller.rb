require 'pokemon/pokemon_client'

class MovesController < ApplicationController
    def index
        @pokemon = Pokemon.find_by(name: params[:pokemon_id])
        pokemon_moves = ::PokemonSupport::PokemonClient.moves_by_pokemon(params[:pokemon_id])
        pokemon_moves.each { |move| @pokemon.moves.create(move) }
        @moves = @pokemon.moves
    end
end
