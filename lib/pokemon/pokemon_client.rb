require 'poke-api-v2'

module PokemonSupport
    class PokemonClient
        def self.pokemon_by_name(name)
            pokemon_details = PokeApi.get(pokemon: name)
            pokemon_object = JSON.parse(pokemon_details.to_json).with_indifferent_access
            pokemon = {
                name: pokemon_object[:name],
                height: pokemon_object[:height],
                weight: pokemon_object[:weight],
                image: pokemon_object[:sprites][:front_default],
                base_experience: pokemon_object[:base_experience]
            }
        end

        def self.id_by_name(name)
            pokemon_details = PokeApi.get(pokemon: name)
            pokemon_object = JSON.parse(pokemon_details.to_json).with_indifferent_access
            id_pokemon = pokemon_object[:id]
        end

        def self.pokemon_by_type(type)
            pokemon_types = PokeApi.get(type: type)
            pokemons = JSON.parse(pokemon_types.to_json).with_indifferent_access.slice :pokemon
            pokemons[:pokemon].map { |element| element[:pokemon][:name] }
        end
    end
end