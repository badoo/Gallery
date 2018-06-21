/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

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

protocol SectionsDataProviderDelegate: class {
    func didChangeRowsInside(section: Int)
    func didInsertSection(at index: Int)
    func didRemoveSection(at index: Int)
    func didReloadData()
}

final class SectionsDataProvider {

    private let sections: [SearchSection]
    private var nonEmptySections: [SearchSection] {
        return sections.filter { !$0.items.isEmpty }
    }

    weak var delegate: SectionsDataProviderDelegate?

    init(sections: [Section]) {
        self.sections = sections.map(SearchSection.init)

        for section in self.sections {
            section.setSectionChange { [weak self] _, _ in
                self?.delegate?.didReloadData()
            }
        }
    }

    var numberOfSections: Int {
        return nonEmptySections.count
    }

    func numberOfItems(in section: Int) -> Int {
        return nonEmptySections[section].items.count
    }

    func title(forSection section: Int) -> String? {
        return nonEmptySections[section].title
    }

    func item(in section: Int, at index: Int) -> Item {
        return nonEmptySections[section].items[index]
    }

    func filter(text: String) {
        for section in sections {
            section.filter(text: text)
        }
    }

    func cancelSearch() {
        for section in sections {
            section.cancelSearch()
        }
    }
}

private final class SearchSection: Section {

    private let section: Section
    private var filteredItems: [Item] = []

    // MARK: - Instantiation

    init(section: Section) {
        self.section = section
        updateFilteredItems()
    }

    // MARK: - SearchSection

    private var searchText: String?

    func filter(text: String) {
        searchText = text
        updateFilteredItems()
    }

    func cancelSearch() {
        searchText = nil
        updateFilteredItems()
    }

    // MARK: - Section

    var title: String {
        return section.title
    }

    var items: [Item] {
        return filteredItems
    }

    func setSectionChange(handler: @escaping Section.ChangeHandler) {
        section.setSectionChange { [weak self] oldCount, newCount in
            self?.updateFilteredItems()
            handler(oldCount, newCount)
        }
    }

    // MARK: - Private methods

    private func updateFilteredItems() {
        guard let text = searchText else {
            filteredItems = section.items
            return
        }
        filteredItems = section.items.filter { item in
            if item.title.localizedStandardContains(text) {
                return true
            }

            if let subtitle = item.subtitle, subtitle.localizedStandardContains(text) {
                return true
            }
            return false
        }
    }
}
