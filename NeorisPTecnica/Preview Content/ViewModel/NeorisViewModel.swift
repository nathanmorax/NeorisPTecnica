//
//  NeorisViewModel.swift
//  NeorisPTecnica
//
//  Created by Jesus Mora on 27/11/24.
//

import Combine

class NeorisViewModel: ObservableObject {
    @Published var photo: [PhotoResponse] = []
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPhotos() {
        APIService.shared.fetchPhotos()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { [weak self] photos in
                self?.photo = photos
            }
            .store(in: &cancellables)
    }
}
