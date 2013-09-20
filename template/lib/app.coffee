class CM
  constructor: () ->
    @content = []

  loadContent: (cb) ->
    console.log 'loading content'
    $.get("/content.json", (data) =>
      console.log 'data',data
      @_rawContent = data
      for content in @_rawContent
        @content.push new Content content
      cb() if cb
    )

class Content

  constructor: (@content) ->

  getHtml: (cb) ->
    htmlUrl = @content.uri.replace(".json", ".html")
    $.get htmlUrl, (data) ->
      cb data if cb
    .fail (xhr, data, string) ->
      console.log data
      console.log string

  getCard: (cb) ->
    cardUrl = @content.uri.replace(".json", ".card")
    $.get cardUrl, (data) ->
      cb data if cb

  getJSON: () ->
    $.get @content.uri, (data) ->
      cb data if cb

  toJSON: () ->
    return @content

do () ->
  CM = new CM()
  CM.loadContent () ->
    $("title").text = "Welcome to My Site";
    for article in CM.content 
      do (article) =>
        article.getHtml (html) =>
          $(".content").append $(html)
          $(".nav").append $("<a href=\"#{article.content.link}\">#{article.content.content.title.content.text}</a>")
