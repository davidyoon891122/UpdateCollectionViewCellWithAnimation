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
    
    private lazy var titleLabel: CountPushLabel = {
        let label = CountPushLabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            iconImageView,
            titleLabel,
            unitLabel
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
        }
        
        unitLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(offset / 2)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        return view
    }()
    
    init(title: String, imageName: String, unit: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        unitLabel.text = unit
        iconImageView.image = UIImage(systemName: imageName)
        setupViews()
    }
    
    convenience init(title: String, unit: String) {
        self.init(title: title, imageName: "person", unit: unit)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCountLabel(count: Int) {
        titleLabel.config(num: count)
        titleLabel.animate()
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
