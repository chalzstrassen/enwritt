Enwritt.Collections.Books = Backbone.Collection.extend({
  url: "/api/books",
  model: Enwritt.Models.Book,
  parse: function (resp) {
    this._page = resp._page;
    this._totalPages = resp._totalPages;
    delete resp._page;
    delete resp._totalPages;
    return resp.paginated;
  },
  getOrFetch: function (id) {
    var book = this.model.get(id)
    if (book) {
      book.fetch();
    } else {
      book = new Enwritt.Models.Book({id: id});
      book.fetch();
    }

    return book;
  }

});
