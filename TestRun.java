class TestRun
{
	public static void main(String[] args)
	{
		IzanagiLexer lexer = new IzanagiLexer(System.in);
		IzanagiParser calc = new IzanagiParser(lexer);
		lexer.nextToken();
		calc.parse();
	}
}
