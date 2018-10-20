import UIKit

class  ActivityCell: UICollectionViewCell {
    
    var follow: Follow?{
        didSet{
            guard let follow = follow else {return}
            usernameLabel.text = follow.user.username + " has followed you "
            profileImageView.loadImage(urlString: follow.user.profileImageUrl)
        }
    }
    
    let profileImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        backgroundColor = .yellow
        addSubview(profileImageView)
        addSubview(usernameLabel)
        usernameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        profileImageView.layer.cornerRadius = 50/2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(white:0, alpha:0.5)
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right:  rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
