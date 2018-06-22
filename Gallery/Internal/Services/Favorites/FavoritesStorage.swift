//
// The MIT License (MIT)
//
// Copyright (c) 2018-present Badoo Trading Limited.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

protocol FavoritesStorageProtocol {
    func save(favorites: [ItemIdentifier])
    func load() -> [ItemIdentifier]?
}

struct FavoritesStorage: FavoritesStorageProtocol {

    private let userDefaults: UserDefaults

    private static let key = "gallery.favorited-items"

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func save(favorites: [ItemIdentifier]) {
        let encoder = PropertyListEncoder()
        guard let data = try? encoder.encode(favorites) else { return }
        userDefaults.set(data, forKey: FavoritesStorage.key)
    }

    func load() -> [ItemIdentifier]? {
        guard let data = userDefaults.data(forKey: FavoritesStorage.key) else { return nil }
        let decoder = PropertyListDecoder()
        guard let ids = try? decoder.decode([ItemIdentifier].self, from: data) else { return nil }
        return ids
    }
}
