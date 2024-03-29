//
//  ThumbnailView.swift
//  Drive+
//
//  Created by Nathan Donagi (student LM) on 4/19/23.
//

import SwiftUI

struct ThumbnailView: View {
    @Binding var file_metadata: FileMetadata
    @StateObject var file: File = File(name: "Loading")
    @State var name: String = "Loading"

    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                TextField("Name", text: $name)
                    .onSubmit {
                        Task {
                            print("hi")
                            await file.rename(name: name)
                        }
                    }
                    .font(.custom("HelveticaNeue-Thin", size: 25))
                    .padding(10)
                
                Text(file.last_modified)
                    .font(.custom("HelveticaNeue-Thin", size: 14))
                    .padding([.leading, .bottom], 10)
            }
            
            Spacer()
            
            if file.mime_type == "application/vnd.google-apps.document"{
                Text(String() + " Doc")
                    .font(.custom("HelveticaNeue-Thin", size: 14))
                    .padding()
            } else if file.mime_type == "application/vnd.google-apps.spreadsheet"{
                Text(String() + " Sheet")
                    .font(.custom("HelveticaNeue-Thin", size: 14))
                    .padding()
            } else if file.mime_type == "application/vnd.google-apps.folder"{
                Text(String() + " Folder")
                    .font(.custom("HelveticaNeue-Thin", size: 14))
                    .padding()
            } else {
                Text(String() + " File")
                    .font(.custom("HelveticaNeue-Thin", size: 14))
                    .padding()
            }
            
            
        }.task {
            await file.getData(metadata: file_metadata)
            name = file.name
        }
    }
}

//struct ThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailView(file: File(name: "hello"))
//    }
//}
