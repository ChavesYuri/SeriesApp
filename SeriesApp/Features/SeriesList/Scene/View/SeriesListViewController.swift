import Foundation
import UIKit
final class SeriesListViewController: UIViewController, AlertDisplayer {

    private let seriesListView: SeriesListViewProtocol
    private var viewModel: SeriesListViewModelProtocol

    init(
        seriesListView: SeriesListViewProtocol,
        viewModel: SeriesListViewModelProtocol
    ) {
        self.seriesListView = seriesListView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        fetchSeriesList()
    }

    func fetchSeriesList() {
        viewModel.fetchSeries()
    }

    override func loadView() {
        super.loadView()
        view = seriesListView
    }

    func bind() {
        viewModel.onUpdateSeries = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.seriesListView.updateSeries()
            }
        }

        viewModel.onLoading = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.seriesListView.onLoading(isLoading: isLoading)
            }
        }

        viewModel.onLoadingPagination = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.seriesListView.onLoading(isLoading: isLoading)
            }
        }

        viewModel.onError = { [weak self] message in
            self?.displayAlert(message: message)
        }

        seriesListView.onDidTapSeries = { [weak self] seriesModel in
            self?.openSeriesDetails(seriesModel: seriesModel)
        }
    }

    func openSeriesDetails(seriesModel: SeriesViewModel) {
        let vc = SeriesDetailsFactory.make(model: seriesModel)
        present(vc, animated: true)
    }
}
