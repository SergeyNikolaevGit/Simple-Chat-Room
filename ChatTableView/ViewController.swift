//
//  ViewController.swift
//  ChatTableView
//
//  Created by Sergey Nikolaev on 31/08/2018.
//  Copyright © 2018 Sergey Nikolaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var yTableView: UITableView!
    @IBOutlet weak var yTextView: UITextField!
    @IBOutlet weak var idButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    var parsedMesages = Array<String>()
    
    var celHeight = CGFloat()
    
    let senderID = "sender:"
    let reciverID = "reciver:"
    var idIsChenging = true
    
    
    var cellHeight = CGFloat()
    let chatViewMargin:(CGFloat) = 5.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yTableView.dataSource = self
        yTableView.delegate = self
        
        yTableView.separatorColor = UIColor.clear
        
        parsedMesages = ["sender:It may be an informal conversation with a friend or an acquaintance (someone you know, but not very well). Or you may use a more formal dialogue with a colleague, a teacher, a stranger or a government employee.", "reciver:The most widespread (common) question is “How are you?” In fact, it is so common, that it becomes automatic for people to say, even when they hardly know the person! “How are you” is often even considered part of the greeting (i.e. “Hi, how are you?”). That is how necessary it has become!", "sender:When the person you are talking to is asking you a question, listen for the keywords and pay attention to the verb being used. This will help you construct your answer using proper grammar.", "reciver:You are getting good at conversing in English, but suddenly you realize that you are lost. Maybe the other person is speaking too fast. Maybe she has an unfamiliar accent. Maybe you didn’t hear the last thing she said.", "sender:Say you have got all the information you need from the person. It is time for you to go. Maybe you are running late and want to keep the conversation brief. No matter the reason, it is always nice to let the person know you cannot continue talking to them for much longer.", "reciver:If you are scared of making a mistake, it is understandable. But mistakes are going to happen; it is absolutely normal. Making mistakes is a big part of learning. This is how you get better."]
        
        
        if idIsChenging {
            idButton.setTitle("\(senderID)", for: .normal)
        } else {
            idButton.setTitle("\(reciverID)", for: .normal)
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if parsedMesages.count <= 0 {
            
            statusLabel.numberOfLines = 0
            statusLabel.text = "We dont have messages in this room!"
            
        } else {
            
            statusLabel.text = ""
        }
        
        return parsedMesages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as? ChatCell
        
        cell?.messageTextView.textColor = .white
        cell?.messageTextView.backgroundColor = .clear
        
        let messayeTextViewWidth:CGFloat = 250.0
        
        
        let message = parsedMesages[indexPath.row]
        var replacedMessage = String()
        
        if message.hasPrefix(senderID) {
            replacedMessage = message.replacingOccurrences(of: senderID, with: "", options: .literal, range: nil)
            cell?.messageTextView.text = replacedMessage
            cell?.messageTextView.frame = CGRect(x: 0,
                                                 y: (cell?.messageTextView.frame.origin.y)!,
                                                 width: messayeTextViewWidth,
                                                 height: (cell?.messageTextView.bounds.height)!)
            
            let newSize = cell?.messageTextView.sizeThatFits(CGSize(width: messayeTextViewWidth, height: CGFloat.greatestFiniteMagnitude))
            cell?.messageTextView.frame.size = CGSize(width: max(newSize!.width, messayeTextViewWidth), height: newSize!.height)
            
            cell?.chatBackView.backgroundColor = .purple
            
        } else if message.hasPrefix(reciverID) {
            replacedMessage = message.replacingOccurrences(of: reciverID, with: "", options: .literal, range: nil)
            cell?.messageTextView.text = replacedMessage
            cell?.messageTextView.frame = CGRect(x: (cell?.bounds.width)! - messayeTextViewWidth - chatViewMargin,
                                                 y: (cell?.messageTextView.frame.origin.y)!,
                                                 width: messayeTextViewWidth,
                                                 height: (cell?.messageTextView.bounds.height)!)
            
            let newSize = cell?.messageTextView.sizeThatFits(CGSize(width: messayeTextViewWidth, height: CGFloat.greatestFiniteMagnitude))
            cell?.messageTextView.frame.size = CGSize(width: max(newSize!.width, messayeTextViewWidth), height: newSize!.height)
            
            cell?.chatBackView.backgroundColor = .orange
            
        } else {
            
            
        }
        
        
        cell?.chatBackView.layer.cornerRadius = 10
        cell?.chatBackView.frame = CGRect(x: (cell?.messageTextView.frame.origin.x)!,
                                          y: (cell?.messageTextView.frame.origin.y)!,
                                          width: (cell?.messageTextView.bounds.width)! + chatViewMargin,
                                          height: (cell?.messageTextView.bounds.height)! + chatViewMargin)
        
        cell?.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: (cell?.messageTextView.bounds.height)!)
        
        celHeight = (cell?.messageTextView.bounds.height)! + chatViewMargin
        
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return celHeight + 30

    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        
        if yTextView.text != "" {
            
            if idIsChenging {
                let appendedString = "\(senderID)\(yTextView.text!)"
                parsedMesages.append(appendedString)
                yTableView.reloadData()
                
            } else {
                let appendedString = "\(reciverID)\(yTextView.text!)"
                parsedMesages.append(appendedString)
                yTableView.reloadData()
                
            }
            
            yTextView.text = ""
            
        }
        
        
    }
    
    @IBAction func changeID(_ sender: Any) {
        
        if idIsChenging {
            idButton.setTitle("\(reciverID)", for: .normal)
            idIsChenging = false
        } else {
            idButton.setTitle("\(senderID)", for: .normal)
            idIsChenging = true
        }
        
    }
    
    
    
}
