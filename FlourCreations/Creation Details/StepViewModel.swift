//
//  File.swift
//  FlourCreations
//
//  Created by Joshua Book on 5/1/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

protocol StepViewModelType {

}

class StepViewModel {
  var step: Step

  init(step: Step) {
    self.step = step
  }

  var time: String {
    guard let seconds = step.seconds else { return "" }
    return String(format: "%.1f mins", Float(seconds) / 60)
  }

  var order: String {
    guard let order = step.order else { return "" }
    return String(format: "%i)", order)
  }

  var description: String {
    step.description
  }

}
