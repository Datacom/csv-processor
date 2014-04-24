module ApplicationHelper
  def array_to_table(array_of_arrays, options={})
    # Default options
    options.reverse_merge!(class: 'table table-bordered')

    content_tag(:table, options) do
      [
        content_tag(:thead, options[:thead]) do
          content_tag(:tr, options[:thead].try(:[], :tr)) do
            array_of_arrays[0].map do |cell|
              content_tag(:th, h(cell), options[:th])
            end.join.html_safe
          end
        end,
        content_tag(:tbody, options[:tbody]) do
          array_of_arrays[1..-1].map do |row|
            content_tag(:tr, options[:tbody].try(:[], :tr)) do
              row.map do |cell|
                content_tag(:td, h(cell), options[:td])
              end.join.html_safe
            end
          end.join.html_safe
        end
      ].join.html_safe
    end
  end
end
