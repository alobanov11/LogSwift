//
//  Created by Антон Лобанов on 29.09.2021.
//

import Foundation

@resultBuilder public enum MessageBuilder<Element> {
	public typealias Expression = Element
	public typealias Component = [Element]

	public static func buildBlock(_ children: Component...) -> Component { children.flatMap { $0 } }
	public static func buildBlock(_ component: Component) -> Component { component }

	public static func buildExpression(_ expression: Expression) -> Component { [expression] }
	public static func buildExpression(_ expression: Expression?) -> Component { expression.map { [$0] } ?? [] }

	public static func buildEither(first component: Component) -> Component { component }
	public static func buildEither(second component: Component) -> Component { component }

	public static func buildEither(first expression: Expression) -> Component { [expression] }
	public static func buildEither(second expression: Expression) -> Component { [expression] }

	public static func buildOptional(_ component: Component?) -> Component { component ?? [] }
}

// swiftlint:disable identifier_name
public func Log(
	_ logType: LogType = .verbose,
	_ file: StaticString = #file,
	_ function: StaticString = #function,
	_ line: UInt = #line,
	@MessageBuilder<Any?> messages: () -> [Any?]
) {
	let message = messages().map { "\($0 ?? "###")" }.joined(separator: "\n")
	switch logType {
	case .verbose:
		Logger.verbose(message, file, function, line)
	case .info:
		Logger.info(message, file, function, line)
	case .debug:
		Logger.debug(message, file, function, line)
	case .warning:
		Logger.warning(message, file, function, line)
	case .error:
		Logger.error(message, file, function, line)
	}
}
