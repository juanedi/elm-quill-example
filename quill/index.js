var Inline = Quill.import('blots/inline');

class FooBlot extends Inline { }
FooBlot.blotName = 'foo';
FooBlot.tagName = 'strong';

Quill.register(FooBlot);

var quill = new Quill('.editor', {
  modules: {
    toolbar: ".editor-toolbar"
  }
});

var toolbar = quill.getModule('toolbar');

toolbar.addHandler('foo', function(value) {
  quill.format('foo', value);
});
