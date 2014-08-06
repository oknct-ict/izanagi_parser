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
