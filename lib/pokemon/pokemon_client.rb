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

        def self.move_by_name(name)
            move_details = PokeApi.get(move: name)
            move_object = JSON.parse(move_details.to_json).with_indifferent_access
            move = {
                name: move_object[:name],
                power: move_object[:power],
                description: move_object[:effect_entries][0][:short_effect],
                category: move_object[:type][:name]
            }
        end

        def self.moves_by_pokemon(name)
            pokemon_details = PokeApi.get(pokemon: name)
            pokemon = JSON.parse(pokemon_details.to_json).with_indifferent_access.slice :moves
            pokemon[:moves].take(3).map { |element| move_by_name(element[:move][:name]) }
        end
    end
end