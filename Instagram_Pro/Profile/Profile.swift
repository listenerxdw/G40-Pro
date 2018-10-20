//
//  Profile.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/16.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import UIKit
import Firebase

class Profile: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
   //collectionView?.keyboardDismissMode = .onDrag
    var userId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView?.register(ProfilePostCell.self, forCellWithReuseIdentifier: cellId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        setupLogOutButton()
        
        fetchUser()
        
        fetchFollowersNumber()
        
        fetchFollowingsNumber()
        
    }
    
    //let refreshControl = UIRefreshControl()
    
    @objc func handleRefresh() {
        print("Handling refresh..")
        self.posts.removeAll()
        self.collectionView?.reloadData()
        self.refreshControl.endRefreshing()
        fetchUser()

    }
    let refreshControl = UIRefreshControl()
    var posts = [Post]()
    
    fileprivate func fetchOrderedPosts() {
        guard let uid = self.user?.uid else { return }
        let ref = Database.database().reference().child("posts").child(uid)
        self.collectionView?.refreshControl?.endRefreshing()
        //perhaps later on we'll implement some pagination of data
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
             guard let user = self.user else { return }
            
            let post = Post( user: user, dictionary: dictionary)
            
            self.posts.insert(post, at: 0)
            //            self.posts.append(post)
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch ordered posts:", err)
        }
    }
    
    
    var followers : Int = 0
    var followings : Int = 0
    //Need to be fixed.
    
    fileprivate func fetchFollowingsNumber()  {
        print("fetching followings number")
        
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
        print(uid)
        let ref = Database.database().reference().child("following").child(uid)

        ref.observe(.value, with: { (snapshot: DataSnapshot!) in
            print(snapshot.childrenCount)
            
            self.followings = Int(snapshot.childrenCount)
            //self.collectionView?.reloadData()
            
        })
    }
 
    fileprivate func fetchFollowersNumber()  {
        print("fetching followers numbers")
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
        print(uid)
        //self.collectionView?.refreshControl?.endRefreshing()
        let ref = Database.database().reference().child("follower").child(uid)
        ref.observe(.value, with: { (snapshot: DataSnapshot!) in
            print(snapshot.childrenCount)
            self.followers = Int(snapshot.childrenCount)
        })
        //self.collectionView?.refreshControl?.endRefreshing()
        }
    
    func setupLogOutButton() {
        
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
        
    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                let loginController = Login()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfilePostCell
        
        cell.post = posts[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! ProfileHeader
        
        header.user = self.user
        
        //set header data.
        //posts
        let postsCount = String (posts.count)
        let postsAttributedText = NSMutableAttributedString(string: postsCount+"\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        postsAttributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        
        header.postsLabel.attributedText = postsAttributedText
        
        //followers
        
        let followersCount = String (self.followers)
        let followersAttributedText = NSMutableAttributedString(string: followersCount+"\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        followersAttributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        header.followersLabel.attributedText = followersAttributedText
        
        //followings
        let followingsCount = String (self.followings)
        let followingsAttributedText = NSMutableAttributedString(string: followingsCount+"\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        followingsAttributedText.append(NSAttributedString(string: "followings", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        header.followingLabel.attributedText = followingsAttributedText
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    var user: User?
    fileprivate func fetchUser() {
        
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
        
        //guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.user = user
            self.navigationItem.title = self.user?.username
            
            self.collectionView?.reloadData()
            
            self.fetchOrderedPosts()
        }
    }
}
