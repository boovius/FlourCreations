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
  @Published var error: ServerRequestError?

  deinit {
    cancellable?.cancel()
  }
}

// MARK: - data source methods
extension GalleryViewModel {
  func loadCreations() {
    cancellable = NetworkPublisher().publishCreations()
      .map { $0.data }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self = self else { return }
          switch completion {
          case .failure(let error):
            self.error = .serverError(message: error.localizedDescription)
          case .finished:
            print("Finished receiving Creations.")
          }

        },
        receiveValue: { [weak self] creations in
          guard let self = self else { return }
          self.creations = creations
        })
  }
}

struct GalleryViewModel_Previews: PreviewProvider {
  static var previews: some View {
    /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
  }
}
