Jekyll::Hooks.register :site, :post_render do |site|
  # Load configuration from data file
  config = site.data['anyat'] || {}
  return unless config['enabled']

  # Process all pages and posts
  combined_applicable = []
  if config['settings']['process_pages']
    combined_applicable += site.pages
  end
  if config['settings']['process_posts']
    combined_applicable += site.posts.docs
  end
  if config['settings']['process_collections'] == true
    combined_applicable += site.collections.values.map(&:docs).flatten
  elsif config['settings']['process_collections'].is_a?(Array)
    for collection_name in config['settings']['process_collections']
      if site.collections.key?(collection_name)
        combined_applicable += site.collections[collection_name].docs
      else
        # logger not installed
        Jekyll.logger.warn "AnyAt: Collection '#{collection_name}' not found, skipping."
      end
    end
  end

  for page in combined_applicable
    next unless page.content

    # Apply the transformation to the content
    page.output = process_anyat(page.output, config)
  end
end

def process_anyat(input, config)
  return input unless input.is_a?(String)
  # cspell: ignore noconvert
  
  # Optional ! for no conversion (use double bang to show how to use bang)
  # optional = or $ for raw link or raw username
  # platform@username@domain
  # or platform@username with domain N/A or default domain
  # Example: twitter@user, email@john@example.com
  pattern = /(?<noconvert>!?[=$]?)(?<platform>[a-z0-9\-]+)?@(?<username>[a-zA-Z0-9_\.\-]*[a-zA-Z0-9_\-])(?:@(?<domain>[a-zA-Z0-9\.\-]*[a-zA-Z0-9\-]))?(?=\W|$)/

  linkers = config['linkers'] || {}

  return input.gsub(pattern) do |match|
    noconvert = $~[:noconvert] || ''

    unchanged = (
      (($~[:noconvert] && $~[:noconvert][0] == '!'?
        $~[:noconvert][1..-1] :
        $~[:noconvert]) || '') +
      ($~[:platform] ? "#{$~[:platform]}" : '') +
      "@#{$~[:username]}" +
      ($~[:domain] ? "@#{$~[:domain]}" : '')
    )

    if noconvert && noconvert[0] == '!'
      # If the match starts with '!', do not convert
      # Remove the '!' and hand back the raw text
      next unchanged
    end
    
    platform = $~[:platform]
    username = $~[:username]
    domain = $~[:domain]
    
    if platform.nil? || platform.empty?
      if config['default_platform']
        platform = config['default_platform']
      else
        next unchanged
      end
    end
    
    unless linkers.key?(platform)
      next "#{match} ^%^ Platform not supported ^%^"
    end
    
    # Platform info - resolve aliases
    pi = linkers[platform]

    n=[]
    while pi.is_a?(String)
      if n.include?(pi)
        next "#{match} ^%^ Circular alias detected for '#{platform}' ^%^"
      end
      n << pi
      alias_target = pi.downcase.gsub(/[^a-z0-9\-]/, '') # Normalize alias target
      if linkers.key?(alias_target)
        pi = linkers[alias_target]
    else
        next "#{match} ^%^ Alias target '#{alias_target}' not found ^%^"
      end
    end
    
    # Substitutions

    if domain && !domain.empty?
      url  = (pi[ 'link_domain' ] || pi[ 'link' ]).gsub('^u', username).gsub('^d', domain)
      text = (pi['format_domain'] || pi['format']).gsub('^u', username).gsub('^d', domain)
    elsif pi['domain']
      domain = pi['domain']
      url  = (pi[ 'link' ] || pi[ 'link_domain' ]).gsub('^u', username).gsub('^d', domain)
      text = (pi['format'] || pi['format_domain']).gsub('^u', username).gsub('^d', domain)
    else
      url  = pi[ 'link' ].gsub('^u', username)
      text = pi['format'].gsub('^u', username)
    end

    if noconvert && noconvert[-1] == '='
      next url
    elsif noconvert && noconvert[-1] == '$'
      next text
    end
    
    # Link to url
    next "<a href=\"#{url}\" class=\"anyat_badge badge-#{platform}\" target=\"_blank\">#{pi['badge']} #{text}</a>"
  end
end
