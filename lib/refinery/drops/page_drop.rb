class PageDrop < Liquid::Drop

  def initialize(page)
    @page = page
  end
  
  def title
    @page[:title]
  end
  
  def url
    @page[:url]
  end
  
  def dom_id
    (@page.parent_id.nil? and @page.title.present?) ? "item_#{@page.position}'" : nil
  end
  
  def css_classes
    css = []
    css << "selected" if selected_page?# or descendant_page_selected?(@page)
    css << "first" if @page.position == 0
    css << "last" if @page.position == @page.shown_siblings.size
    css.join(" ")
  end
  
  def navigation
    Page.top_level(include_children=true)
  end
  
  def subpages?
    @page.shown_siblings.size > 0
  end
  
  def subpages
    @page.shown_siblings
  end
  
  protected
  
  def selected_page?
    #current_page?(@page) or
        (request.path =~ Regexp.new(@page.menu_match) if @page.menu_match.present?) or
        (request.path == @page.link_url) or
        (request.path == @page.nested_path)
  end
  
end
