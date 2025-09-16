# _plugins/tags_page.rb
class TagsPageGenerator < Jekyll::Generator
  safe true

  def generate(site)
    tags = site.posts.docs.map { |post| post.data['tags'] }.flatten.compact.uniq
    site.pages << TagsPage.new(site, site.source, 'tags', 'index.html', tags, 'tags_template.html')
  end
end

class TagsPage < Jekyll::Page
  def initialize(site, base, dir, name, tags, template)
    @site = site
    @base = base
    @dir = dir
    @name = name
    self.process(@name)
    self.data = {
      'layout' => 'default',
      'title' => 'all tags',
      'tags' => tags.sort
    }
    self.content = File.read(File.join(@site.source, '_layouts', template))
  end
end
