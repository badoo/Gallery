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
    func didReloadData()
}

final class SectionsDataProvider {

    private let sections: [Section]

    weak var delegate: SectionsDataProviderDelegate?

    init(sections: [Section]) {
        self.sections = sections

        for (index, section) in sections.enumerated() {
            section.setSectionChange { [weak self] in
                self?.delegate?.didChangeRowsInside(section: index)
            }
        }
    }

    var numberOfSections: Int {
        return sections.count
    }

    func numberOfItems(in section: Int) -> Int {
        return sections[section].items.count
    }

    func title(forSection section: Int) -> String? {
        return sections[section].title
    }

    func item(in section: Int, at index: Int) -> Item {
        return sections[section].items[index]
    }

}
