//
//  CollectionViewCell.swift
//  UpdateCellWithAnimation
//
//  Created by jiwon Yoon on 2023/03/06.
//

import UIKit
import SnapKit
import RxSwift

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
            $0.width.greaterThanOrEqualTo(130.0)
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
        }
        
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        likeView.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalTo(dislikeView.snp.leading).offset(-offset)
        }
        
        dislikeView.snp.makeConstraints {
            $0.centerY.equalTo(likeView)
            $0.leading.equalTo(likeView.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        
        let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLikeView))
        
        likeView.addGestureRecognizer(likeTapGesture)
        
        return view
    }()
    
    private var disposeBag = DisposeBag()
    
    private var viewModel: ViewModelType?
    
    func setupCell(company: CompanyModel, viewModel: ViewModelType, index: Int) {
        self.viewModel = viewModel
        companyValueLabel.text = company.name
        scoreValueLabel.text = "\(company.score) scores"
        dateLabel.text = company.modifiedDate
        likeView.setCountLabel(countString: "\(company.likeCount) Likes")
        dislikeView.setCountLabel(countString: "\(company.dislikeCount) Dislikes")
        likeView.tag = index
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    
    func updateLikeCount(count: Int) {
        likeView.setCountLabel(countString: "\(count) Likes")
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
    
    @objc
    func didTapLikeView() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            animations: {
                self.likeView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0.2,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5,
                    animations: {
                        self.likeView.transform = .identity
                    }, completion: { [weak self] _ in
                        guard let self = self,
                              let viewModel = self.viewModel
                        else { return }
                        viewModel.inputs.updateLikeCount(index: self.likeView.tag)
                    }
                )
            }
        )
    }
}
