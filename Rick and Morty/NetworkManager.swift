//
//  NetworkManager.swift
//  Rick and Morty
//
//  Created by Egor Bazakin on 19.07.2024.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var characters: [Character] = []
    func fetchCharacters(from i: Int) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(i)")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching characters: \(error.localizedDescription)")
                return
            }
            guard let data = data
            else {
                print("No data receieved")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CharacterResponse.self, from: data)
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: result.results)
                    print("Characters fetched successfully: \(self.characters.count) characters")
                }
            } catch {
                print ("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
}
}
