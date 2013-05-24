/**
 * plugin.js
 *
 * Copyright, Moxiecode Systems AB
 * Released under LGPL License.
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

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
