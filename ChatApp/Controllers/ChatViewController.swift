//
//  WelcomeViewController.swift
//  ChatApp
//
//  Created by Mehmet  Demir on 10.04.2025.
//

// MARK: importSection
import UIKit
import FirebaseAuth
import FirebaseFirestore

// MARK: ChatViewController
class ChatViewController: UIViewController {
    
    // MARK: variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    //create the firestore
    let db = Firestore.firestore()
    var messages : [Message] = []
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "Chat Screen🏠"
        navigationItem.hidesBackButton = true
        // register the our messagecell for using our code
        tableView.register(UINib(nibName: C.cellNibName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection(C.FStore.collectionName)
            .order(by: C.FStore.dateField).addSnapshotListener { querySnapshot, error in
        
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[C.FStore.senderField] as? String ,let body = data[C.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: body)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async{
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1,section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true )
                            }
                        }
                    }
                }
            }
        }
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text , let messageSender = Auth.auth().currentUser?.email {
            db.collection(C.FStore.collectionName).addDocument(data: [
                C.FStore.senderField : messageSender  ,
                C.FStore.bodyField : messageBody     ,
                C.FStore.dateField : Date().timeIntervalSince1970
            ]) { error in
                if let e  = error {
                    print("there was an issue saving data to firestore, \(e)")
                }  else {
                    print("Succesfully saved data.")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                   
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: .random())
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}

// MARK: UITableViewDataSource
extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for :  indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        
        cell.label.text = message.body
        
        //this is a message from the current user.
        if  message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: C.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: C.BrandColors.purple)
        }
        //this is a message from another sender.
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: C.BrandColors.purple)
            cell.label.textColor = UIColor(named: C.BrandColors.lightPurple)
        }
        
        return cell
    }
    
    
}
