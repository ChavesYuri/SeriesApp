//
//  SeriesDetailView.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 02/06/22.
//

import Foundation
import UIKit
import Foundation

protocol SeriesDetailViewProtocol: UIView {
    func updateSeasons()
    func onLoading(isLoading: Bool)
}

final class SeriesDetailsView: UIView, SeriesDetailViewProtocol {

    let viewModel: SeriesDetailsViewModelProtocol

    lazy var header: SeriesDetailsHeader = {
        let header = SeriesDetailsHeader()
        header.configure(with: viewModel.model)
        return header
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 180)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private let progressIndicator : UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .medium)
        progress.startAnimating()
        return progress
    }()

    init(viewModel: SeriesDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
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

        tableView.register(SeasonTableViewCell.self)
    }

    func updateSeasons() {
        tableView.reloadData()
    }

    func onLoading(isLoading: Bool) {
        progressIndicator.isHidden = !isLoading
    }
}

extension SeriesDetailsView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.seasons.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SeasonTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.setup(viewModel.seasons[indexPath.section])
        return cell
    }
}

extension SeriesDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(viewModel.seasons[section].season)"
    }
}
