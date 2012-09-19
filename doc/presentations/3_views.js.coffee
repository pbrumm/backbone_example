#http://documentcloud.github.com/backbone/#View

#assets/javascripts/views/browse/index.js.coffee
class window.BrowseIndex extends Backbone.View
  template: JST['browse/index']
  events:
    "click .detail-view": "switchToDetailView"
    "click .summary-view": "switchToSummaryView"
  addProperties: =>
    ul = $(@el).find(".properties > ul")
    ul.html("")
    App.Properties.each( (property)=>
      view = new BrowseProperty(model: property)
      ul.append(view.render().el)
    )
  render: =>
    $(@el).html(this.template({}))
    @addProperties()
    @

#  property view
#assets/javascripts/views/browse/components/property.js.coffee
class window.BrowseProperty extends Backbone.View
  tagName: "li"
  template: JST['browse/property']
  events:
    "click .title": "handleTitleClick"
  handleTitleClick: (e)=>
    console.log("title clicked")
  render: =>
    json = @model.toJSON()
    $(@el).html(this.template(json))
    @


#assets/templates/browse/property.jst.eco
<div class='property'>
	<div class='title'><%=@name%></div>
	<ul class='property_values'></ul>
</div>