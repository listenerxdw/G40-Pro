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
    override func viewDidLoad(){
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        collectionView?.register(ActivityCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        
        
        fetchActivity()
    }
    

    var follows = [Follow]()
    
    private func fetchActivity(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("follower").child(uid)
            ref.observe(.childAdded, with: { (snapshot) in
                //print(snapshot)
                //guard let dictionary = [snapshot.key:snapshot.value] as? [String:Any] else{return}
                let keys = snapshot.key
                print(keys)
                
                Database.fetchUserWithUID(uid: keys, completion: { (user) in
                    var follow = Follow(user: user)
                    //follow = Follow(user: user)
                    self.follows.append(follow)
                    self.collectionView?.reloadData()
                })
                //print(snapshot)
//            dictionary.forEach({ (key, value) in
//                Database.fetchUserWithUID(uid: key, completion: { (user) in
//
//                })
//            })
            
            //self.collectionView?.reloadData()
        }) { (err) in
            print(err)
        }
        
    
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return follows.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ActivityCell
        cell.backgroundColor = .white
        cell.follow = follows[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height:  60)
    }

}
