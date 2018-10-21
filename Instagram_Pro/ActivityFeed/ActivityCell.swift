import UIKit

class  ActivityCell: UICollectionViewCell {
    
    var post: Post?{
        didSet{
            guard let post = post else {return}
            usernameLabel.text = post.user.username + " posts a picture "
            
            profileImageView.loadImage(urlString: post.user.profileImageUrl)
            postImageView.loadImage(urlString: post.imageUrl)
            //timeLabel.text = post.creationDate.timeAgoDisplay()
            timeLabel.text = post.creationDate.timeAgoDisplay()
        }
    }
    
    let profileImageView : CustomImageView = {
        let iv = CustomImageView()
        //iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "time"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postImageView: CustomImageView={
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(postImageView)
        addSubview(timeLabel)
        usernameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        timeLabel.anchor(top: nil, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: -25, paddingRight: 0, width: 0, height: 0)
        
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80/2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
        postImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 80, height: 80)
        //postImageView.layer.cornerRadius = 80/2
        postImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(white:0, alpha:0.5)
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right:  rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
