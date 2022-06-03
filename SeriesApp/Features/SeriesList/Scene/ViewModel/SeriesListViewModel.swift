import Foundation

protocol SeriesListViewModelProtocol {
    func fetchSeries()
    func fetchNewSerie()
    func filterContentForSearchText(_ searchText: String)
    var onUpdateSeries: (() -> Void)? { get set }
    var onLoading: ((_ isLoading: Bool) -> Void)? { get set }
    var onLoadingPagination: ((_ isLoading: Bool) -> Void)? { get set }
    var onError: ((_ message: String) -> Void)? { get set }
    var series: [SeriesViewModel] { get set }
    var filteredSeries: [SeriesViewModel] { get set }
    var isLoadingPagination: Bool { get set }
    var lastPageWasLoading: Bool { get set }
}

final class SeriesListViewModel: SeriesListViewModelProtocol {

    var series: [SeriesViewModel] = [] {
        didSet {
            onUpdateSeries?()
        }
    }

    var filteredSeries: [SeriesViewModel] = [] {
        didSet {
            onUpdateSeries?()
        }
    }

    var onUpdateSeries: (() -> Void)?
    var onLoading: ((_ isLoading: Bool) -> Void)?
    var onLoadingPagination: ((Bool) -> Void)?
    var onError: ((String) -> Void)?

    var isLoadingPagination: Bool = false
    var lastPageWasLoading: Bool = false

    let repository: SeriesListRepositoryProtocol

    private var currentPage = 1

    init(repository: SeriesListRepositoryProtocol) {
        self.repository = repository
    }

    func fetchSeries() {
        onLoading?(true)
        repository.fetchSeries { [weak self] result in
            switch result {
            case .success(let series):
                let models = series.map( { SeriesViewModel(id: $0.id, name: $0.name, summary: $0.summary, image: $0.image.medium, schedule: $0.schedule) })
                self?.series = models
            case .failure:
                self?.onError?("An error occurred while fetching the information")
            }
            self?.onLoading?(false)
        }
    }

    func fetchNewSerie() {
        isLoadingPagination = true
        onLoadingPagination?(true)
        repository.fetchSeriesListByPaging(currentPage: currentPage) { [weak self] result in
            switch result {
            case .success(let series):
                self?.currentPage += 1
                self?.series.append(SeriesViewModel(id: series.id, name: series.name, summary: series.summary, image: series.image.medium, schedule: series.schedule))
            case .failure:
                self?.lastPageWasLoading = true
                self?.onError?("An error occurred while fetching the information")
            }
            self?.isLoadingPagination = false
            self?.onLoadingPagination?(false)
        }
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredSeries = series.filter { (series: SeriesViewModel) -> Bool in
            return series.name.lowercased().contains(searchText.lowercased())
        }
    }
}


struct SeriesViewModel {
    let id: Int
    let name: String
    let summary: String
    let image: String
    let schedule: Schedule
    var descriptionTime: String {
        var desc = "Every "
        for (index, element) in schedule.days.enumerated() {
            if index == schedule.days.count - 1 {
                desc += "\(element) at \(schedule.time)"
            } else {
                desc += element + ","
            }
        }
        
        return desc
    }
}
