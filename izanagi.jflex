/* imports */
import java.io.IOException;

%%

%class IzanagiLexer			//name of class that generate by JFlex
%implements IzanagiTokens	//name of interface
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

ws = [ \t\f]

%%

[+\-*/()=\n]	{
    return ( (int)(yytext().charAt(0)) ); //to charcode
}

{ws}+			{ }
\r				{ }

[1-9][0-9]*		{
    yylval = Double.parseDouble(yytext());
    return (NUMBER);
}

[0-9]*\.[0-9]*	{
    yylval = Double.parseDouble(yytext());
    return (NUMBER);
}

.				{
    throw new Error("Invalid character <" + yytext() + ">");
}
