module Jekyll
  module Links
    def blog_md(blog)
      result = "-"

      if blog["prefix"]
        result += " #{blog['prefix']}"
      end
      result += " ["
      for account in blog["accounts"]
        if account != blog["accounts"].first
          result += ", "
        end
        result += "#{account}"
      end
      result += "]"
      if blog["comment"]
        result += " (#{blog['comment']})"
      end

      result
    end
  end
end

Liquid::Template.register_filter(Jekyll::Links)