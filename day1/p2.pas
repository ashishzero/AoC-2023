program p2;

type
Tokenizer = record
    str: string;
    cur: int32;
	parsed: boolean;
end;

procedure TryParseDigit(name: string; digit: int32; var tok: Tokenizer);
var
	iter: int32;
begin
	tok.parsed := false;

	if (Length(name) <= Length(tok.str)) then
	begin
		tok.parsed := true;
		for iter := 1 to Length(name) do
		begin
			if (name[iter] <> tok.str[iter]) then
			begin
				tok.parsed := false;
				break;
			end;
		end;
	end;

	if (tok.parsed) then
	begin
		tok.str := Copy(tok.str, Length(name), Length(tok.str) - Length(name) + 1);
		tok.cur := digit;
	end;
end;

var
	digits: array [1 .. 9] of string = ('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine');

procedure TryParseOne2Nine(var tok: Tokenizer);
var
	iter: int32;
begin
	tok.parsed := false;
	while (Length(tok.str) > 0) do
	begin
		if ((tok.str[1] >= '0') and (tok.str[1] <= '9')) then
		begin
			tok.parsed := true;
			tok.cur := ord(tok.str[1]) - ord('0');
			tok.str := Copy(tok.str, 2, Length(tok.str) - 1);
			break;
		end;
		for iter:=1 to Length(digits) do
		begin
			TryParseDigit(digits[iter], iter, tok);
			if (tok.parsed) then break;
		end;
		if (tok.parsed) then break;
		tok.str := Copy(tok.str, 2, Length(tok.str) - 1);
	end;
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
	tok.cur := 0;
	tok.parsed := false;

	TryParseOne2Nine(tok);
	result.first := tok.cur;

	while (tok.parsed) do
	begin
		TryParseOne2Nine(tok);
	end;

	result.last := tok.cur;
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

	writeln (sizeof(int32));

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
