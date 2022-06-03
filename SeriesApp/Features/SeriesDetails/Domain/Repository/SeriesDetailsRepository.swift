import Foundation
protocol SeriesDetailsRepositoryProtocol {
    func fetchDetails(id: Int, completion: @escaping (Result<Episodes, Error>) -> Void)
}

final class SeriesDetailsRepository: SeriesDetailsRepositoryProtocol {
    func fetchDetails(id: Int, completion: @escaping (Result<Episodes, Error>) -> Void) {
        ServiceLayer.request(router: .seriesDetails(id: id)) { (result: Result<Episodes, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
