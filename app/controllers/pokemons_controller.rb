require 'pokemon/pokemon_client'

class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def show
    if Pokemon.find_by(name: params[:id])
      @pokemon = Pokemon.find_by(name: params[:id])
    else
      pokemon = ::PokemonSupport::PokemonClient.pokemon_by_name(params[:id])
      @pokemon = Pokemon.new(pokemon)
      @pokemon.save
    end
  end
end
