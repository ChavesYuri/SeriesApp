import UIKit
import Foundation

protocol SeriesListViewProtocol: UIView {
    func updateSeries()
    func onLoading(isLoading: Bool)
    func onLoadingPagination(isLoading: Bool)
    var onDidTapSeries: ((_ series: SeriesViewModel) -> Void)? { get set }
}

final class SeriesListView: UIView, SeriesListViewProtocol {

    var onDidTapSeries: ((_ series: SeriesViewModel) -> Void)?
    
    let viewModel: SeriesListViewModelProtocol
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        return search
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let progressIndicator : UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .medium)
        progress.startAnimating()
        return progress
    }()
    
    init(viewModel: SeriesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addViewCodeSubviews(tableView, progressIndicator)
        
        tableView
            .topAnchor(equalTo: safeAreaLayoutGuide.topAnchor)
            .leadingAnchor(equalTo: leadingAnchor)
            .trailingAnchor(equalTo: trailingAnchor)
            .bottomAnchor(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        progressIndicator
            .centerXAnchor(equalTo: centerXAnchor)
            .centerYAnchor(equalTo: centerYAnchor)

        tableView.register(SeriesCell.self)
        tableView.register(LoadingCell.self)
    }
    
    func updateSeries() {
        self.tableView.reloadData()
    }
    
    func onLoading(isLoading: Bool) {
        progressIndicator.isHidden = !isLoading
    }

    func onLoadingPagination(isLoading: Bool) {
        tableView.reloadData()
    }
}

extension SeriesListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        viewModel.filterContentForSearchText(text)
    }
}

extension SeriesListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        isFiltering ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return viewModel.isLoadingPagination ? 1 : 0
        } else {
            return isFiltering ? viewModel.filteredSeries.count : viewModel.series.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier, for: indexPath)
            return cell
        } else {
            let cell: SeriesCell = tableView.dequeueReusableCell(indexPath: indexPath)
            let model = isFiltering ? viewModel.filteredSeries[indexPath.row] : viewModel.series[indexPath.row]
            cell.configure(viewModel: model)

            return cell
        }
        
    }
}

extension SeriesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isFiltering ? onDidTapSeries?(viewModel.filteredSeries[indexPath.row]) : onDidTapSeries?(viewModel.series[indexPath.row])
    }
}

extension SeriesListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height) && !viewModel.isLoadingPagination && !viewModel.lastPageWasLoading {
            viewModel.fetchNewSerie()
        }
    }
}
