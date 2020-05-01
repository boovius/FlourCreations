//
//  Step.swift
//  FlourCreations
//
//  Created by Joshua Book on 5/1/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct StepView: View {
  var viewModel: StepViewModel
  var body: some View {
    HStack(alignment: .top, spacing: 5) {
      Text(viewModel.order)
      Text("|")
      Text(viewModel.description)
      Text("|")
      Text(viewModel.time)
    }
  }
}

struct StepView_Previews: PreviewProvider {
  static var previews: some View {
    let step = Step(id:"123", description: "You are going to do this to make some awesome awesome stuff!", order: 1, seconds: 630, photos:[])
    let viewModel = StepViewModel(step: step)
    return StepView(viewModel: viewModel)
  }
}
