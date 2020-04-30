//
//  Step.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/30/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

struct Step: Codable {
  var id: String
  var description: String
  var order: Int?
  var seconds: Int?
  var photos: [Photo]
}
