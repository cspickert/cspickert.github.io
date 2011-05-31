def article_classes(item)
  raise "this item isn't an article" if item[:kind] != 'article'
  
  classes = ['post']
  classes << 'place' if item.attributes.has_key?(:place)
  
  classes.join(' ')
end
