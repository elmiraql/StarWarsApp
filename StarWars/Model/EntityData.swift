//
//  ContentData.swift
//  StarWars
//
//  Created by Elmira on 02.04.21.
//

import Foundation

struct PersonData: Decodable {
    let results: [Person]
}
struct Person: Decodable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let url: String?
}

struct PlanetData: Decodable {
    let results: [Planet]
}

struct Planet: Decodable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let population: String
    let url: String?
    let surface_water: String
}

struct SpeciesData: Decodable {
    let results: [Species]
}
struct Species: Decodable {
    let name: String
    let classification: String
    let designation: String
    let average_height: String
    let skin_colors: String
    let hair_colors: String
    let eye_colors: String
    let average_lifespan: String
    let language: String
    let url: String?
}

struct StarshipsData: Decodable {
    let results: [Starship]
}
struct Starship: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let length: String
    let max_atmosphering_speed: String
    let crew: String
    let passengers: String
    let cargo_capacity: String
    let consumables: String
    let hyperdrive_rating: String
    let starship_class: String
    let url: String?
}
