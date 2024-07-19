//
//  NoInternetView.swift
//  Rick and Morty
//
//  Created by Egor Bazakin on 19.07.2024.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://c4.wallpaperflare.com/wallpaper/502/79/727/rick-and-morty-rick-sanchez-wallpaper-thumb.jpg")) {image in 
                image
                    .resizable()
                    .frame(width: 551, height: 310)
                    .padding()
            } placeholder: {
                ProgressView()
            }
            Text("Network Error")
                .font(.title)
                .padding()
                .bold()
            Text("There was an error connecting.")
            Text("Please check your connection.")
                .padding()
            Button {
                
            } label: {
                Text("Retry")
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 100)
            .background(.cyan)
            .clipShape(RoundedRectangle(cornerRadius: 12.5))
            .foregroundColor(.white)
            

        }
    }
}

#Preview {
    NoInternetView()
}
