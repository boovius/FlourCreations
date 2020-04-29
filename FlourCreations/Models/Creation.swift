//
//  File.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/28/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

struct CreationResponse: Codable {
  var data: [Creation]
}

struct Creation: Identifiable, Codable {
  var id: String
  var name: String
  var summary: String?
}
