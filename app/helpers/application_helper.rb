module ApplicationHelper
  def highlight_entry_content(entry)
    @highlighter ||= SyntaxHighlighter.new
    @highlighter.highlight(entry.content, entry.language).html_safe
  end
end
