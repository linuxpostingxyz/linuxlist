module BlogGen
  class BlogPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.data["blogfile"]["blogs"].each do |page, blog|
        #site.pages << BlogPage.new(site, page, blog)
        site.pages << BlogPage.new(site, site.source, "blog", page + '.html')
      end
    end
  end

  class BlogPage < Jekyll::Page
    #def initalize(site, page, blog)
    def initalize(site, base, dir, name)
      #@site = site
      #@base = site.source
      #@dir = "blog"

      # @basename = "#{page}"
      # @ext = '.html'
      # @name = "#{page}.html"

      @site = site
      @base = base
      @dir = dir
      @basename = name.delete_suffix(".html")
      @ext = '.html'
      @name = name

    end

    def url_placeholders
      {
        :path       => @dir,
        :category   => @dir,
        :basename   => basename,
        :output_ext => output_ext,
      }
    end
  end
end

