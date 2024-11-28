//
//  PhotoDetailView.swift
//  NeorisPTecnica
//
//  Created by Jesus Mora on 27/11/24.
//
import SwiftUI

struct PhotoDetailView: View {
    let photo: PhotoResponse
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: photo.url ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Details")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Title:")
                            .fontWeight(.medium)
                        Text(photo.title ?? "No title")
                        
                        Text("Album ID: \(photo.title)")
                        Text("Photo ID: \(photo.id)")
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Photo Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

