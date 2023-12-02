program p2;

type
Tokenizer = record
    str: string;
	pos: int32;
    parsed: int32;
end;

function HasPrefix(str: string; prefix: string): boolean;
var
	iter: int32;
	res: boolean;
begin
	res := false;
	if (Length(prefix) <= Length(str)) then
	begin
		res := true;
		for iter := 1 to Length(prefix) do
		begin
			if (prefix[iter] <> str[iter]) then
			begin
				res := false;
				break;
			end;
		end;
	end;
	HasPrefix := res;
end;

var
	digits: array [1 .. 9] of string = ('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine');

function TryParseDigit(var tok: Tokenizer): boolean;
var
	iter: int32;
	res: boolean;
	sub: string;
begin
	res := false;
	while tok.pos <= Length(tok.str) do
	begin
		if ((tok.str[tok.pos] >= '0') and (tok.str[tok.pos] <= '9')) then
		begin
			res := true;
			tok.parsed := ord(tok.str[tok.pos]) - ord('0');
			tok.pos += 1;
			break;
		end;

		sub := Copy(tok.str, tok.pos, Length(tok.str) - tok.pos + 1);
		for iter := 1 to Length(digits) do
		begin
			if (HasPrefix(sub, digits[iter])) then
			begin
				res := true;
				tok.parsed := iter;
				tok.pos += Length(digits[iter]) - 1;
				break;
			end;
		end;

		if (res) then break;
		tok.pos += 1;
	end;
	TryParseDigit := res;
end;

type
EndDigits = record
    first: int32;
    last: int32;
end;

function ParseEndDigits(input: string): EndDigits;
var
	result: EndDigits;
	tok: Tokenizer;
begin
	tok.str := input;
	tok.pos := 1;
	tok.parsed := 0;

	result.first := 0;
	result.last := 0;

	if (TryParseDigit(tok)) then
	begin
		result.first := tok.parsed;
		while (TryParseDigit(tok)) do
		begin
		end;
		result.last := tok.parsed;
	end;

	ParseEndDigits := result;
end;

var
	path: string;
	line: string;
	fp: text;
	res: EndDigits;
	sum: int32;
	n: int32;
begin
	path := 'input.txt';
	assign(fp, path);
	reset(fp);

	sum := 0;
	while (not eof(fp)) do
	begin
		readln(fp, line);
		res := ParseEndDigits(line);
		n := res.first * 10 + res.last;
		sum += n;
		writeln (line, ' -> ', res.first, ' ', res.last, ' ', n, ' ', sum);
		(**readln;**)
	end;

	writeln (sum);
end.
