class SyntaxHighlighter
  attr_reader :formatter

  def initialize
    @formatter = Rouge::Formatters::HTML.new(
      wrap: false
    )
  end

  def highlight(content, language)
    lexer_name = map_linguist_to_rouge(language)
    lexer = Rouge::Lexers.const_get(lexer_name).new

    formatter.format(lexer.lex(content))
  end

  LINGUIST_TO_ROUGE = {
    "Text"  => "PlainText",
  }.freeze

  def map_linguist_to_rouge(linguist_name)
    LINGUIST_TO_ROUGE[linguist_name] || linguist_name
  end
end
