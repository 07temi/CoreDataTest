//
//  MainScreen.swift
//  CoreDataTest
//
//  Created by Артем Черненко on 01.06.2022.
//

import SwiftUI

struct MainScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \NameList.namePet, ascending: true)], animation: .default)
    private var pets: FetchedResults<NameList>
    
    var body: some View {
        NavigationView{
            VStack {
                List(pets){ pet in
                    //Text(pet.namePet ?? "EmptyName")
                    NavigationLink("\(pet.namePet ?? "")", destination: NotesListScreen(selectedPet: pet))
                }
                Button("add", action: addNewPetName)
            }
        }
    }
    
    private func addNewPetName() {
        let newPet = NameList(context: viewContext)
        newPet.nameListID = UUID()
        newPet.namePet = "Test"
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Fatal error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
