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

final class SectionCell: UITableViewCell {

    private let titleLabel: UILabel
    private let subtitleLabel: UILabel
    private let favoritesButton: UIButton
    private let favoritesService = Globals.shared.favoritesService

    private var itemId: ItemIdentifier?
    private var favoritesObserver: ObserverProtocol?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        titleLabel = .makeTitleLabel()
        subtitleLabel = .makeSubtitleLabel()
        favoritesButton = UIButton()
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        favoritesButton.addTarget(self, action: #selector(didTapFavoritesButton), for: .touchUpInside)
        setupLayout()
        setIsFavorite(false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setItem(_ item: Item) {
        itemId = item.identifier
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        let observable = favoritesService.observeIsFavorite(id: itemId!)
        setIsFavorite(observable.value)
        favoritesObserver = observable.observe { [weak self] isFavorite in
            self?.setIsFavorite(isFavorite)
        }
    }

    private func setupLayout() {
        let labelContainerView = UIStackView.makeLabelContainer(arrangedSubviews: [titleLabel, subtitleLabel])
        labelContainerView.backgroundColor = .red
        for subview in [labelContainerView, favoritesButton] {
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }

        let constraints = [
            labelContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            labelContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            favoritesButton.leadingAnchor.constraint(greaterThanOrEqualTo: labelContainerView.trailingAnchor),
            favoritesButton.widthAnchor.constraint(equalToConstant: 40),
            favoritesButton.heightAnchor.constraint(equalTo: favoritesButton.widthAnchor),
            favoritesButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ]

        let contentViewConstraints = [
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.heightAnchor.constraint(equalTo: heightAnchor)
        ]

        for constraint in contentViewConstraints {
            constraint.priority = .defaultHigh
        }

        NSLayoutConstraint.activate(constraints + contentViewConstraints)
    }

    @objc
    private func didTapFavoritesButton() {
        guard let id = itemId else { return }
        favoritesService.toggleFavorites(id: id)
    }

    private func setIsFavorite(_ isFavorite: Bool) {
        let name = isFavorite ? "gallery.favorite.on" : "gallery.favorite.off"
        let bundle = Bundle(for: SectionCell.self)
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        favoritesButton.setImage(image, for: .normal)
    }
}

private extension UIStackView {
    static func makeLabelContainer(arrangedSubviews: [UIView]) -> UIStackView {
        let view = UIStackView(arrangedSubviews: arrangedSubviews)
        view.axis = .vertical
        view.alignment = .fill
        return view
    }
}

private extension UILabel {
    static func makeTitleLabel() -> UILabel {
        return UILabel()
    }

    static func makeSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }
}
