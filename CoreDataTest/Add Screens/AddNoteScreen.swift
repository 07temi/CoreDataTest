//
//  AddNoteScreen.swift
//  CoreDataTest
//
//  Created by Артем Черненко on 03.06.2022.
//

import SwiftUI

struct AddNoteScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var type = ""
    @State private var title = ""
    @State private var date = Date()
    
    private let types = ["Прививка", "Питание", "Наблюдение"]
    let selectedPet: NameList
    
    var body: some View {
        Form {
            Section {
                Picker("Тип заметки", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                TextField("title", text: $title)
                    .disableAutocorrection(true)
                //выбор даты
            }
        }
        .toolbar {
            Button("Сохранить", action: {saveNote()} )
        }
    }
    
    private func saveNote(){
        let newNote = NotesList(context: viewContext)
        newNote.notesID = UUID()
        newNote.notesType = type
        newNote.notesTitle = title
        newNote.notesDate = date
        newNote.notesToName = selectedPet
        viewContext.refreshAllObjects()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Fatal error \(nsError), \(nsError.userInfo)")
        }
        presentationMode.wrappedValue.dismiss()
    }
}

//struct AddNoteScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNoteScreen()
//    }
//}
