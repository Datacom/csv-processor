module BuildFilesHelper
  def display(file)
    content_tag(:div, class: 'panel panel-default') do
      [
        content_tag(:div, class: 'panel-heading') do
          content_tag(:div, class: 'row') do
            [
              content_tag(:div, File.split(file.path)[1], class: 'col-sm-6'),
              content_tag(:div, "Size: #{file.size} bytes<br/>MD5: #{file.md5}".html_safe, class: 'col-sm-6 small text-right'),
            ].join.html_safe
          end
        end,
        array_to_table(file.to_a)
      ].join.html_safe
    end
  end
end
