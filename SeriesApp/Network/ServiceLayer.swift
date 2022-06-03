//
//  ServiceLayer.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 31/05/22.
//

import Foundation
class ServiceLayer {

    class func request<T: Codable>(router: NetworkRouter, completion: @escaping (Result<T, Error>) -> ()) {

        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters

        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in

            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else { return }

            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
