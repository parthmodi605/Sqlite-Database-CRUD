//
//  Database.swift
//  PracticeDataBase
//
//  Created by TOPS on 29/12/17.
//  Copyright © 2017 TOPS. All rights reserved.
//

import UIKit

class Database: NSObject {
    
    var strpath=""
    func databaseservices(query:String) -> Bool
    {
        var status=false
        let path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        strpath=path.appending("/contact.db")
        
        var stmt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmt, query, -1, &stmt, nil) == SQLITE_OK
            {
                sqlite3_step(stmt)
                status=true
            }
            sqlite3_finalize(stmt)
            sqlite3_close(stmt)
        }
        return status
    }
    
    
    func data(query:String) -> Array<Any>
    {
        var data=Array<Any>()
        var dict=Dictionary<String,Any>()
        let path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        strpath=path.appending("/contact.db")
        
        var stmt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmt, query, -1, &stmt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmt) == SQLITE_ROW
                {
                    let stid=String(cString: sqlite3_column_text(stmt, 0))
                    let stnm=String(cString: sqlite3_column_text(stmt, 1))
                    let stct=String(cString: sqlite3_column_text(stmt, 2))
                    
                    dict["id"]=stid
                    dict["name"]=stnm
                    dict["email"]=stct
                    data.append(dict)
                }
                sqlite3_finalize(stmt)
                sqlite3_close(stmt)
            }
        }
        return data
    }
    




}
