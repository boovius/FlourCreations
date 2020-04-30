//
//  GalleryViewModel.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/29/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine

class GalleryViewModel: ObservableObject {
  private var cancellable: AnyCancellable?
  @Published var creations: [Creation] = []

  deinit {
    cancellable?.cancel()
  }
}

// MARK: - data source methods
extension GalleryViewModel {
  func loadCreations() {
    let url =  Environment.apiUrl.appendingPathComponent("api/v1/creations")
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .tryMap() { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 300 else {
          throw URLError(.badServerResponse)
        }
        return element.data
      }
      .decode(type: CreationResponse.self, decoder: JSONDecoderWrapper())
      .receive(on: DispatchQueue.main)
      .map { $0.data }
      .sink(
        receiveCompletion: {
          print("received completion\($0)")

      },
        receiveValue: { [weak self] creations in
          guard let self = self else { return }
          self.creations = creations
      })
  }
}
