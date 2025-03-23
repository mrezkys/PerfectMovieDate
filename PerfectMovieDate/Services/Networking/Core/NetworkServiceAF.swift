//
//  NetworkServiceAF.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 30/07/24.
//
import Foundation
import Alamofire
 
class NetworkServiceAF: NetworkServiceProtocol {
    private let logger: NetworkLoggerProtocol

    required init(logger: NetworkLoggerProtocol = NetworkLogger.shared) {
        self.logger = logger
    }

    func fetchData(
        from urlString: String,
        method: NetworkRequestType,
        headers: [String: String]?,
        requestBody: Encodable?,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badURL))
            return
        }

        var httpMethod: HTTPMethod {
            switch method {
            case .GET:
                return .get
            case .POST:
                return .post
            case .PUT:
                return .put
            case .DELETE:
                return .delete
            }
        }

        var httpHeaders: HTTPHeaders = HTTPHeaders()
        if let headers = headers {
            for (key, value) in headers {
                httpHeaders.add(name: key, value: value)
            }
        }

        var parameters: [String: Any]?
        if let body = requestBody {
            do {
                let data = try JSONEncoder().encode(body)
                parameters = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                completion(.failure(NetworkError.decodingError(error, "Encoding request body to JSON")))
                return
            }
        }

        logger.log(request: URLRequest(url: url))

        AF.request(url, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: httpHeaders).responseData { response in
            self.logger.log(response: response.response, data: response.data)

            switch response.result {
            case .success(let data):
                if let httpResponse = response.response, 200...299 ~= httpResponse.statusCode {
                    completion(.success(data))
                } else {
                    let statusCode = response.response?.statusCode ?? -1
                    completion(.failure(NetworkError.badResponse(statusCode: statusCode, data: data)))
                }
            case .failure(let error):
                completion(.failure(NetworkError.unknown(error)))
            }
        }
    }
}
