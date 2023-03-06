//
//  CollectionViewCell.swift
//  UpdateCellWithAnimation
//
//  Created by jiwon Yoon on 2023/03/06.
//

import UIKit
import SnapKit

final class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private lazy var companyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "CompanyName"
        label.textColor = .label
        
        return label
    }()
    
    private lazy var companyValueLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.textColor = .label
        
        return label
    }()
    
    private lazy var scoreValueLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .red
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.03.06"
        label.textColor = .label
        
        return label
    }()
    
    private lazy var likeView = ImageLabelView(title: "Like", imageName: "hand.thumbsup.fill")
    
    private lazy var dislikeView = ImageLabelView(title: "Dislike", imageName: "hand.thumbsdown.fill")
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            companyTitleLabel,
            companyValueLabel,
            scoreTitleLabel,
            scoreValueLabel,
            dateLabel,
            likeView,
            dislikeView
        ]
            .forEach {
                view.addSubview($0)
            }
        let offset: CGFloat = 16.0
        companyTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.width.lessThanOrEqualTo(150.0)
        }
        
        companyTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        companyValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(companyTitleLabel)
            $0.leading.equalTo(companyTitleLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        scoreTitleLabel.snp.makeConstraints {
            $0.top.equalTo(companyTitleLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.width.equalTo(companyTitleLabel)
        }
        
        scoreTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        scoreValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(scoreTitleLabel)
            $0.leading.equalTo(scoreTitleLabel.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(scoreTitleLabel.snp.bottom).offset(offset)
            $0.leading.equalToSuperview().offset(offset)
            $0.bottom.equalToSuperview().offset(-offset)
            $0.width.equalTo(companyTitleLabel)
        }
        
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        likeView.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(offset)
            $0.width.equalTo(100.0)
        }
        
        dislikeView.snp.makeConstraints {
            $0.centerY.equalTo(likeView)
            $0.leading.equalTo(likeView.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.width.equalTo(100.0)
        }
        
        return view
    }()
    
    func setupCell() {
        setupViews()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return layoutAttributes
    }
}

private extension CollectionViewCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
