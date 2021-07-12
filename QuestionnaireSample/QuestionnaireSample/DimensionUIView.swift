//
//  DimensionUIView.swift
//  QuestionnaireSample
//
//  Created by Lokesh Sahni on 27/06/21.
//

import SwiftUI

struct DimensionUIView: View {
    
    
    @State var dimensions: [MainDimension] = [
        MainDimension(dimensionname: "Satisfaction with lifestyle", dimensionid: "SL"),
        MainDimension(dimensionname: "Mental Health", dimensionid: "MH"),
        MainDimension(dimensionname: "Coping with pressure", dimensionid: "CP"),
        MainDimension(dimensionname: "Wellness behaviours", dimensionid: "WB"),
        MainDimension(dimensionname: "Activity and Sleep", dimensionid: "AS"),
        MainDimension(dimensionname: "Pace of Life", dimensionid: "PL"),
    ]
    
    @State var selecteddimension: String = "Mental Health"
    @State var selecteddimensionid: String = "MH"
    
    var body: some View {
        
        VStack {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack{
            
                ForEach(self.dimensions, id: \.self) { dim in

                    
                    Button(action: {
                       selecteddimension = dim.dimensionname
                       selecteddimensionid = dim.dimensionid
                    })
                    {
                        
                        if selecteddimensionid == dim.dimensionid  {
                            
                            Text("\(dim.dimensionid)")
                                .font(.body)
                                .bold()
                                .foregroundColor(Color.white)
                                    .padding()
                                .background(Circle()
                                .fill(Color.orange)
                                .frame(width: 80, height: 50)
                                                .shadow(color: Color.green,radius: 20))
                            
                        } else {
                            
                            Text("\(dim.dimensionid)")
                                .font(.body)
                                .bold()
                                .foregroundColor(Color.white)
                                .padding()
                                .background(Circle()
                                                .fill(Color.gray)
                                                .frame(width: 80, height: 50)
                                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/))
                        }
                    }
                    
                }
                
            }
            
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)

        
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(selecteddimension)
                        .font(.title)
                        .bold()
                    Text("")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
        
    }
    
}

struct DimensionUIView_Previews: PreviewProvider {
    static var previews: some View {
        DimensionUIView()
    }
}


struct MainDimension: Hashable, CustomStringConvertible {
        
    let dimensionname: String
    let dimensionid: String

    var description: String {
        return "\(dimensionname), id: \(dimensionid)"
    }
}


struct Question: Hashable, CustomStringConvertible {
    var id: Int
    
    let question: String
    let options: [String]
    let selectedanswer: String
    
    var description: String {
        return "\(question), id: \(id)"
    }
}
