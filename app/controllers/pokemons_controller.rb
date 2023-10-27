require 'pokemon/pokemon_client'

class PokemonsController < ApplicationController
  def index
    if params[:name]
      if Pokemon.find_by(name: params[:name])
        @pokemon = Pokemon.find_by(name: params[:name])
      else
        pokemon = ::PokemonSupport::PokemonClient.pokemon_by_name(params[:name])
        @pokemon = Pokemon.new(pokemon)
        @pokemon.save
      end
      redirect_to pokemon_path(@pokemon.name)
    end
  end

  def show
    if params[:contiguious]
      pokemon_name = ::PokemonSupport::PokemonClient.id_by_name(params[:contiguious]) + params[:difference].to_i
    elsif params[:name]
      pokemon_name = params[:name]
    else
      pokemon_name = params[:id]
    end

    if Pokemon.find_by(name: pokemon_name)
      @pokemon = Pokemon.find_by(name: pokemon_name)
    else
      pokemon = ::PokemonSupport::PokemonClient.pokemon_by_name(pokemon_name)
      @pokemon = Pokemon.new(pokemon)
      @pokemon.save
    end

    if params[:contiguious] or params[:name]
      redirect_to pokemon_path(@pokemon.name)
    end
  end

end
