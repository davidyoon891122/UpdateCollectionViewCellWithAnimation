//
//  ImageLabelView.swift
//  UpdateCellWithAnimation
//
//  Created by jiwon Yoon on 2023/03/06.
//

import UIKit
import SnapKit

final class ImageLabelView: UIView {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gray
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            iconImageView,
            titleLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 8.0
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
            $0.width.height.equalTo(20.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        return view
    }()
    
    init(title: String, imageName: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: imageName)
        setupViews()
    }
    
    convenience init(title: String) {
        self.init(title: title, imageName: "person")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCountLabel(countString: String) {
        titleLabel.text = countString
    }
}

private extension ImageLabelView {
    func setupViews() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
