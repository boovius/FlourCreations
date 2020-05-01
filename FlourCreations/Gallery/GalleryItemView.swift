//
//  Creation.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/28/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct GalleryItem: View {
  @Environment(\.imageCache) var cache: ImageCache
  var creation: Creation

  var body: some View {
    VStack(alignment: .leading) {
      AsyncImage(
        urlString: creation.headerPhoto.url,
        placeholder: Text("Loading ..."),
        cache: self.cache,
        configuration: { $0.resizable() }
      ).aspectRatio(contentMode: .fit)
      Text(creation.name)
        .font(.title)
      Text(creation.summary ?? "")
    }
  }
}

struct GalleryItem_Previews: PreviewProvider {
    static var previews: some View {
      let headerPhoto = Photo(id: "1", url: "https://creation-shelf.s3.amazonaws.com/7BAF4AB6-D740-4279-A12E-6CC074DD6689.jpeg")
      let steps = [
        Step(id: "1", description: "asdfasdfasdf", photos: []),
        Step(id: "2", description: "bjbjbjbbjbjbjbj", photos: [])
      ]
      let recipe = Recipe(id: "1", steps: steps, photos: [])
      let creation = Creation(id: "123", name: "a new thing", summary: "With all sorts of goodies.", headerPhoto: headerPhoto, photos: [], recipe: recipe)
      return GalleryItem(creation: creation)
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
