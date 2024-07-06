//
//  CreateTableViewCell.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import SnapKit

final class CreateTableViewCell: BaseTableViewCell {
    let cellBackgroundView = WhiteBackgroundView()

    let cellTitleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    let descriptionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()

    let cellImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .lightGray
        return imageView
    }()

    let photoImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override func configureHierarchy() {
        contentView.addSubview(cellBackgroundView)
        contentView.addSubview(cellTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cellImageView)
        contentView.addSubview(photoImageView)
    }

    override func configureLayout() {
        cellBackgroundView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview()
        }

        cellTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }

        cellImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.height.equalToSuperview().dividedBy(4)
            make.width.equalTo(cellImageView.snp.height).dividedBy(2)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(cellImageView.snp.leading)
        }

        photoImageView.snp.makeConstraints { make in
            make.trailing.equalTo(cellImageView.snp.leading)
            make.verticalEdges.equalToSuperview().inset(6)
            make.width.equalTo(photoImageView.snp.height)
        }
    }

    override func configureView() {
        contentView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }

    func setDate(text: String, photo: UIImage?) {
        if let photo = photo {
            descriptionLabel.isHidden = true
            photoImageView.isHidden = false
            photoImageView.image = photo
        } else {
            descriptionLabel.isHidden = false
            photoImageView.isHidden = true
            descriptionLabel.text = text
        }
    }
}
