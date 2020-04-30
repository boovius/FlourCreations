//
//  NetworkPublisher.swift
//  FlourCreations
//
//  Created by Joshua Book on 4/30/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation
import Combine

protocol NetworkPublisherType {
  func publishCreations() -> AnyPublisher<CreationResponse, ServerRequestError>
}

class NetworkPublisher {
  private let session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  func publishCreations() -> AnyPublisher<CreationResponse, ServerRequestError> {
    let url =  Environment.apiUrl.appendingPathComponent("api/v1/creations")
    return fetchAndPublish(from: url)
  }

  private func fetchAndPublish<T: Decodable>(from url: URL) -> AnyPublisher<T, ServerRequestError> {

    return session.dataTaskPublisher(for: URLRequest(url: url))
      .retry(1)
      .mapError { error in
        .serverError(message: error.localizedDescription)
    }
    .flatMap { pair in self.decode(pair.data) }
    .eraseToAnyPublisher()
  }

  // TODO: perhaps move this somewhere else (maybe JSONDecoderWrapper)
  private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, ServerRequestError> {
    let decoder = JSONDecoderWrapper()

    return Just(data)
      .decode(type: T.self, decoder: decoder)
      .mapError { error in
        .parsing(message: error.localizedDescription)
    }
    .eraseToAnyPublisher()
  }

}
