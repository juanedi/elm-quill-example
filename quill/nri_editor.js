var Inline = Quill.import('blots/inline');

class FooBlot extends Inline { }
FooBlot.blotName = 'foo';
FooBlot.tagName = 'strong';

Quill.register(FooBlot);

class NriEditor extends HTMLElement {
  constructor() {
    super();
  }

  connectedCallback() {
    // TODO: add and register toolbar items depending on element properties
    // TODO: figure out if we should use HTML imports

    this.innerHTML = `
      <style>
        .nri-editor {
          display: flex;
        }

        .editor {
          flex: 1;
          border: 1px solid #CCCCCC;
          border-radius: 5px;
          font-family: Times New Roman;
          font-size: 20px;
        }

        .editor-toolbar {
          display: flex;
          flex-direction: column;
          padding: 0 10px;
        }

        .editor-toolbar button {
          width: 30px;
          height: 30px;
          margin-bottom: 10px;
          background: #F5F5F5;
          border: none;
          border-radius: 6px;
          font-size: 14px;
        }

        .editor-toolbar button.ql-active {
          color: #2C6BF6;
        }
      </style>

      <div class="nri-editor" style="width: 800px; height: 700px">
        <div class="editor"></div>
          <div class="editor-toolbar">
            <button class="ql-bold">B</button>
            <button class="ql-italic">I</button>
            <button class="ql-foo">F</button>
          </div>
      </div>
    `;

    var quillNode = this.getElementsByClassName("editor")[0]

    var quill = new Quill(quillNode, {
      modules: {
        toolbar: ".editor-toolbar"
      }
    });

    var toolbar = quill.getModule('toolbar');

    toolbar.addHandler('foo', function(value) {
      quill.format('foo', value);
    });
  }
}

window.customElements.define('nri-editor', NriEditor)
