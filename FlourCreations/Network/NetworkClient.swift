import Foundation

protocol NetworkClientType {
  func verify(with phoneNumber: String, onCompletion: @escaping (Result<User, ServerRequestError>) -> Void)
  func fetchCreations(onCompletion: @escaping (Result<CreationResponse, ServerRequestError>) -> Void)
}

class NetworkClient: NetworkClientType {
  private let session = URLSession.shared
  
  func verify(with phoneNumber: String, onCompletion: @escaping (Result<User, ServerRequestError>) -> Void) {
    let url = Config.apiUrl.appendingPathComponent("users/verify")
    let parameters = ["phone_number": phoneNumber]
    
    NetworkClient.request(url: url, parameters: parameters) { data, response, error in
      if data == nil || response == nil || error != nil {
        onCompletion(.failure(.clientError))
        return
      }
      
      var statusCode = 500
      if let response = response as? HTTPURLResponse {
        statusCode = response.statusCode
      }
      
      do {
        switch statusCode {
        case 404:
          let response = try JSONDecoderWrapper().decode(ErrorResponse.self, from: data!)
          onCompletion(.failure(.serverError(message: response.error.message)))
        case 200:
            let user = try JSONDecoderWrapper().decode(User.self, from: data!)
            onCompletion(.success(user))
        default:
          onCompletion(.failure(.serverErrorOther))
        }
      } catch {
        onCompletion(.failure(.clientError))
      }
    }
  }

  func fetchCreations(onCompletion: @escaping (Result<CreationResponse, ServerRequestError>) -> Void) {
    let url = Config.apiUrl.appendingPathComponent("api/v1/creations")

    NetworkClient.get(url: url) { data, response, error in
      if data == nil || response == nil || error != nil {
        onCompletion(.failure(.clientError))
        return
      }

      var statusCode = 500
      if let response = response as? HTTPURLResponse {
        statusCode = response.statusCode
      }

      do {
        switch statusCode {
        case 404:
          let response = try JSONDecoderWrapper().decode(ErrorResponse.self, from: data!)
          onCompletion(.failure(.serverError(message: response.error.message)))
        case 200:
          let creations = try JSONDecoderWrapper().decode(CreationResponse.self, from: data!)
          onCompletion(.success(creations))
        default:
          onCompletion(.failure(.serverErrorOther))
        }
      } catch {
        onCompletion(.failure(.clientError))
      }
    }
  }
}
  
// MARK: Request Methods

extension NetworkClient {
  class func request(url: URL, httpMethod: String = "POST", parameters: Any = [], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
      return
    }
    request.httpBody = httpBody
    session.dataTask(with: request, completionHandler: completionHandler).resume()
  }

  class func get(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    session.dataTask(with: request, completionHandler: completionHandler).resume()
  }
}
