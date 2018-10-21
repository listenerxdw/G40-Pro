//
//  ActivityFeed.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/17.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//
import UIKit
import Firebase


class ActivityFeed: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var posts = [Post]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(ActivityCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        fetchActivity()
    }
    
    func setupNavigationItems() {
        navigationItem.title = "Notification"
    }

    
    private func fetchActivity(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("posts")
        let ref2 = Database.database().reference().child("following").child(uid)
        ref2.observe(.childAdded) { (snapshot2) in
            guard let id = snapshot2.key as? String else {return}
            
            ref.observe(.childAdded, with: { (snapshot) in
                if(snapshot.key == id)
                    {
                        Database.fetchUserWithUID(uid: id, completion: { (user) in
                        //print(user.username)
                        guard let dictionary = snapshot.value as? [String:Any ] else {return}
                        guard let newPost = dictionary.values.first! as? [String: Any] else {return}
                            let constructDict = ["imageUrl":newPost["imageUrl"],"caption":newPost["caption"],"creationDate":newPost["creationDate"]]
                        var post = Post(user: user, dictionary: constructDict)
                        self.posts.append(post)
                        self.collectionView?.reloadData()
                        })

                }
            })
        }
        
        
    
    }

    //posts count
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    //setup cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ActivityCell
        cell.backgroundColor = .white
        cell.post = posts[indexPath.item]
        
        return cell
    }
    
    //set size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height:  100)
    }

}
