//
//  Creation.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/28/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct GalleryItem: View {
  var creation: Creation

  var body: some View {
    VStack {
      Text(creation.name)
        .font(.title)
      Text(creation.summary ?? "")
    }
  }
}

struct GalleryItem_Previews: PreviewProvider {
    static var previews: some View {
      GalleryItem(creation: Creation(id: "123", name: "a new thing", summary: "With all sorts of goodies."))
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
