//
//  CreationHeaderView.swift
//  FlourCreations
//
//  Created by Joshua Book on 5/1/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct CreationHeaderView: View {
  @Environment(\.imageCache) var cache: ImageCache
  var creation: Creation

  var body: some View {
    VStack {
      HStack {
        AsyncImage(
          urlString: creation.headerPhoto.url,
          placeholder: Text("Loading ..."),
          cache: cache,
          configuration: { $0.resizable() }

        )
          .aspectRatio(contentMode: .fit)
          .frame(minHeight: 200)
          .frame(width: 200)
        Text(creation.name)
          .font(.title)
      }
      Text(creation.summary ?? "")
        .font(.body)
        .padding()
    }
  }
}

struct CreationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
      let headerPhoto = Photo(id: "1", url: "https://creation-shelf.s3.amazonaws.com/7BAF4AB6-D740-4279-A12E-6CC074DD6689.jpeg")
      let creation = Creation(id: "123", name: "An amazing new recipe with all sorts of stuff!", summary: "With all sorts of goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies.", headerPhoto: headerPhoto)
      return CreationHeaderView(creation: creation)
    }
}
