extends Node

#Info [Cattegory, Popularity, Difficulty, Other TAGS]
enum {Angular, BASIC, C, Django, Elixir, Flask, Go, Haskell, Itk, Java, Python, React, Kawa, Lua, MATLAB, Nasm, OpenCL,
Prolog, QBasic, Scratch, TypeScript, Unicon, VisualBasic, WebGL, Xojo, Yorick, Zig}

const DATA = {
	Angular:
		["frontend", "medium", "high"],
	BASIC:
		["programming_language", "low", "low"],
	C:
		["programming_language", "high", "high"],
	Django:
		["framework", "high", "low"],
	Elixir:
		["programming_language", "medium", "medium"],
	Flask:
		["framework", "medium", "low"],
	Go:
		["programming_language", "medium", "medium"],
	Haskell:
		["programming_language", "medium", "high"],
	Itk:
		["toolkit", "low", "medium"],
	Java:
		["programming_language", "high", "high"],
	Python:
		["programming_language", "high", "low"],
	React:
		["frontend", "high", "medium"],
	Kawa:
		["programming_language", "low", "medium"],
	Lua:
		["programming_language", "medium", "medium"],
	MATLAB:
		["programming_language", "medium", "medium"],
	Nasm:
		["programming_language", "low", "high"],
	OpenCL:
		["framework", "medium", "high"],
	Prolog:
		["programming_language", "low", "high"],
	QBasic:
		["programming_language", "low", "low"],
	Scratch:
		["programming_language", "medium", "low"],
	TypeScript:
		["programming_language", "high", "low"],
	Unicon:
		["programming_language", "low", "medium"],
	VisualBasic:
		["programming_language", "medium", "medium"],
	WebGL:
		["framework", "medium", "medium"],
	Xojo:
		["programming_language", "low", "medium"],
	Yorick:
		["programming_language", "low", "medium"],
	Zig:
		["programming_language", "low", "medium"],
	}
