//
//  SwiftUIView.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/28/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI


struct Gallery: View {
  var body: some View {
    List(creations(), id: \.id) { creation in
      GalleryItem(creation: creation)
    }
  }

  private func creations() -> [Creation] {
    let creationDicts = [
      ["id": "123", "name": "First bread"],
      ["id": "456", "name": "Second bread", "summary": "With Summary."]
    ]
    do {
      let json = try JSONSerialization.data(withJSONObject: creationDicts)
      return try JSONDecoderWrapper().decode([Creation].self, from: json)
    } catch {
      return []
    }
  }
}

struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery()
    }
}
