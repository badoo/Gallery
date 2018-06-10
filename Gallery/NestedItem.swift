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

struct NestedItem: Item {

    private let item: Item

    // MARK: - Instantiation

    init(item: Item, parentTitle: String) {
        self.identifier = ItemIdentifier(id: item.identifier, parentTitle: parentTitle)
        self.item = item
    }

    // MARK: - Item

    let identifier: ItemIdentifier

    var title: String {
        return item.title
    }

    var subtitle: String? {
        return item.subtitle
    }

    var subitems: [Item] {
        return item.subitems
    }

    var preferredPresentationStyle: ItemPreferredPresentationStyle {
        return item.preferredPresentationStyle
    }

    func viewController() -> UIViewController {
        return item.viewController()
    }
}
