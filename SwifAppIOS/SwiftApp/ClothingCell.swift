import UIKit

final class ClothingCell: UITableViewCell {

    static let id = "ClothingCell"

    private let itemImageView = UIImageView()
    private let titleLabel = UILabel()
    private let selectionView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .black
        selectionStyle = .none

        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 27
        itemImageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        selectionView.layer.cornerRadius = 13
        selectionView.layer.borderWidth = 2
        selectionView.layer.borderColor = UIColor.gray.withAlphaComponent(0.7).cgColor
        selectionView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 54),
            itemImageView.heightAnchor.constraint(equalToConstant: 54),

            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            selectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            selectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectionView.widthAnchor.constraint(equalToConstant: 26),
            selectionView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    func configure(with item: ClothingRowModel) {
        itemImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        selectionView.backgroundColor = item.isSelected ? .white : .clear
    }
}
