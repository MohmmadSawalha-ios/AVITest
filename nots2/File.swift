import UIKit
//global vars
var  allNotes :[Note] = []

let kallNotes :String = "notes"

var CurrentNoteIndex :Int = -1

var noteTable :UITableView?
//global vars : End

class Note
{
    
    //Variables
    var note :String?
    var date :String?
    //Variables : End
    
    //Init
     init(){
        date = Date().description
        
        note = ""
    }
    //init :End
    
    //methods
    func dictionary() -> Dictionary<String,Any>{
        return ["note":note! , "date":date!]
    }
    class func saveNotes(){
        var aDictionaries:[Dictionary<String, Any>] = []
        
        for i in  allNotes
        {
            aDictionaries.append(i.dictionary())
            
        }
        
        //
        UserDefaults.standard.set(aDictionaries, forKey:kallNotes)
        UserDefaults.standard.synchronize()
    }
    class func loadNotes()
    {
       
        let savedData = UserDefaults.standard.object(forKey: kallNotes)
        //optional Binding; HERE
        let savedDataDic = savedData as? [Dictionary<String , Any >]
        if let Data = savedDataDic
        {
            for i in Data
            {
                let note = Note()
                for (key , value) in i
                {
                  
                    let value = value as? String
                    if key == "date" {note.date = value}
                    else  {note.note = value}
                
                }
              allNotes.append(note)
            }
        }
    }
        //methods : End
        
    }

