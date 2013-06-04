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
  **/
reasonPlugins = function(selector, poo, type, win) {
  var self = this, panel, currentReasonPlugin;
  console.log("The call has been made.");
  console.log(selector,poo,type,win);

  self.panel = reasonPlugins.getPanel(selector);

  if (type === "image") {
    currentReasonPlugin = new reasonPlugins.reasonImage(selector);
    //TODO: caching here?
  }
  else if (type === "link")
    currentReasonPlugin = '';
}

  /**
   * jsonURL handles url and query string building for json requests.
   * For example, jsonURL(15, 6) should return a URL for the sixteenth
   * to the twenty-second items of the list.
   */
  reasonPlugins.jsonURL = function (offset, chunk_size) { 
    var self = this;
    if (self.type === "image")
      typeId = 243;
    else if (self.type === "link")
      typeId = "???";

    return '/reason/displayers/generate_json.php?site_id=240616&type_id=243&num=' + chunk_size + '&start=' + offset + '&';
  };

  /**
   * Gets a reference to tinyMCE's representation of the panel that holds the filePicker.
   * This code is pretty fragile, but could be improved to be more robust.
   * The fundamental consideration re: fragility is: "What is my containing element?" or,
   * more specifically, "Where do I want to put the ReasonPlugin controls?"
   **/
  reasonPlugins.getPanel = function (selector) {
    var itemID = selector.slice(0,-4), windowItems, filePickerField, panel;

    // TODO: We can keep going up until we find a parent of type panel to make this a little more robust.
    windowItems = tinymce.activeEditor.windowManager.windows[0].items()[0].find("*");
    filePickerField = windowItems.filter(function(item) {
        if (item._id === itemID)
          return item;
    });

    panel = filePickerField.parent().parent();
    return panel;
  };


  reasonPlugins.reasonImage = function(selector) {
    this.panel = reasonPlugins.getPanel(selector);
    this.json_url = reasonPlugins.jsonURL;

    this.hideMCEControls();
    this.insertReasonControls();
    this.linkControls();
  };


  reasonPlugins.reasonImage.prototype.linkControls = function() {};

  reasonPlugins.reasonImage.prototype.hideMCEControls = function() {
    this.panel.find("*").hide();
  }

  reasonPlugins.reasonImage.prototype.insertReasonControls = function() {
    var element = this.panel.getEl(); // TODO
    this.UI = element;
    // I'm sure that tinymce has templates, but for now...
    // Forgive me Father, for I have sinned: 
    this.UI.innerHTML += '<div> <form> <h1>Insert:</h1> <div class="tabset"> <div class="tabs_chunk"> <div class="force_clear_for_ie"></div> <ul> <li class="tab_chunk selected" id="listbox_tab"> <a>existing image</a></li> <li class="tab_chunk" id="custom_tab"><a>image at web address</a></li> </ul> </div> <div class="tabpanels_chunk"> <div class="tabpanel_chunk selected" id="listbox_tabpanel"> <div class="listbox" id="image_listbox"> <div class="filter_chunk"> <span class="label">Search:</span><input name= "filter_input_elem" size="20" /> </div> <div class="items_chunk"> <div class="force_clear_for_ie"></div> </div> </div> <div class="fieldset"> <div class="legend"> Image options </div> <div class="fieldset"> <div class="legend"> Size </div><span><input checked="checked" id= "listbox_tn_size_radio" type= "radio" value="tn" /><label for= "listbox_tn_size_radio">Thumbnail</label></span><span><input id="listbox_full_size_radio" type="radio" value= "full" /><label for= "listbox_full_size_radio">Full</label></span> </div> <div class="fieldset"> <div class="legend"> Alignment </div><span><input checked="checked" id= "listbox_align_none_radio" name="listbox_align" type="radio" value="none" /><label for= "listbox_align_none_radio">None</label></span><span><input id="listbox_align_left_radio" name="listbox_align" type="radio" value= "left" /><label for= "listbox_align_left_radio">Left</label></span><span><input id="listbox_align_right_radio" name="listbox_align" type="radio" value= "right" /><label for= "listbox_align_right_radio">Right</label></span> </div> <div class="clearer"></div> </div> </div> <div class="tabpanel_chunk" id="custom_tabpanel"> <div class="fieldset"> <div class="legend"></div> <table> <tbody> <tr> <td><label for= "custom_uri_input">Location:</label></td> <td><input id="custom_uri_input" size= "40" type="text" /></td> </tr> <tr> <td><label for= "custom_alt_input">Description:</label></td> <td><input id="custom_alt_input" size= "40" type="text" /></td> </tr> </tbody> </table> </div> <div class="fieldset"> <div class="legend"> Image options </div> <div class="fieldset"> <div class="legend"> Alignment </div><span><input checked="checked" id= "custom_align_none_radio" name="custom_align" type="radio" value="none" /><label for= "custom_align_none_radio">None</label></span><span><input id="custom_align_left_radio" name="custom_align" type="radio" value= "left" /><label for= "custom_align_left_radio">Left</label></span><span><input id="custom_align_right_radio" name="custom_align" type="radio" value= "right" /><label for= "custom_align_right_radio">Right</label></span> </div> <div class="clearer"></div> </div> </div> </div> </div> </form> <div class="submit_and_cancel_chunk"> <button class="ok" type="button">OK</button><button type= "button">Cancel</button> </div> </div> <div class="remove_chunk"> <button type="button">Remove image</button> </div>';
    this.imagesListBox = this.UI.getElementsByClassName('items_chunk')[0];
    this.render(element);
  }

  reasonPlugins.reasonImage.prototype.render = function (page) {
    // Render UI bits
    // Render each item
    page = !page ? 1 : page;
    this.page = page;
    this.fetch_images(page, function() {
      this.display_images(page);
      console.log(this.imagesListBox);
    });

  };
  reasonPlugins.reasonImage.prototype.display_images = function (page) {
    var imagesHTML = "";

    for (i in this.items[page]) {
      i = this.items[page][i];
      imagesHTML += i.display_item();
    }

    this.imagesListBox.innerHTML = imagesHTML;
    console.log(this.imagesListBox.innerHTML)
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
        for (i in json_objs) {
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
        "success_scope": this,
      });
  };

  reasonPlugins.reasonImage.prototype.debugDiv = function (content) {
    var newDiv = document.getElementById("debugDiv") || document.createElement("div");
    newDiv.appendChild(content);
    newDiv.id = "debugDiv";
    newDiv.style.position = 'absolute';
    newDiv.style.left = "45px";
    newDiv.style.background = "white";
    newDiv.style.paddingr = "40px";
    document.body.appendChild(newDiv);
    newDiv.style.top = window.scrollY + 20 + "px";
    document.onscroll = function(e) {
      newDiv.style.top = window.scrollY + 20 + "px";
    }
  }

  var ReasonImageDialogItem = function () {};
  ReasonImageDialogItem.prototype.escapeHtml = function (unsafe) {
    return unsafe
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
  }

  ReasonImageDialogItem.prototype.URLs = {
    thumbnail: '',
    full: ''
  };
  ReasonImageDialogItem.prototype.description = '';


  ReasonImageDialogItem.prototype.render_item = function () {
    size = 'thumbnail';
    description = this.escapeHtml(this.description);
    return '<img ' 
    + 'src="' + this.URLs[size] 
    + '" alt="' + description + '"></img>';
  }

  ReasonImageDialogItem.prototype.display_item = function () {
    return '<a class="image_item">' + this.render_item() + '<div class="description">' + this.escapeHtml(this.name) + '</div></a>';
  }


  reasonPlugins.reasonLink = function() {};




/**
 * plugin.js
 *
 * Copyright, Moxiecode Systems AB
 * Released under LGPL License.
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */
// UGH POO
/*global tinymce:true */

tinymce.PluginManager.add('reasonimage', function(editor, url) {
	function showDialog() {
		var win, data, dom = editor.dom, imgElm = editor.selection.getNode();
		var width, height;

		if (imgElm.nodeName == "IMG" && !imgElm.getAttribute('data-mce-object')) {
			data = {
				src: dom.getAttrib(imgElm, 'src'),
				alt: dom.getAttrib(imgElm, 'alt'),
			};
		} else {
			imgElm = null;
		}

    win = editor.windowManager.open({
        title: 'Add an image',
        minwidth: "700",
        body: [
          // Add from Reason
          {
          title: "from reason",
          type: "form",
          items: [
            tinymce.ui.Factory.create({type: 'textbox', label: 'monkey', name: "peee"}),
            tinymce.ui.Factory.create({type: 'filepicker', filetype: 'image', name: 'moo', label: 'poops'})],
            //tinymce.ui.Factory.create({type: 'radiogroup', name: 'moo', label: 'poops', title: 'yerp', items: [
                                      //{type: 'radio', text: 'Thumbnail', value: 'poooo', tooltip: "Image will display as a thumbnail"},
                                      //{type: 'radio', text: 'Full', value: 'poooo', tooltip: "Image will display at full size"},
            //]})],
          onchange: function(e) {console.log(!!e.target.value.control? e.target.value.control.value(): e.target.value)}
        },

          // Add from the Web
          {
          title: "from a URL",
          type: "form",
          items: [
            {
            name: 'href',
            type: 'filepicker',
            filetype: 'image',
            size: 40,
            autofocus: true,
            label: 'URL',
          },
          {name: 'text', type: 'textbox', size: 40, label: 'Text to display'},
          {name: 'size', type: 'listbox', label: "Size", values: [
            {text: 'Thumbnail', value: 'thumb'},
            {text: 'Full', value: 'full'}
          ]},
          // TODO: This isn't implemented in tinymce yet. When it is... !
          //{ title: "Size", type: "radiogroup", items: [
            //{type: 'radio', text: 'Thumbnail', value: 'poooo', tooltip: "Image will display as a thumbnail"},
            //{type: 'radio', text: 'Full', value: 'poooo', tooltip: "Image will display at full size"},
          //]}

          ]
        }

        ],
        bodyType: 'tabpanel',
        onSubmit: function(e) { 
          console.log(e);

          if (imgElm) {
            dom.setAttribs(imgElm, data);
          } else {
            editor.insertContent(dom.createHTML('img', data));
          }
        }
      });

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
