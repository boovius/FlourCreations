//
//  Step.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/30/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

struct Step: Hashable, Codable, Identifiable, Equatable {
  var id: String
  var description: String
  var order: Int?
  var seconds: Int?
  var photos: [Photo] = []

  static func == (lhs: Step, rhs: Step) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
