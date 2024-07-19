//
//  CharacterDetailView.swift
//  Rick and Morty
//
//  Created by Egor Bazakin on 19.07.2024.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var networkManager = NetworkManager()
    let character: Character
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12.5))
                .padding()
                
                RoundedRectangle(cornerRadius: 12.5)
                    .fill(rectangleColor(for: character.status))
                    .frame(width: 300, height: 40)
                    .overlay(
                        Text(character.status)
                            .foregroundColor(.white)
                            .font(.system(size: 24.0)))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Species: ").bold()
                        Text("\(character.species)")
                    }
                    HStack {
                        Text("Gender: ").bold()
                        Text("\(character.gender)")
                    }
                    HStack(alignment: .top) {
                        Text("Episodes: ").bold()
                        Text(character.episode.map { $0.split(separator: "").last! }.joined(separator: ", "))
                    }
                    HStack {
                        Text("Last Known Location: ").bold()
                        Text("\(character.location.name)")
                    }
                }
            }
            .frame(width: 330, height: 550)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12.5).fill(.black.opacity(0.1)))
        }
        .onAppear {
            for episode in character.episode {
                networkManager.fetchEpisodes(episodeURL: episode)
            }
        }
        .navigationTitle(character.name)
    }
}

func rectangleColor(for status: String) -> Color {
    switch status {
    case "Alive":
        return .green
    case "Dead":
        return .red
    default:
        return .gray
    }
}

#Preview {
    CharacterDetailView(character: Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
        location: Location(name: "Citadel of Ricks",url :"https://rickandmortyapi.com/api/location/3"),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: ["https://rickandmortyapi.com/api/episode/1","https://rickandmortyapi.com/api/episode/2","https://rickandmortyapi.com/api/episode/3","https://rickandmortyapi.com/api/episode/4","https://rickandmortyapi.com/api/episode/5","https://rickandmortyapi.com/api/episode/6","https://rickandmortyapi.com/api/episode/7","https://rickandmortyapi.com/api/episode/8","https://rickandmortyapi.com/api/episode/9","https://rickandmortyapi.com/api/episode/10","https://rickandmortyapi.com/api/episode/11","https://rickandmortyapi.com/api/episode/12","https://rickandmortyapi.com/api/episode/13","https://rickandmortyapi.com/api/episode/14","https://rickandmortyapi.com/api/episode/15","https://rickandmortyapi.com/api/episode/16","https://rickandmortyapi.com/api/episode/17","https://rickandmortyapi.com/api/episode/18","https://rickandmortyapi.com/api/episode/19","https://rickandmortyapi.com/api/episode/20","https://rickandmortyapi.com/api/episode/21","https://rickandmortyapi.com/api/episode/22","https://rickandmortyapi.com/api/episode/23","https://rickandmortyapi.com/api/episode/24","https://rickandmortyapi.com/api/episode/25","https://rickandmortyapi.com/api/episode/26","https://rickandmortyapi.com/api/episode/27","https://rickandmortyapi.com/api/episode/28","https://rickandmortyapi.com/api/episode/29","https://rickandmortyapi.com/api/episode/30","https://rickandmortyapi.com/api/episode/31","https://rickandmortyapi.com/api/episode/32","https://rickandmortyapi.com/api/episode/33","https://rickandmortyapi.com/api/episode/34","https://rickandmortyapi.com/api/episode/35","https://rickandmortyapi.com/api/episode/36","https://rickandmortyapi.com/api/episode/37","https://rickandmortyapi.com/api/episode/38","https://rickandmortyapi.com/api/episode/39","https://rickandmortyapi.com/api/episode/40","https://rickandmortyapi.com/api/episode/41","https://rickandmortyapi.com/api/episode/42","https://rickandmortyapi.com/api/episode/43","https://rickandmortyapi.com/api/episode/44","https://rickandmortyapi.com/api/episode/45","https://rickandmortyapi.com/api/episode/46","https://rickandmortyapi.com/api/episode/47","https://rickandmortyapi.com/api/episode/48","https://rickandmortyapi.com/api/episode/49","https://rickandmortyapi.com/api/episode/50","https://rickandmortyapi.com/api/episode/51"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z"
    ))
}

