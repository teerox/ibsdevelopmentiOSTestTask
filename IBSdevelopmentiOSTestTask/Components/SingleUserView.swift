//
//  SingleUserView.swift
//  IBSdevelopmentiOSTestTask
//
//  Created by Mac on 02/10/2022.
//

import SwiftUI

struct SingleUserView: View {
    var result: ResultModel? = nil
    var body: some View {
        VStack {
            HStack(alignment:.top) {
                AsyncImage(url: URL(string: result?.picture?.medium ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .frame(width: 128, height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                VStack(alignment:.leading,spacing: 5) {
                    Text("\(result?.name?.first ?? "") \(result?.name?.last ?? "")")
                        .font(.title)
                        .bold()
                    Text("\(result?.email ?? "")")
                        .font(.body)
                    Text("\(result?.location?.street?.number ?? 0) \(result?.location?.street?.name ?? "") \(result?.location?.city ?? "") \(result?.location?.state ?? "") \(result?.location?.country ?? "")")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Divider()
        }
        .padding()
    }
}

struct SingleUserView_Previews: PreviewProvider {
    static var previews: some View {
        SingleUserView()
            .previewLayout(.sizeThatFits)
        SingleUserView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
