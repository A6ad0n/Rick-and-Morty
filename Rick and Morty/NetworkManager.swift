//
//  NetworkManager.swift
//  Rick and Morty
//
//  Created by Egor Bazakin on 19.07.2024.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    @Published var characters: [Character] = []
    @Published var episodes: [Episode] = []
    private var currentPage = 1
    private var monitor: NWPathMonitor?
    private var queue = DispatchQueue.global(qos: .background)
    var isLoading = false
    var isConnected = true
    
    init() {
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    func startMonitoring() {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor?.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor?.cancel()
        monitor = nil
    }
    
    func fetchCharacters() {
        guard !isLoading else { return }
        isLoading = true
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(currentPage)")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching characters: \(error.localizedDescription)")
                DispatchQueue.main.async { self.isLoading = false }
                return
            }
            guard let data = data
            else {
                print("No data receieved")
                DispatchQueue.main.async { self.isLoading = false }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CharacterResponse.self, from: data)
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: result.results)
                    self.currentPage += 1
                    self.isLoading = false
                    print("Characters fetched successfully: \(self.characters.count) characters")
                }
            } catch {
                print ("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async { self.isLoading = false }
            }
        }.resume()
    }
    
    func fetchEpisodes(episodeURL: String) {
        guard let url = URL(string: episodeURL)
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
                let result = try JSONDecoder().decode(EpisodeResponse.self, from: data)
                DispatchQueue.main.async {
                    self.episodes = result.results
                    print("Episodes fetched successfully: \(self.characters.count) characters")
                }
            } catch {
                print ("Error decoding JSON: \(error.localizedDescription)")
                //WHY THERE'RE ERRORS?!?!?? IDK
                print (error)
            }
        }.resume()
    }
}
