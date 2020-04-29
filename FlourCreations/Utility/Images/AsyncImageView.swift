//
//  AsyncImageView.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/29/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
  @ObservedObject private var loader: ImageLoader
  private let placeholder: Placeholder?

  init(urlString: String, placeholder: Placeholder? = nil) {
    // TODO: address url vs urlString here and forcing unwrapping of optional
    let url = URL(string: urlString)
    loader = ImageLoader(url: url!)
    self.placeholder = placeholder
  }

  var body: some View {
    image
      .onAppear(perform: loader.load)
      .onDisappear(perform: loader.cancel)
  }

  private var image: some View {
    Group {
      if loader.image != nil {
        Image(uiImage: loader.image!).resizable()
      } else {
        placeholder
      }
    }
  }
}

//struct AsyncImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageView()
//    }
//}
