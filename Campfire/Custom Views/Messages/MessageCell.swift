//
//  MessageCell.swift
//  Campfire
//
//  Created by Layne Johnson on 7/31/21.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var bubbleLabel: UILabel!
    @IBOutlet weak var receiverAvatar: UIImageView!
    @IBOutlet weak var senderAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        messageBubble.layer.cornerRadius = frame.size.height / 6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state.
    }
}
