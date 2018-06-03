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

import UIKit

final class SectionCell: UITableViewCell {

    private let favoritesButton: UIButton

    private var itemId: String?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        favoritesButton = UIButton()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        favoritesButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        favoritesButton.setTitleColor(.black, for: .normal)
        favoritesButton.addTarget(self, action: #selector(didTapFavoritesButton), for: .touchUpInside)

        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(favoritesButton)
        NSLayoutConstraint.activate([
            favoritesButton.widthAnchor.constraint(equalToConstant: 24),
            favoritesButton.heightAnchor.constraint(equalToConstant: 24),
            favoritesButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14)
        ])
        setIsFavorite(false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setItem(_ item: Item) {
        itemId = item.identifier
        textLabel!.text = item.title
        if let subtitle = item.subtitle {
            detailTextLabel!.text = subtitle
        }
        updateFavoritesButtonState()
    }

    @objc
    private func didTapFavoritesButton() {
        // TODO: Update favorites state
    }

    private func updateFavoritesButtonState() {
        // TODO: get favorites state
    }

    private func setIsFavorite(_ isFavorite: Bool) {
        favoritesButton.setTitle(isFavorite ? "★" : "☆", for: .normal)
    }
}
