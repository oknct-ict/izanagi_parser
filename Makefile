all: izanagi_parser

izanagi_parser: IzanagiParser.java IzanagiToken.java IzanagiLexer.java
	javac IzanagiParser.java

IzanagiToken.java: IzanagiParser.java
IzanagiParser.java: Izanagi.jacc
	java -jar ./jacc.jar Izanagi.jacc


IzanagiLexer.java: izanagi.jflex
	java -jar ./JFlex.jar izanagi.jflex


.PHONY: clean
clean:
	ls |grep -E "Izanagi.*\.java" |xargs rm -f
	rm -f *.class
