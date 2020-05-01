//
//  Recipe.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/30/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

struct Recipe: Codable {
  var id: String
  var inspiredBy: String?
  var sourceUrl: String?
  var steps: [Step] = []
  var photos: [Photo] = []
}
