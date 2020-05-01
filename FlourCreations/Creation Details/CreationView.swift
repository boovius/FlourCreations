//
//  CreationView.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/30/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct CreationView: View {
  @Environment(\.imageCache) var cache: ImageCache
  var creation: Creation

  var body: some View {
    NavigationView {
      ScrollView {
        CreationHeaderView(creation: creation)
        recipe()
      }.padding(.top, 50)
    }
  }

  private func recipe() -> AnyView {
    guard let recipe = creation.recipe else {
      return AnyView(Text("no recipe")) }
    return AnyView(RecipeView(recipe: recipe))
  }

  private func photos() -> some View {
    ScrollView(.horizontal, content: {
      HStack(spacing: 10) {
        TupleView(
          creation.photos.prefix(10).map { photo in
            AsyncImage(
              urlString: photo.url,
              placeholder: Text("Loading ..."),
              cache: self.cache,
              configuration: { $0.resizable() }
            ).aspectRatio(2/3, contentMode: .fit)
          }
        )
      }.padding(.leading, 10)
    }).frame(height: 190)
  }
}

struct CreationView_Previews: PreviewProvider {
  static var previews: some View {
    let headerPhoto = Photo(id: "1", url: "https://creation-shelf.s3.amazonaws.com/7BAF4AB6-D740-4279-A12E-6CC074DD6689.jpeg")
    let step1 = Step(id:"123", description: "You are going to do this to make some awesome awesome stuff!", order: 1, seconds: 630, photos:[])
    let step2 = Step(id:"223", description: "You are going to do this to make some awesome awesome stuff!", order: 2, seconds: 630, photos:[])
    let step3 = Step(id:"323", description: "You are going to do this to make some awesome awesome stuff!", order: 3, seconds: 630, photos:[])
    let recipe = Recipe(id: "123", steps: [step1, step2, step3])
    let creation = Creation(id: "123", name: "An amazing new recipe with all sorts of stuff!", summary: "With all sorts of goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies and goodies.", headerPhoto: headerPhoto, photos: [headerPhoto, headerPhoto], recipe: recipe)
    return CreationView(creation: creation)
  }
}
