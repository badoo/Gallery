/*
 The MIT License (MIT)

 Copyright (c) 2018-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

final class SectionsViewController: UIViewController,
                                    UITableViewDelegate,
                                    UITableViewDataSource,
                                    UISearchResultsUpdating,
                                    SectionsDataProviderDelegate {


    // MARK: - Private properties

    private var tableView: UITableView!

    private let dataProvider: SectionsDataProvider

    // MARK: - Instantiation

    init(dataProvider: SectionsDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SectionCell.self, forCellReuseIdentifier: .cell)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.alignAllEdgesWithSuperview()

        if #available(iOS 11, *) {
            addSearch()
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = getItem(at: indexPath)
        item.presentWithPreferredStyle(from: self)
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cell, for: indexPath) as! SectionCell
        let item = getItem(at: indexPath)
        cell.setItem(item)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataProvider.title(forSection: section)
    }

    // MARK: - SectionsDataProviderDelegate

    func didReloadData() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }

    func didChangeRowsInside(section: Int) {
        guard isViewLoaded else { return }
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
    }

    func didInsertSection(at index: Int) {
        guard isViewLoaded else { return }
        tableView.insertSections(IndexSet(integer: index), with: .fade)
    }

    func didRemoveSection(at index: Int) {
        guard isViewLoaded else { return }
        tableView.deleteSections(IndexSet(integer: index), with: .fade)
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            dataProvider.filter(text: text)
        } else {
            dataProvider.cancelSearch()
        }
        tableView.reloadData()
    }

    // MARK: - Private methods

    func getItem(at indexPath: IndexPath) -> Item {
        return dataProvider.item(in: indexPath.section, at: indexPath.row)
    }

    @available(iOS 11, *)
    private func addSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
}

private extension String {
    static let cell = "cell"
}
