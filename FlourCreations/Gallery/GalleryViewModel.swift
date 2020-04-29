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
  private let newtworkClient: NetworkClientType
  @Published var creations: [Creation] = []

  init(networkClient: NetworkClientType = NetworkClient()) {
    self.newtworkClient = networkClient
  }
}

// MARK: - data source methods
extension GalleryViewModel {
  func loadCreations() {
    NetworkClient().fetchCreations() { result in
      switch result {
      case .success(let creationResponse):
        self.creations = creationResponse.data
      case .failure(let error):
        print(error)
      }
    }
  }
}
