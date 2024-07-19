//
//  ContentView.swift
//  Rick and Morty
//
//  Created by Egor Bazakin on 19.07.2024.
//

import SwiftUI


struct CharacterView: View {
    @StateObject var networkManager = NetworkManager()
    var body: some View {
        NavigationView {
            List(networkManager.characters) { character in
                ZStack(alignment: .topLeading) {
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        EmptyView()
                    }
                    .opacity(0)
                    
                    HStack (alignment: .center) {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 12.5))
                        .clipped()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(character.name).font(.system(size: 20.0)).bold().lineLimit(1)
                            
                            HStack(alignment: .center) {
                                
                                Text(character.status).foregroundColor(statusColor(for: character.status))
                                
                                Circle()
                                    .frame(width: 5, height: 5)
                                Text(character.species)
                            }
                            .font(.system(size: 14.0))
                            .bold()
                            
                            Text(character.gender).font(.system(size: 11.0))
                        }
                        .foregroundColor(.black)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12.5).fill(.black.opacity(0.1)))
            }
            .navigationTitle("Characters")
            .scrollContentBackground(.hidden)
        }
        .onAppear {
                networkManager.fetchCharacters(from: 1)
        }
    }
}

func statusColor(for status: String) -> Color {
    switch status {
    case "Alive":
        return .green
    case "unknown":
        return .gray
    case "Dead":
        return .red
    default:
        return .black
    }
}

#Preview {
    CharacterView()
}
