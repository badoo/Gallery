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

public struct ItemStore {
    private let rootSections: [Section]
    private var allItems: [ItemIdentifier: Item]

    public init(rootSections: [Section]) {
        self.rootSections = rootSections
        var dict: [ItemIdentifier: Item] = [:]
        let flatten = rootSections.flatMap { $0.items }.flattenItems()
        for item in flatten {
            let id = item.identifier
            assert(dict[id] == nil, "Found items with same identifiers")
            dict[id] = item
        }
        self.allItems = dict
    }
}

private extension Sequence where Element == Item {
    func flattenItems() -> [Item] {
        var result: [Item] = []
        for item in self {
            result.append(item)
            result += item.subitems.flattenItems()
        }
        return result
    }
}
