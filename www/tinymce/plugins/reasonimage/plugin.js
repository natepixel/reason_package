/**
 * ReasonImage and ReasonLink plugins
 *
 * These plugins integrate tinyMCE into the Reason CMS.
 * ReasonImage allows a user to insert an image that belongs
 * to a Reason Site
 */

/*global tinymce:true */


 /**
  * ReasonPlugins is a container and dispatch for ReasonImage and ReasonLink.
  *
  * It has some basic configuration, and then rest is done in the constituent
  * functions.
  *
  * Executes the correct plugin for the given filebrowser field type.
  * TODO: json_generator should take the unique name of the type, not the type ID.
  * TODO: We need to account for having multiple editors per page. I think that maybe
  *       we should cache a reference to the current editor's plugin and check if activeEditor
  *       is the same as the last time reasonPlugins was called?
  *
  * @param String linkSelector The item to which the the picker will be bound
  * @param String targetPanelSelector The item to which the the picker will be bound
  * @param String type 'image' or 'link'; determines which plugin to use
  **/
reasonPlugins = function(linkSelector, targetPanelSelector, type) {
  var currentReasonPlugin;

  if (type === "image") {
    currentReasonPlugin = new reasonPlugins.reasonImage(linkSelector, targetPanelSelector);
    //TODO: caching here?
  }
  else if (type === "link")
    currentReasonPlugin = '';
};

  /**
   * jsonURL handles url and query string building for json requests.
   * For example, jsonURL(15, 6) should return a URL for the sixteenth
   * to the twenty-second items of the list.
   */
  reasonPlugins.jsonURL = function (offset, chunk_size) {
    var self = this;
    var site_id = tinymce.activeEditor.settings.reason_site_id;
    if (self.type === "image")
      typeId = 243;
    else if (self.type === "link")
      typeId = "???";

    return '/reason/displayers/generate_json.php?site_id=' + site_id + '&type_id=243&num=' + chunk_size + '&start=' + offset + '&';
  };

  reasonPlugins.getControl = function (selector) {
    return tinymce.activeEditor.windowManager.windows[0].find('#'+selector)[0];
  }

  /**
   * Gets a reference to tinyMCE's representation of the panel that holds the filePicker.
   * This code is pretty fragile, but could be improved to be more robust.
   * The fundamental consideration re: fragility is: "What is my containing element?" or,
   * more specifically, "Where do I want to put the ReasonPlugin controls?"
   * @param string selector the selector for the file browser control
   **/
  reasonPlugins.getPanel = function (inputControl) {
    // TODO: We can keep going up until we find a parent of type panel to make this a little more robust.
    return inputControl.parent().parent();
  };


  /** 
   * Dispatch function. Gets a reference to the panel, and does everything we
   * need to do in order to get the plugin up and running.
   */
  reasonPlugins.reasonImage = function(linkSelector, placeholderSelector) {
    this.chunk_size = 4;
    this.inputControl = reasonPlugins.getControl(linkSelector);
    this.targetPanel = reasonPlugins.getControl(placeholderSelector);
    this.json_url = reasonPlugins.jsonURL;
    this.items = [];

    this.insertReasonUI();
    this.bindReasonUI();
    this.renderReasonImages();
  };



  /**
   * Prepends the reason controls to the tinyMCE panel.
   **/
  reasonPlugins.reasonImage.prototype.insertReasonUI = function() {
    var holderDiv;
    this.UI = this.targetPanel.getEl();

    // I should probably be using documentFragments here. Eh.
    holderDiv = document.createElement("div");
    holderDiv.innerHTML = '<div class="reasonImage"><button class="mce-btn prevImagePage" type="button">Previous</button><button class="mce-btn nextImagePage">Next</button><div class="items_chunk"> </div></div>';

    this.UI.insertBefore(holderDiv.firstChild, this.UI.firstChild);

  };

  /**
   * Binds various controls like cancel, next page, and search to their 
   * corresponding functions. Genius.
   **/
  reasonPlugins.reasonImage.prototype.bindReasonUI = function() {
    var self = this;

    this.reasonImageControls = this.UI.getElementsByClassName('reasonImage')[0];
    this.imagesListBox = this.UI.getElementsByClassName('items_chunk')[0];
    this.CancelButton = this.UI.getElementsByClassName('cancelReasonImage')[0];
    this.prevButton = this.UI.getElementsByClassName('prevImagePage')[0];
    this.nextButton = this.UI.getElementsByClassName('nextImagePage')[0];
    // More button bindings go here:
    // this.SearchBox = this.UI.getElementsByClassName('searchBox')[0];

    // Maybe I should move these bindings elsewhere for better coherence?
    tinymce.DOM.bind(this.imagesListBox, 'click', function(e) {
      var target = e.target || window.event.srcElement;
      if (target.nodeName == 'IMG' || target.nodeName == 'div') {
        self.selectImage(target);
      }
    });

    tinymce.DOM.bind(this.prevButton, 'click', function(e) {
      self.renderReasonImages(self.page - 1 || 1);
    });

    tinymce.DOM.bind(this.nextButton, 'click', function(e) {
      self.renderReasonImages(self.page + 1);
    });
  };

  /**
   * Links reason controls (selecting an image, writing alt text) to hidden
   * tinyMCE elements.
   * TODO: add alt tag things.
   */
  reasonPlugins.reasonImage.prototype.selectImage = function (imageNode) {
    this.inputControl.value(imageNode.src);
  };


  // TODO: Right now you can click past the last page and some weirdness happens.
  reasonPlugins.reasonImage.prototype.renderReasonImages = function (page) {
    // Render UI bits
    // Render each item
    page = !page ? 1 : page;
    this.page = page;
    this.fetch_images(page, function() {
      this.display_images(page);
    });

  };

  reasonPlugins.reasonImage.prototype.display_images = function (page) {
    var imagesHTML = "";

    for (var i in this.items[page]) {
      i = this.items[page][i];
      imagesHTML += i.display_item();
    }

    this.imagesListBox.innerHTML = imagesHTML;
  };

  reasonPlugins.reasonImage.prototype.fetch_images = function (page, callback) {
    // If cached...
    if (this.items && typeof this.items[page] !== 'undefined') {
      callback.call(this);
      return;
    }

    if (!this.json_url)
      throw "You need to set a URL for the dialog to fetch JSON from.";

    var offset = ((page - 1) * this.chunk_size);

    if (typeof this.json_url === 'function')
      {
        var url = this.json_url(offset, this.chunk_size);
      } else
        var url = this.json_url;

      var parse_images = function(response) {
        var json_objs = JSON.parse(response);
        var items_to_add = [];
        for (var i in json_objs) {
          item = new ReasonImageDialogItem();
          item.name = json_objs[i].name;
          item.id = json_objs[i].id;
          item.description = json_objs[i].description;
          item.pubDate = json_objs[i].pubDate;
          item.URLs = {'thumbnail': json_objs[i].thumbnail, 'full': json_objs[i].link};
          items_to_add.push(item);
        }
        this.items[page] = items_to_add;
        callback.call(this);
      };

      tinymce.util.XHR.send({
        "url": url,
        "success": parse_images,
        "success_scope": this
      });
  };


  var ReasonImageDialogItem = function () {};
  ReasonImageDialogItem.prototype.escapeHtml = function (unsafe) {
    return unsafe
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
  };

  ReasonImageDialogItem.prototype.URLs = {
    thumbnail: '',
    full: ''
  };
  ReasonImageDialogItem.prototype.description = '';


  ReasonImageDialogItem.prototype.render_item = function () {
    size = 'thumbnail';
    description = this.escapeHtml(this.description);
    return '<img ' +
      'src="' + this.URLs[size] +
      '" alt="' + description + '"></img>';
  };

  ReasonImageDialogItem.prototype.display_item = function () {
    return '<a id="reasonimage_' + this.id + '" class="image_item">' + this.render_item() + '<span class="description">' + this.escapeHtml(this.name) + '</span></a>';
  };


  reasonPlugins.reasonLink = function() {};



/**
 * This is the actual tinyMCE plugin. 
 */



tinymce.PluginManager.add('reasonimage', function(editor, url) {

	function showDialog() {
                var old_file_browser_callback = editor.settings.file_browser_callback;
                editor.settings.file_browser_callback = reasonPlugins;
		var win, data, dom = editor.dom, imgElm = editor.selection.getNode();
		var width, height;

		if (imgElm.nodeName == "IMG" && !imgElm.getAttribute('data-mce-object')) {
			data = {
				src: dom.getAttrib(imgElm, 'src'),
				alt: dom.getAttrib(imgElm, 'alt')
			};
		} else {
			imgElm = null;
		}

    win = editor.windowManager.open({
        title: 'Add an image',
        body: [
          // Add from Reason
          {
          title: "from reason",
          name: "reasonImagePanel",
          type: "form",
          //layout: "flex",
          minWidth: "700",
          minHeight: "500",
          items: [
            {name: 'text', type: 'textbox', size: 40, label: 'Text to display'},
            {name: 'size', type: 'listbox', label: "Size", values: [
              {text: 'Thumbnail', value: 'thumb'},
              {text: 'Full', value: 'full'}
            ]}
          ],
          // You can also pass a function and have it executed, but you need to change
          // the type to "panel," I believe. 
          // html: somefunction,
          onchange: function(e) {console.log(!!e.target? e.target.value: e);}
        },

          // Add from the Web
          {
          title: "from a URL",
          type: "form",
          items: [
            {
            name: 'src',
            type: 'textbox',
            filetype: 'image',
            size: 40,
            autofocus: true,
            label: 'URL'
          },
          {name: 'text', type: 'textbox', size: 40, label: 'Text to display'},
          {name: 'size', type: 'listbox', label: "Size", values: [
            {text: 'Thumbnail', value: 'thumb'},
            {text: 'Full', value: 'full'}
          ]}
          // TODO: This isn't implemented in tinymce yet. When it is... !
          //{ title: "Size", type: "radiogroup", items: [
            //{type: 'radio', text: 'Thumbnail', value: 'poooo', tooltip: "Image will display as a thumbnail"},
            //{type: 'radio', text: 'Full', value: 'poooo', tooltip: "Image will display at full size"},
          //]}

          ]
        }

        ],
        bodyType: 'tabpanel',
        onPostRender: function(e) {
          control_to_bind = 'src';
          target_panel = 'reasonImagePanel';
          reasonPlugins(control_to_bind, target_panel,  'image', e);
        },
        onSubmit: function(e) {
          var data = win.toJSON();

          if (imgElm) {
            dom.setAttribs(imgElm, data);
          } else {
            editor.insertContent(dom.createHTML('img', data));
          }
        }
      });
        editor.settings.file_browser_callback = old_file_browser_callback;
	}

	editor.addButton('reasonimage', {
		icon: 'image',
		tooltip: 'Insert/edit image',
		onclick: showDialog,
		stateSelector: 'img:not([data-mce-object])'
	});

	editor.addMenuItem('reasonimage', {
		icon: 'image',
		text: 'Insert image',
		onclick: showDialog,
		context: 'insert',
		prependToContext: true
	});
});
