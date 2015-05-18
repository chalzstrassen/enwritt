Enwritt.Views.CollFormView = Backbone.ModalView.extend({
  template: JST['collections/form'],
  events: {
    "click .collection-button": "syncCollection",
    "click .collection-delete": "destroyCollection",
    "click .back": "backToShow"
  },
  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },
  render: function () {
    var content = this.template({collection: this.model});
    this.$el.html(content);

    return this;
  },

  syncCollection: function (event) {
    event.preventDefault();

    var formData = $('#collection-form').serializeJSON();
    this.model.set(formData);
    var that = this;
    this.model.save({},{
      success: function () {
        that.collection.add(that.model);
        that.hideModal();
      }
    });
  },

  destroyCollection: function (event) {
    event.preventDefault();

    this.hideModal();
    this.model.destroy();
  },

  backToShow: function (event) {
    event.preventDefault();

    var showView = new Enwritt.Views.CollectionShow({
      model: this.model,
      collection: this.collection
    });

    this.hideModal();
    showView.render().showModal({
      closeImageUrl: "//:0",
      closeImageHoverUrl: "//:0"
    });
  }
});