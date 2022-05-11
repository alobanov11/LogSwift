//
//  Created by Антон Лобанов on 06.06.2021.
//

protocol ILogOutputStrategy: AnyObject {
	func log(
		_ logType: LogType,
		message: String,
		callPoint: String
	)
}
