
//  DashboardWidget.swift
//  DashboardWidget
//
//  Created by Randimal Geeganage on 2021-06-19.
//

import WidgetKit
import SwiftUI

struct Model : TimelineEntry {
    var date : Date
    var widgetData : [JSONModel]
}

struct JSONModel: Decodable,Hashable {
    
    var date : CGFloat
    var units : Int
}

struct Provider : TimelineProvider {
    
    
    func getSnapshot(in context: Context, completion: @escaping (Model) -> ()) {
        let loadingData = Model(date: Date(), widgetData: Array(repeating: JSONModel(date: 0, units: 0), count: 0))
        completion(loadingData)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Model>) -> ()) {
        getData{ (modelData) in
            
            let date = Date()
            let data = Model(date: date, widgetData: modelData)
            
            let nextUpdate = Calendar.current.date(byAdding: .minute, value:10  , to: date)
            let timeLine = Timeline(entries: [data], policy: .after(nextUpdate!))
            
            completion(timeLine)
        }
    }
    
    func placeholder(in context: Context) -> Model {
        return Model(date: Date(), widgetData: Array(repeating: JSONModel(date: 0, units: 0), count: 0))
    }
}

//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent
//}

struct WidgetViewView : View {
    
    var color1 = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    var color2 = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    var percent : CGFloat = 25
    
    @Binding var show : Bool
    var data : Model
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        
        //        let progress = 1 - (percent / 100)
        
        switch family {
        case .systemLarge:
            //            VStack {
            //                HStack{
            //                    Image("zs")
            //                        .resizable()
            //                        .frame(width: 32, height: 32, alignment: .center)
            //                    Text("Dashboard")
            //                        .foregroundColor(Color(#colorLiteral(red: 0.08706449717, green: 0.678093493, blue: 0, alpha: 1)))
            //                }
            
            VStack {
                GeometryReader{ g in
                    ZStack {
                        Path { path in
                            path.move(to: CGPoint(x: 187, y: 187))
                            path.addArc(center: .init(x: 187, y: 187), radius: g.size.height/3, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 190), clockwise: true)
                            
                        }
                        .fill(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                        
                        
                        Path { path in
                            path.move(to: CGPoint(x: 187, y: 187))
                            path.addArc(center: .init(x: 187, y: 187), radius: g.size.height/3, startAngle: Angle(degrees: 190), endAngle: Angle(degrees: 110), clockwise: true)
                        }
                        .fill(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                        
                        Path { path in
                            path.move(to: CGPoint(x: 187, y: 187))
                            path.addArc(center: .init(x: 187, y: 187), radius: g.size.height/3, startAngle: Angle(degrees: 110), endAngle: Angle(degrees: 90), clockwise: true)
                        }
                        .fill(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)))
                        
                        
                        Path { path in
                            path.move(to: CGPoint(x: 187, y: 187))
                            path.addArc(center: .init(x: 187, y: 187), radius: g.size.height/3, startAngle: Angle(degrees: 90.0), endAngle: Angle(degrees: 360), clockwise: true)
                        }
                        .fill(Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)))
                    }
                    //                    frame(width: g.size.width/3, height: g.size.height/3)
                }
                //                .overlay(Text("25%")
                //                            .foregroundColor(.white)
                //                            .offset(x: 90, y: 90))
                
                VStack {
                    HStack{
                        HStack {
                            Rectangle()
                                .frame(width: 10, height: 10, alignment: .center)
                                .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                            Text("Inbox")
                                .font(.system(size: 12))
                        }
                        HStack {
                            Rectangle()
                                .frame(width: 10, height: 10, alignment: .center)
                                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                            
                            Text("Inprocess")
                                .font(.system(size: 12))
                        }
                    }
                    HStack{
                        HStack {
                            Rectangle()
                                .frame(width: 10, height: 10, alignment: .center)
                                .foregroundColor(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)))
                            Text("Completed")
                                .font(.system(size: 12))
                        }
                        HStack {
                            Rectangle()
                                .frame(width: 10, height: 10, alignment: .center)
                                .foregroundColor(Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)))
                            Text("Rejected")
                                .font(.system(size: 12))
                        }
                    }
                }
                .offset(x:25)
                //                .frame(width: 200, height: 100,alignment: .bottom)
                //                .padding(.top,90)
                
            }
            .offset(x: -20, y: -30)
            
        default:
            VStack {
                if data.widgetData.isEmpty {
                    VStack {
                        Text("Dashboard")
                            .font(.system(size: 20))
                            .foregroundColor(.green)
                    }
                }else{
                    VStack{
                        //  MARK -: last updated time we can put here like this
                        HStack{
                            Text("Last updated : ")
                                .font(.caption2)
                                .foregroundColor(.green)
                            
                            Text(Date(),style:.time)
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                        .padding(4)
                        HStack{
                            
                            
                            VStack{
                                Image("inbox")
                                    .resizable()
                                    .frame(width: 32, height: 32, alignment: .center)
                                
                                
                                Text("\(data.widgetData[0].units)")
                                    .foregroundColor(Color(#colorLiteral(red: 0.08706449717, green: 0.678093493, blue: 0, alpha: 1)))
                                    .font(.system(size: 10).weight(.heavy))
                                
                            }
                            Spacer()
                                .frame(width:30)
                            VStack{
                                Image("inprocess")
                                    .resizable()
                                    .frame(width: 32, height: 32, alignment: .center)
                                
                                
                                Text("\(data.widgetData[1].units)")
                                    .foregroundColor(Color(#colorLiteral(red: 0.08706449717, green: 0.678093493, blue: 0, alpha: 1)))
                                    .font(.system(size: 10).weight(.heavy))
                            }
                        }
                        HStack{
                            VStack{
                                Image("completed")
                                    .resizable()
                                    .frame(width: 32, height: 32, alignment: .center)
                                
                                Text("\(data.widgetData[2].units)")
                                    .foregroundColor(Color(#colorLiteral(red: 0.08706449717, green: 0.678093493, blue: 0, alpha: 1)))
                                    .font(.system(size: 10).weight(.heavy))
                                
                            }
                            Spacer()
                                .frame(width:30)
                            VStack{
                                Image("rejected")
                                    .resizable()
                                    .frame(width: 32, height: 32, alignment: .center)
                                
                                Text("\(data.widgetData[3].units)")
                                    .foregroundColor(Color(#colorLiteral(red: 0.08706449717, green: 0.678093493, blue: 0, alpha: 1)))
                                    .font(.system(size: 10).weight(.heavy))
                            }
                        }
                    }
                    .padding(.all)
                }
            }
        }
        
    }
}

@main
struct DashboardWidget: Widget {
    let kind: String = "DashboardWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "DashboardWidget",provider: Provider()) { data in
            WidgetViewView (show: .constant(true), data: data)
        }
        .description(Text("Zorrosign Dashboard widget."))
        .configurationDisplayName("Dashboard Widget")
        //        .supportedFamilies([.systemMedium,.systemSmall])
    }
}


// MARK -: fetch data

func getData(completion: @escaping([JSONModel]) -> ()) {
    let url = "https://canvasjs.com/data/gallery/javascript/daily-sales-data.json"
    
    let session = URLSession(configuration: .default)
    
    session.dataTask(with: URL(string: url)!) { (data, _, err) in
        
        if err != nil{
            print((err!.localizedDescription))
            return
        }
        do{
            let jsonData = try JSONDecoder().decode([JSONModel].self, from: data!)
            completion(jsonData)
            
        }
        catch{
            print(error.localizedDescription)
        }
    }.resume()
}

