//
//  SwiftUIView.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/28/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine


struct Gallery: View {
  @ObservedObject var viewModel: GalleryViewModel
  @State var creations: [Creation] = []

  init(viewModel: GalleryViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    List(creations, id: \.id) { creation in
      GalleryItem(creation: creation)
    }.onAppear(perform: loadCreations)
  }

  // TODO: remove to rely on viewModel method
  // when getting publishing/observing working
  private func loadCreations() {
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

struct Gallery_Previews: PreviewProvider {
  static var previews: some View {
    Gallery(viewModel: GalleryViewModel())
  }
}
