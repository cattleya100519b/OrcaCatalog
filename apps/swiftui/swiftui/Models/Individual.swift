//
//  Individual.swift
//  swiftui
//
//  Created by Shota Teranishi on 2026/09/07.
//

struct Individual: Identifiable {
    let id: String
    let name: String
    let description: String
}

let individuals = [
    Individual(
        id: "K-001",
        name: "K-001",
        description: "Adult · Known individual"
    ),
    Individual(
        id: "K-002",
        name: "K-002",
        description: "Adult · Known individual"
    ),
    Individual(
        id: "K-003",
        name: "K-003",
        description: "Juvenile · Known individual"
    ),
    Individual(
        id: "K-004",
        name: "K-004",
        description: "Adult · Known individual"
    ),
]
