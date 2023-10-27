require 'pokemon/pokemon_client'

class PokemonsController < ApplicationController
  def index
    if params[:name]
      show()
    end
    @pokemons = Pokemon.new
  end

  def show
    pokemon_name = params[:name] ? params[:name] : params[:id]

    if Pokemon.find_by(name: pokemon_name)
      @pokemon = Pokemon.find_by(name: pokemon_name)
    else
      pokemon = ::PokemonSupport::PokemonClient.pokemon_by_name(pokemon_name)
      @pokemon = Pokemon.new(pokemon)
      @pokemon.save
    end

    if params[:name]
      redirect_to pokemon_path(@pokemon.name)
    end
  end

end
