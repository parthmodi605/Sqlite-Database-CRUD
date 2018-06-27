//
//  ViewController.swift
//  Practice Data Base
//
//  Created by TOPS on 29/12/17.
//  Copyright © 2017 TOPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var txtID: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
   
    var dt=Array<Any>()
    @IBOutlet weak var tbldata: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       datafeatch()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func datafeatch()
    {
        let selectdata="select * from student"
        
        let dml=Database()
        dt=dml.data(query: selectdata)
        
        if dt.count==0
        {
            print("Record not found...")
        }
        else
        {
            print(dt)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dt.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let dc=dt[indexPath.row] as! NSDictionary
        let cell=UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text=dc["name"] as? String
        cell.detailTextLabel?.text=dc["email"] as? String
        return cell
    }
    
    @IBAction func ButtonSave(_ sender: UIButton)
    {
        let strinsert="insert into student values(\(txtID.text!),'\(txtName.text!)','\(txtEmail.text!)')"
        print(strinsert)
        
        
        let dml=Database()
        let result=dml.databaseservices(query: strinsert)
        
        if result==true
        {
            print("Record inserted successfully!")
            datafeatch()
            tbldata.reloadData()
        }
        else
        {
            print("Error")
        }

    }
    
    
    @IBAction func ButtonUpdate(_ sender: UIButton)
    {
        let strupd="update student set name='\(txtName.text!)', email='\(txtEmail.text!)' where id=\(txtID.text!)"
        print(strupd)
        
        let dml=Database()
        let result=dml.databaseservices(query: strupd)
        datafeatch()
        tbldata.reloadData()

        
        if result==true
        {
            print("Record updated successfully!")
        }
        else
        {
            print("Error")
        }

        
    }
    
    
    
    @IBAction func ButtonDelete(_ sender: UIButton)
    {
        
        let strdel="delete from student where id=\(txtID.text!)"
        print(strdel)
        
        let dml=Database()
        let result=dml.databaseservices(query: strdel)
        datafeatch()
        tbldata.reloadData()

        if result==true
        {
            print("Record deleted successfully!")
        }
        else
        {
            print("Error")
        }

    }
    
   
    
    @IBAction func ButtonShow(_ sender: UIButton)
    {
        tbldata.reloadData()
    
    }
    
    
    
    
    
    
    
    
    
    
    
    

}

