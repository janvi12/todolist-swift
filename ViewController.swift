//
//  ViewController.swift
//  todolist
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate
{
    @IBOutlet var tableView: UITableView!
    var activeTextView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "taskdetailcell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //add keyboard events
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillShow:"),
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillHide:"),
            name: UIKeyboardWillHideNotification,
            object: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableview Delegate and UITableview Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "Cell"
        var tableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier) as? taskdetailcell
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewCell?.txtViewTask.delegate = self
        
        tableViewCell?.btnCheckBox.tag = indexPath.row
        tableViewCell?.btnCheckBox.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        tableViewCell?.btnCheckBox.setImage(UIImage(named: "checkbox_inactive_btn.png"), forState: UIControlState.Normal)
        
        return tableViewCell!
    }
    
    //MARK: UITextViewDelegate
    func textViewDidChange(textView: UITextView)
    {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        activeTextView = nil
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        activeTextView = textView
    }
    
    //MARK: IBAction
    func buttonAction(sender:UIButton!)
    {
        if(sender.currentImage == UIImage(named: "checkbox_inactive_btn.png"))
        {
            sender.setImage(UIImage(named: "checkbox_active_btn.png"), forState: UIControlState.Normal)
        }
        else
        {
            sender.setImage(UIImage(named: "checkbox_inactive_btn.png"), forState: UIControlState.Normal)
        }
    }
    
    //MARK: Keyboard Methods
    func keyboardWillShow(note: NSNotification)
    {
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            var yPosition = UIScreen.mainScreen().bounds.height - keyboardSize.height
            var frame = tableView.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.1)
            frame.size.height -= keyboardSize.height
            tableView.frame = frame
            
            if activeTextView != nil
            {
                let rect = tableView.convertRect(activeTextView.bounds, fromView: activeTextView)
                tableView.scrollRectToVisible(rect, animated: false)
            }
            UIView.commitAnimations()
        }
    }
    
    func keyboardWillHide(note: NSNotification)
    {
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            var frame = tableView.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.3)
            frame.size.height += keyboardSize.height
            tableView.frame = frame
            UIView.commitAnimations()
        }
    }
}
