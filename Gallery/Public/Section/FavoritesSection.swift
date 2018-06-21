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

public final class FavoritesSection: Section {

    // MARK: - Private properties

    private let service: Lazy<FavoritesProviding>
    private var sectionChangeHandler: ChangeHandler = { _, _ in }
    private var favoritesObserver: ObserverProtocol?

    // MARK: - Instantiation

    init(serviceProvider: @escaping () -> FavoritesProviding) {
        self.service = Lazy(serviceProvider)
    }

    // MARK: - Section

    public var title: String = "Favorites"

    public var items: [Item] = [] {
        didSet {
            sectionChangeHandler(oldValue.count, items.count)
        }
    }

    public func setSectionChange(handler: @escaping ChangeHandler) {
        sectionChangeHandler = handler
        observeFavoritsChange()
    }

    // MARK: - Private methods

    private func observeFavoritsChange() {
        self.items = service.value.allFavoritesItems.value
        favoritesObserver = service.value.allFavoritesItems.observe { [weak self] items in
            self?.items = items
        }
    }
}

extension FavoritesSection {
    public convenience init() {
        self.init { Globals.shared.favoritesProvider }
    }
}

private final class Lazy<T> {
    private var closure: (() -> T)?
    init(_ closure: @escaping () -> T) {
        self.closure = closure
    }
    private(set) lazy var value: T = {
        let value = closure!()
        closure = nil
        return value
    }()
}
