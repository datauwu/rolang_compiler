struct Token {
	kind: string
	line: number
	col: number
	valueText: string? = null
	valueNumber: number? = null
	valueBoolean: boolean? = null
}

type TokenList = array<Token>

let KEYWORD_TYPES: dict<string, string> = {}
KEYWORD_TYPES["function"] = "FUNCTION"
KEYWORD_TYPES["return"] = "RETURN"
KEYWORD_TYPES["if"] = "IF"
KEYWORD_TYPES["else"] = "ELSE"
KEYWORD_TYPES["while"] = "WHILE"
KEYWORD_TYPES["switch"] = "SWITCH"
KEYWORD_TYPES["case"] = "CASE"
KEYWORD_TYPES["default"] = "DEFAULT"
KEYWORD_TYPES["fallthrough"] = "FALLTHROUGH"
KEYWORD_TYPES["true"] = "BOOLEAN"
KEYWORD_TYPES["false"] = "BOOLEAN"
KEYWORD_TYPES["null"] = "NULL"
KEYWORD_TYPES["in"] = "IN"
KEYWORD_TYPES["let"] = "LET"
KEYWORD_TYPES["for"] = "FOR"
KEYWORD_TYPES["of"] = "OF"
KEYWORD_TYPES["do"] = "DO"
KEYWORD_TYPES["break"] = "BREAK"
KEYWORD_TYPES["continue"] = "CONTINUE"
KEYWORD_TYPES["class"] = "CLASS"
KEYWORD_TYPES["new"] = "NEW"
KEYWORD_TYPES["extends"] = "EXTENDS"
KEYWORD_TYPES["with"] = "WITH"
KEYWORD_TYPES["delete"] = "DELETE"
KEYWORD_TYPES["this"] = "THIS"
KEYWORD_TYPES["super"] = "SUPER"
KEYWORD_TYPES["static"] = "STATIC"
KEYWORD_TYPES["public"] = "PUBLIC"
KEYWORD_TYPES["private"] = "PRIVATE"
KEYWORD_TYPES["protected"] = "PROTECTED"
KEYWORD_TYPES["enum"] = "ENUM"
KEYWORD_TYPES["implements"] = "IMPLEMENTS"
KEYWORD_TYPES["interface"] = "INTERFACE"
KEYWORD_TYPES["override"] = "OVERRIDE"
KEYWORD_TYPES["final"] = "FINAL"
KEYWORD_TYPES["abstract"] = "ABSTRACT"
KEYWORD_TYPES["const"] = "CONST"
KEYWORD_TYPES["get"] = "GET"
KEYWORD_TYPES["set"] = "SET"
KEYWORD_TYPES["each"] = "EACH"
KEYWORD_TYPES["is"] = "IS"
KEYWORD_TYPES["as"] = "AS"
KEYWORD_TYPES["meta"] = "META"
KEYWORD_TYPES["try"] = "TRY"
KEYWORD_TYPES["catch"] = "CATCH"
KEYWORD_TYPES["finally"] = "FINALLY"
KEYWORD_TYPES["throw"] = "THROW"
KEYWORD_TYPES["from"] = "FROM"
KEYWORD_TYPES["import"] = "IMPORT"
KEYWORD_TYPES["export"] = "EXPORT"
KEYWORD_TYPES["type"] = "TYPE"
KEYWORD_TYPES["struct"] = "STRUCT"
KEYWORD_TYPES["dangerous"] = "DANGEROUS"
KEYWORD_TYPES["goto"] = "GOTO"
KEYWORD_TYPES["label"] = "LABEL"
let ONE_CHAR_TYPES: dict<string, string> = {}
ONE_CHAR_TYPES["="] = "ASSIGN"
ONE_CHAR_TYPES["+"] = "OP"
ONE_CHAR_TYPES["-"] = "OP"
ONE_CHAR_TYPES["*"] = "OP"
ONE_CHAR_TYPES["/"] = "OP"
ONE_CHAR_TYPES["%"] = "OP"
ONE_CHAR_TYPES["<"] = "OP"
ONE_CHAR_TYPES[">"] = "OP"
ONE_CHAR_TYPES["!"] = "OP"
ONE_CHAR_TYPES["&"] = "OP"
ONE_CHAR_TYPES["|"] = "OP"
ONE_CHAR_TYPES["^"] = "OP"
ONE_CHAR_TYPES["~"] = "OP"
ONE_CHAR_TYPES["?"] = "OP"
ONE_CHAR_TYPES["("] = "LPAREN"
ONE_CHAR_TYPES[")"] = "RPAREN"
ONE_CHAR_TYPES["{"] = "LBRACE"
ONE_CHAR_TYPES["}"] = "RBRACE"
ONE_CHAR_TYPES["["] = "LBRACKET"
ONE_CHAR_TYPES["]"] = "RBRACKET"
ONE_CHAR_TYPES[":"] = "COLON"
ONE_CHAR_TYPES[";"] = "SEMICOLON"
ONE_CHAR_TYPES[","] = "COMMA"
ONE_CHAR_TYPES["."] = "DOT"

let TWO_CHAR_TYPES: dict<string, string> = {}
TWO_CHAR_TYPES["=="] = "OP"
TWO_CHAR_TYPES["!="] = "OP"
TWO_CHAR_TYPES["<="] = "OP"
TWO_CHAR_TYPES[">="] = "OP"
TWO_CHAR_TYPES["&&"] = "OP"
TWO_CHAR_TYPES["||"] = "OP"
TWO_CHAR_TYPES["^^"] = "OP"
TWO_CHAR_TYPES["??"] = "OP"
TWO_CHAR_TYPES["**"] = "OP"
TWO_CHAR_TYPES["//"] = "OP"
TWO_CHAR_TYPES["<<"] = "OP"
TWO_CHAR_TYPES[">>"] = "OP"
TWO_CHAR_TYPES["+="] = "OP"
TWO_CHAR_TYPES["-="] = "OP"
TWO_CHAR_TYPES["*="] = "OP"
TWO_CHAR_TYPES["/="] = "OP"
TWO_CHAR_TYPES["%="] = "OP"
TWO_CHAR_TYPES["&="] = "OP"
TWO_CHAR_TYPES["|="] = "OP"
TWO_CHAR_TYPES["^="] = "OP"
TWO_CHAR_TYPES["=>"] = "ARROW"
TWO_CHAR_TYPES["->"] = "RETURN_ARROW"
TWO_CHAR_TYPES["<-"] = "OP"
TWO_CHAR_TYPES["?."] = "OP"

let THREE_CHAR_TYPES: dict<string, string> = {}
THREE_CHAR_TYPES["==="] = "OP"
THREE_CHAR_TYPES["!=="] = "OP"
THREE_CHAR_TYPES["..."] = "OP"
THREE_CHAR_TYPES["**="] = "OP"
THREE_CHAR_TYPES["<<="] = "OP"
THREE_CHAR_TYPES[">>="] = "OP"

function makeTextToken(ttype: string, value: string, line: number, col: number) -> Token {
	return Token {
		kind: ttype,
		valueText: value,
		line: line,
		col: col
	}
}

function makeNumberToken(ttype: string, value: number, line: number, col: number) -> Token {
	return Token {
		kind: ttype,
		valueNumber: value,
		line: line,
		col: col
	}
}

function makeBooleanToken(ttype: string, value: boolean, line: number, col: number) -> Token {
	return Token {
		kind: ttype,
		valueBoolean: value,
		line: line,
		col: col
	}
}

function pushToken(tokens: TokenList, ttype: string, value: string, line: number, col: number) -> null {
	tokens.Push(makeTextToken(ttype, value, line, col))
}

function pushNumberToken(tokens: TokenList, ttype: string, value: number, line: number, col: number) -> null {
	tokens.Push(makeNumberToken(ttype, value, line, col))
}

function pushBooleanToken(tokens: TokenList, ttype: string, value: boolean, line: number, col: number) -> null {
	tokens.Push(makeBooleanToken(ttype, value, line, col))
}

function appendLegacyToken(tokens: TokenList, rawToken) -> null {
	let kind = rawToken["type"]
	let line = rawToken["line"]
	let col = rawToken["col"]
	if kind == "NUMBER" {
		pushNumberToken(tokens, kind, rawToken["value"], line, col)
		return
	}
	if kind == "BOOLEAN" {
		pushBooleanToken(tokens, kind, rawToken["value"], line, col)
		return
	}
	let textValue = rawToken["value"]
	if textValue == null {
		textValue = kind
	}
	pushToken(tokens, kind, textValue, line, col)
}

function appendLegacyTokens(tokens: TokenList, rawTokens) -> null {
	for let ti = 0; ti < rawTokens.Length; ti += 1 {
		appendLegacyToken(tokens, rawTokens[ti])
	}
}

function appendTokens(tokens: TokenList, moreTokens: TokenList) -> null {
	for let ti = 0; ti < moreTokens.Length; ti += 1 {
		tokens.Push(moreTokens[ti])
	}
}

function charCodeAtOrMinusOne(text: string, index: number) -> number {
	let code = text.CharCodeAt(index)
	if code == null {
		return -1
	}
	return code
}

function isLetter(ch: string) -> boolean {
	let code = charCodeAtOrMinusOne(ch, 0)
	return (code >= 65 && code <= 90) || (code >= 97 && code <= 122) || code == 95
}

function isDigit(ch: string) -> boolean {
	let code = charCodeAtOrMinusOne(ch, 0)
	return code >= 48 && code <= 57
}

function isHex(ch: string) -> boolean {
	let code = charCodeAtOrMinusOne(ch, 0)
	return (code >= 48 && code <= 57) || (code >= 65 && code <= 70) || (code >= 97 && code <= 102)
}

function digitValue(ch: string) -> number {
	let code = charCodeAtOrMinusOne(ch, 0)
	if code >= 48 && code <= 57 { return code - 48 }
	if code >= 65 && code <= 70 { return code - 55 }
	if code >= 97 && code <= 102 { return code - 87 }
	return -1
}

function utf8FromCodePoint(cp: number, sourcePath: string?, line: number, col: number) -> string {
	if cp < 0 || cp > 1114111 {
		let where = sourcePath != null ? f"{sourcePath}:{line}:{col}" : f"{line}:{col}"
		throw f"[Tokenizer] {where} Invalid unicode codepoint U+{cp.ToString()}"
	}
	if cp <= 127 {
		return string.FromCharCode(cp)
	}
	if cp <= 2047 {
		return string.FromCharCode(192 + (cp // 64)) + string.FromCharCode(128 + (cp % 64))
	}
	if cp <= 65535 {
		return string.FromCharCode(224 + (cp // 4096)) + string.FromCharCode(128 + ((cp % 4096) // 64)) + string.FromCharCode(128 + (cp % 64))
	}
	return string.FromCharCode(240 + (cp // 262144)) + string.FromCharCode(128 + ((cp % 262144) // 4096)) + string.FromCharCode(128 + ((cp % 4096) // 64)) + string.FromCharCode(128 + (cp % 64))
}

function parseBaseInt(text: string, base: number) -> number? {
	let value = 0
	for let i = 0; i < text.Length; i += 1 {
		let ch = text.CharAt(i)
		if ch == "_" { continue }
		let d = digitValue(ch)
		if d < 0 || d >= base {
			return null
		}
		value = value * base + d
	}
	return value
}

function fail(sourcePath: string?, line: number, col: number, msg: string) -> null {
	if sourcePath != null {
		throw f"[Tokenizer] {sourcePath}:{line}:{col} {msg}"
	}
	throw f"[Tokenizer] {line}:{col} {msg}"
}

function tokenizeInternal(input: string, sourcePath: string?, initialLine: number?, initialCol: number?) -> TokenList {
	let tokens = []<Token>
	let i = 0
	let len = input.Length
	let line = 1
	let col = 1
	if initialLine != null {
		line = initialLine
	}
	if initialCol != null {
		col = initialCol
	}

	const peek = function(offset: number?) -> string {
		let off = 0
		if offset != null {
			off = offset
		}
		let index = i + off
		if index < 0 || index >= len {
			return ""
		}
		return input.CharAt(index)
	}

	const slice = function(start: number, stop: number) -> string {
		let safeStart = start < 0 ? 0 : start
		let safeStop = stop < safeStart ? safeStart : stop
		return input.Slice(safeStart, safeStop)
	}

	const advance = function(count: number?) -> null {
		let remaining = 1
		if count != null {
			remaining = count
		}
		while remaining > 0 && i < len {
			let ch = peek(0)
			if ch == "\r" && peek(1) == "\n" {
				i += 2
				line += 1
				col = 1
				remaining -= 2
			} else {
				i += 1
				if ch == "\n" || ch == "\r" {
					line += 1
					col = 1
				} else {
					col += 1
				}
				remaining -= 1
			}
		}
	}

	const readHexDigits = function(count: number) -> number? {
		let value = 0
		for let j = 0; j < count; j += 1 {
			let d = digitValue(peek(0))
			if d < 0 || d >= 16 {
				return null
			}
			value = value * 16 + d
			advance(1)
		}
		return value
	}

	const readBracedUnicode = function(startLine: number, startCol: number) -> string {
		advance(1)
		let value = 0
		let digits = 0
		while i < len && peek(0) != "}" {
			let d = digitValue(peek(0))
			if d < 0 || d >= 16 {
				fail(sourcePath, startLine, startCol, "Invalid \\u{...} escape (non-hex '" + peek(0) + "')")
			}
			value = value * 16 + d
			digits += 1
			if digits > 6 {
				fail(sourcePath, startLine, startCol, "Invalid \\u{...} escape (too many hex digits)")
			}
			advance(1)
		}
		if peek(0) != "}" {
			fail(sourcePath, startLine, startCol, "Unterminated \\u{...} escape")
		}
		advance(1)
		if digits == 0 {
			fail(sourcePath, startLine, startCol, "Invalid \\u{...} value")
		}
		return utf8FromCodePoint(value, sourcePath, startLine, startCol)
	}

	const decodeEscape = function(quote: string, startLine: number, startCol: number) -> string {
		advance(1)
		let e = peek(0)
		if e == "" {
			fail(sourcePath, startLine, startCol, "Unfinished escape at end of string")
		}
		if e == "n" { advance(1); return "\n" }
		if e == "r" { advance(1); return "\r" }
		if e == "t" { advance(1); return "\t" }
		if e == "b" { advance(1); return "\b" }
		if e == "f" { advance(1); return "\f" }
		if e == "v" { advance(1); return "\v" }
		if e == "0" { advance(1); return "\0" }
		if e == "\\" { advance(1); return "\\" }
		if e == "\"" { advance(1); return "\"" }
		if e == "'" { advance(1); return "'" }

		if e == "x" {
			advance(1)
			let value = readHexDigits(2)
			if value == null {
				fail(sourcePath, startLine, startCol, "Invalid \\xHH escape")
			}
			return string.FromCharCode(value)
		}

		if e == "u" {
			advance(1)
			if peek(0) == "{" {
				return readBracedUnicode(startLine, startCol)
			}
			let value = readHexDigits(4)
			if value == null {
				fail(sourcePath, startLine, startCol, "Invalid \\uXXXX escape")
			}
			return utf8FromCodePoint(value, sourcePath, startLine, startCol)
		}

		fail(sourcePath, startLine, startCol, f"Unknown escape '\\{e}'")
	}

	const readIdent = function() -> null {
		let start = i
		let startLine = line
		let startCol = col
		while i < len && (isLetter(peek(0)) || isDigit(peek(0))) {
			advance(1)
		}
		let txt = slice(start, i)
		let ttype = KEYWORD_TYPES.Has(txt) ? KEYWORD_TYPES[txt] : "IDENT"
		if ttype == "BOOLEAN" {
			pushBooleanToken(tokens, ttype, txt == "true", startLine, startCol)
		} else {
			pushToken(tokens, ttype, txt, startLine, startCol)
		}
	}

	const readNumber = function() -> null {
		let start = i
		let startLine = line
		let startCol = col

		if peek(0) == "0" && (peek(1) == "x" || peek(1) == "X") {
			advance(2)
			let digitsStart = i
			while i < len && (isDigit(peek(0)) || isHex(peek(0)) || peek(0) == "_") {
				advance(1)
			}
			if i == digitsStart {
				fail(sourcePath, startLine, startCol, "Malformed hex literal")
			}
			let hexValue = parseBaseInt(slice(digitsStart, i), 16)
			if hexValue == null {
				fail(sourcePath, startLine, startCol, f"Malformed number literal '{slice(start, i)}'")
			}
			pushNumberToken(tokens, "NUMBER", hexValue, startLine, startCol)
			return
		} else if peek(0) == "0" && (peek(1) == "o" || peek(1) == "O") {
			advance(2)
			let digitsStart = i
			while i < len {
				let ch = peek(0)
				if (ch >= "0" && ch <= "7") || ch == "_" {
					advance(1)
				} else {
					break
				}
			}
			if i == digitsStart {
				fail(sourcePath, startLine, startCol, "Malformed octal literal")
			}
			let octalValue = parseBaseInt(slice(digitsStart, i), 8)
			if octalValue == null {
				fail(sourcePath, startLine, startCol, f"Malformed number literal '{slice(start, i)}'")
			}
			pushNumberToken(tokens, "NUMBER", octalValue, startLine, startCol)
			return
		} else if peek(0) == "0" && (peek(1) == "b" || peek(1) == "B") {
			advance(2)
			let digitsStart = i
			while i < len && (peek(0) == "0" || peek(0) == "1" || peek(0) == "_") {
				advance(1)
			}
			if i == digitsStart {
				fail(sourcePath, startLine, startCol, "Malformed binary literal")
			}
			let binaryValue = parseBaseInt(slice(digitsStart, i), 2)
			if binaryValue == null {
				fail(sourcePath, startLine, startCol, f"Malformed number literal '{slice(start, i)}'")
			}
			pushNumberToken(tokens, "NUMBER", binaryValue, startLine, startCol)
			return
		}

		while i < len && (isDigit(peek(0)) || peek(0) == "_") {
			advance(1)
		}
		if peek(0) == "." {
			advance(1)
			if !(isDigit(peek(0)) || peek(0) == "_") {
				fail(sourcePath, startLine, startCol, f"Malformed number literal '{slice(start, i)}'")
			}
			while i < len && (isDigit(peek(0)) || peek(0) == "_") {
				advance(1)
			}
		}
		let clean = slice(start, i).ReplaceAll("_", "")
		let decimalValue = clean.ToNumber()
		if decimalValue == null {
			fail(sourcePath, startLine, startCol, f"Malformed number literal '{slice(start, i)}'")
		}
		pushNumberToken(tokens, "NUMBER", decimalValue, startLine, startCol)
	}

	const readString = function() -> null {
		let quote = peek(0)
		let quoteCode = charCodeAtOrMinusOne(quote, 0)
		let startLine = line
		let startCol = col
		advance(1)
		let pieces = []<string>

		while i < len {
			let ch = peek(0)
			let chCode = charCodeAtOrMinusOne(ch, 0)
			if chCode == quoteCode {
				advance(1)
				pushToken(tokens, "STRING", pieces.Join(""), startLine, startCol)
				return
			}
			if chCode == 92 {
				pieces.Push(decodeEscape(quote, startLine, startCol))
			} else {
				pieces.Push(ch)
				advance(1)
			}
		}

		fail(sourcePath, startLine, startCol, f"Unterminated string literal starting from {startLine}:{startCol}")
	}

	const readFString = function() -> null {
		let startLine = line
		let startCol = col
		advance(1)
		let quote = peek(0)
		if quote != "\"" && quote != "'" {
			fail(sourcePath, startLine, startCol, "Invalid fstring start '" + quote + "'")
		}
		let quoteCode = charCodeAtOrMinusOne(quote, 0)
		advance(1)
		let buffer = []<string>

		while i < len {
			let ch = peek(0)
			let chCode = charCodeAtOrMinusOne(ch, 0)
			if chCode == quoteCode {
				if buffer.Length > 0 {
					pushToken(tokens, "STRING", buffer.Join(""), startLine, startCol)
				}
				advance(1)
				return
			}
			if chCode == 123 {
				if buffer.Length > 0 {
					pushToken(tokens, "STRING", buffer.Join(""), startLine, startCol)
					pushToken(tokens, "OP", "+", line, col)
					buffer = []<string>
				}
				advance(1)
				let exprLine = line
				let exprCol = col
				let exprStart = i
				let depth = 1
				let stringMode = 0
				let stringQuoteCode = 0
				while i < len && depth > 0 {
					let inner = peek(0)
					let innerCode = charCodeAtOrMinusOne(inner, 0)
					if stringMode != 0 {
						if inner == "\\" {
							advance(1)
							if i < len {
								advance(1)
							}
						} else if innerCode == stringQuoteCode {
							stringMode = 0
							advance(1)
						} else {
							advance(1)
						}
					} else {
						if innerCode == 34 || innerCode == 39 {
							stringMode = 1
							stringQuoteCode = innerCode
							advance(1)
						} else if inner == "{" {
							depth += 1
							advance(1)
						} else if inner == "}" {
							depth -= 1
							if depth == 0 {
								break
							}
							advance(1)
						} else {
							advance(1)
						}
					}
				}
				if depth > 0 {
					fail(sourcePath, startLine, startCol, "Unterminated fstring")
				}
				let exprText = slice(exprStart, i)
				pushToken(tokens, "IDENT", "tostring", line, col)
				pushToken(tokens, "LPAREN", "(", line, col)
				appendTokens(tokens, tokenizeInternal(exprText, sourcePath, exprLine, exprCol))
				pushToken(tokens, "RPAREN", ")", line, col)
				advance(1)
				let nextCh = peek(0)
				let nextCode = charCodeAtOrMinusOne(nextCh, 0)
				if nextCode != quoteCode && nextCh != "" {
					pushToken(tokens, "OP", "+", line, col)
				}
			} else if chCode == 92 {
				buffer.Push(decodeEscape(quote, startLine, startCol))
			} else {
				buffer.Push(ch)
				advance(1)
			}
		}

		fail(sourcePath, startLine, startCol, "Unterminated fstring")
	}

	while i < len {
		let ch = peek(0)

		if ch == "\r" && peek(1) == "\n" {
			i += 2
			line += 1
			col = 1
			pushToken(tokens, "NEWLINE", "\n", line, col)
		} else if ch == "\n" || ch == "\r" {
			i += 1
			line += 1
			col = 1
			pushToken(tokens, "NEWLINE", "\n", line, col)
		} else if ch == " " || ch == "\t" || ch == "\v" || ch == "\f" {
			advance(1)
		} else if ch == "#" {
			advance(1)
			while i < len && peek(0) != "\n" && peek(0) != "\r" {
				advance(1)
			}
		} else if ch == "/" && peek(1) == "*" {
			advance(2)
			while i < len && !(peek(0) == "*" && peek(1) == "/") {
				advance(1)
			}
			if i < len {
				advance(2)
			}
		} else if charCodeAtOrMinusOne(ch, 0) == 102 {
			let nextCode = charCodeAtOrMinusOne(peek(1), 0)
			if nextCode == 34 || nextCode == 39 {
				readFString()
			} else {
				readIdent()
			}
		} else if isLetter(ch) {
			readIdent()
		} else if isDigit(ch) {
			readNumber()
		} else if ch == "\"" || ch == "'" {
			readString()
		} else {
			let startLine = line
			let startCol = col
			let three = slice(i, i + 3)
			let two = slice(i, i + 2)
			if THREE_CHAR_TYPES.Has(three) {
				pushToken(tokens, THREE_CHAR_TYPES[three], three, startLine, startCol)
				advance(3)
			} else if TWO_CHAR_TYPES.Has(two) {
				pushToken(tokens, TWO_CHAR_TYPES[two], two, startLine, startCol)
				advance(2)
			} else if ONE_CHAR_TYPES.Has(ch) {
				pushToken(tokens, ONE_CHAR_TYPES[ch], ch, startLine, startCol)
				advance(1)
			} else {
				fail(sourcePath, startLine, startCol, f"Unknown character '{ch}'")
			}
		}
	}

	return tokens
}

export function tokenize(input: string, sourcePath: string?) -> TokenList {
	return tokenizeInternal(input, sourcePath, 1, 1)
}