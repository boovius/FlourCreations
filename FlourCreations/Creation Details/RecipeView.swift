//
//  RecipeView.swift
//  FlourCreations
//
//  Created by Joshua Book on 5/1/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct RecipeView: View {
  var recipe: Recipe
  var body: some View {
    VStack {
      Text("Recipe").font(.headline)
      List {
        Section(header: Text("Steps")) {
          ForEach(recipe.steps) {
            StepView(viewModel: StepViewModel(step: $0))
          }
        }
      }.frame(height: 500)
    }
  }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
      let step1 = Step(id:"123", description: "You are going to do this to make some awesome awesome stuff!", order: 1, seconds: 630, photos:[])
      let step2 = Step(id:"223", description: "You are going to do this to make some awesome awesome stuff!", order: 2, seconds: 630, photos:[])
      let step3 = Step(id:"323", description: "You are going to do this to make some awesome awesome stuff!", order: 3, seconds: 630, photos:[])
      let recipe = Recipe(id: "123", steps: [step1, step2, step3])
      return RecipeView(recipe: recipe)
    }
}
