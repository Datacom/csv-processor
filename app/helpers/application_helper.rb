module ApplicationHelper
  def csv_to_html(csv_table, options={})
    # Default options: {class: 'table table-bordered'}. Use :add_class to add extra classes without removing these
    classes = options[:class].try(:split, ' ') || %w(table table-bordered)
    classes += options[:add_class].split(' ') if options[:add_class]
    options.reverse_merge!(class: classes.join(' '))

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

  # Returns a FontAwesome icon. FA classes can be added in plain arguments, removing the 'fa-' prefix.
  # Non-FA classes and other HTML options can be added as a hash, just as they would be passed to #content_tag.
  # Examples:
  # icon(:square)                       => '<i class="fa fa-square"></i>'
  # icon(:square, :stack_2x, :inverse)  => '<i class="fa fa-square fa-stack-2x fa-inverse"></i>'
  # icon(:square, class: 'text-danger') => '<i class="fa fa-square text-danger"></i>'
  def icon(*args)
    options = args.extract_options!

    if args.empty? # ToDo: icon() is a placeholder while I'm finding icons. delete it
      classes = ['fa', 'fa-info-circle', 'fa-lg', 'text-danger']
    else
      classes = ['fa'] +
        args.map { |c| "fa-#{c.to_s.gsub('_', '-')}"} +
        (options.delete(:class).try(:split, ' ') || [])
    end

    options[:class] = classes.join(' ')

    content_tag(:i, '', options)
  end
end
