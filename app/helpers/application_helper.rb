module ApplicationHelper
  def csv_to_html(csv_table, options={})
    # Default options
    options.reverse_merge!(class: 'table table-bordered')

    content_tag(:table, options) do
      [
        content_tag(:thead, options[:thead]) do
          content_tag(:tr, options[:thead].try(:[], :tr)) do
            csv_table.headers.map do |cell|
              content_tag(:th, h(cell), options[:th])
            end.join.html_safe
          end
        end,
        content_tag(:tbody, options[:tbody]) do
          line = []
          csv_table.map do |row|
            content_tag(:tr, options[:tbody].try(:[], :tr)) do
              row.fields.map do |cell|
                content_tag(:td, h(cell), options[:td])
              end.join.html_safe
            end
          end.join.html_safe
        end
      ].join.html_safe
    end
  end

  def link_to_name(record, *args)
    text = record.try(:name).present? ? record.name : "Unnamed ##{record.id}"
    link_to text, record, *args
  end

  def icon(icon_name = nil, *extra_classes)
    if icon_name.nil? # ToDo: this is a placeholder while I'm finding icons. delete it
      classes = ['fa', 'fa-info-circle', 'fa-lg', 'text-danger']
    else
      classes = ['fa', "fa-#{icon_name.to_s.gsub('_', '-')}"] + extra_classes.map { |c| "fa-#{c.to_s.gsub('_', '-')}"}
    end

    content_tag(:i, '', class: classes.join(' '))
  end
end
