//
//  ContentView.swift
//  NeorisPTecnica
//
//  Created by Jesus Mora on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NeorisViewModel()
    @State private var selectedPhoto: PhotoResponse?
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            List(viewModel.photo) { photo in
                PhotoRowView(photo: photo)
                    .onTapGesture {
                        selectedPhoto = photo
                        showingDetail = true
                    }
            }
            .navigationTitle("Photos")
            .onAppear {
                viewModel.fetchPhotos()
            }
            .alert("Error", isPresented: Binding(
                get: { viewModel.error != nil },
                set: { if !$0 { viewModel.error = nil } }
            )) {
                Text(viewModel.error?.localizedDescription ?? "Unknown error")
            }
            .sheet(isPresented: $showingDetail) {
                if let photo = selectedPhoto {
                    PhotoDetailView(photo: photo)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.medium, .large])
                }
            }
            .background(Color.black)

        }
        .background(Color.black)
    }
}
#Preview {
    ContentView()
}

