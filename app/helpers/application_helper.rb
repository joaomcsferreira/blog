module ApplicationHelper
    def show_svg(path)
        File.open("app/assets/images/#{path}", "rb") do |file|
          raw file.read
        end
    end

    def month_day_comma_year(datetime)
      datetime.strftime('%B %e, %Y')
    end
end
