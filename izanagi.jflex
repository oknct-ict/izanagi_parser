/* imports */
import java.io.IOException;

%%

//name of class that generate by JFlex
%class IzanagiLexer	
//name of interface
%implements IzanagiTokens
%int
%unicode
%line
%column

%{
  /* interface to jacc */
  int token;
  double yylval;

  int nextToken()
  {
    try {
      token = yylex();
      return (token);
    }
    catch (IOException e){
      token = ENDINPUT;
      return (token);
    }
  }

  int getToken()
  {
    return (token);
  }

  double getSemantic()
  {
    return (yylval);
  }
%}

LineTerminator = \r | \n | \r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/* commints */
Comment = {RemComment} | {EndOfLineComment}

RemComment = "Rem" {InputCharacter}* {LineTerminator}?
EndOfLineComment = "'" {InputCharacter}* {LineTerminator}?

%%

<YYINITIAL> "Dim"			{ return (DIM); }
<YYINITIAL> "As"			{ return (AS); }
<YYINITIAL> "If"			{ return (IF); }
<YYINITIAL> "ElseIf"		{ return (ELSEIF); }
<YYINITIAL> "Else"			{ return (ELSE); }
<YYINITIAL> "Select"		{ return (SELECT); }
<YYINITIAL> "Case"			{ return (CASE); }
<YYINITIAL> "While"			{ return (WHILE); }
<YYINITIAL> "End"			{ return (END); }
<YYINITIAL> "Return"		{ return (RETURN); }
<YYINITIAL> "Break"			{ return (BREAK); }

<YYINITIAL> "Function"		{ return (FUNCTION); }

<YYINITIAL> "And"			{ return (AND); }
<YYINITIAL> "Or"			{ return (OR); }
<YYINITIAL> "Not"			{ return (NOT); }
<YYINITIAL> "=="			{ return (EQ); }
<YYINITIAL> "!="			{ return (NEQ); }
<YYINITIAL> ">"				{ return (GT); }
<YYINITIAL> ">="			{ return (GE); }
<YYINITIAL> "<"				{ return (LT); }
<YYINITIAL> "<="			{ return (LE); }

<YYINITIAL> [+\-*/()=\n]	{
    return ( (int)(yytext().charAt(0)) ); //to charcode
}

<YYINITIAL> [1-9][0-9]*		{
    yylval = Double.parseDouble(yytext());
    return (NUMBER);
}

<YYINITIAL> [0-9]*\.[0-9]*	{
    yylval = Double.parseDouble(yytext());
    return (NUMBER);
}

<YYINITIAL> {
  /* comments */
  {Comment}		{ /* ignore */ }
  
  /* whitespace */
  {WhiteSpace}	{ /* ignore */ }
}

.				{
    throw new Error("Invalid character <" + yytext() + ">");
}
