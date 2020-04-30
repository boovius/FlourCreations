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

  init(viewModel: GalleryViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      List(viewModel.creations, id: \.id) { creation in
        NavigationLink(destination: CreationView(creation: creation)) {
          GalleryItem(creation: creation)
        }

      }.onAppear(perform: viewModel.loadCreations)
      .navigationBarTitle("My Creations")
    }
  }
}

struct Gallery_Previews: PreviewProvider {
  static var previews: some View {
    Gallery(viewModel: GalleryViewModel())
  }
}
