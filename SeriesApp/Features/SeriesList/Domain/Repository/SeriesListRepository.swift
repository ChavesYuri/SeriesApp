import Foundation
protocol SeriesListRepositoryProtocol {
    func fetchSeries(completion: @escaping (Result<Series, Error>) -> Void)
    func fetchSeriesListByPaging(currentPage: Int, completion: @escaping (Result<SeriesElement, Error>) -> Void)
}

final class SeriesListRepository: SeriesListRepositoryProtocol {
    func fetchSeries(completion: @escaping (Result<Series, Error>) -> Void) {
        ServiceLayer.request(router: .seriesList) { (result: Result<Series, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchSeriesListByPaging(currentPage: Int, completion: @escaping ((Result<SeriesElement, Error>) -> Void)) {
        ServiceLayer.request(router: .seriesListPagination(page: currentPage)) { (result: Result<SeriesElement, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
