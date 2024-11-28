//
//  PhotoRowView.swift
//  NeorisPTecnica
//
//  Created by Jesus Mora on 27/11/24.
//
import SwiftUI

struct PhotoRowView: View {
    let photo: PhotoResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: photo.thumbnailURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
            } placeholder: {
                ProgressView()
            }
            
            Text(photo.title ?? "Empty")
                .font(.caption)
        }
    }
}
