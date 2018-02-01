let Inline = Quill.import('blots/inline');

class FooBlot extends Inline { }
FooBlot.blotName = 'foo';
FooBlot.tagName = 'strong';

Quill.register(FooBlot);

class NriEditor extends HTMLElement {
  constructor() {
    super();
    // TODO: clean this up.
    // the value is initialized before connectedCallback is called, so we need to store it before quill is initialized
    this._value = null;
    this._quill = null;
  }

  connectedCallback() {
    // TODO: figure out if we should use HTML imports
    // TODO: render toolbar controls based on attributes
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

      <div class="nri-editor">
        <div class="editor"></div>
          <div class="editor-toolbar">
            <button class="ql-bold">B</button>
            <button class="ql-italic">I</button>
            <button class="ql-foo">F</button>
          </div>
      </div>
    `;

    let quillNode = this.getElementsByClassName("editor")[0]

    this._quill = new Quill(quillNode, {
      // whitelist available formats to prevent arbitrary content from being pasted
      formats: [
        'bold',
        'italic',
        'foo'
      ],
      modules: {
        toolbar: {
          container: ".editor-toolbar",
          handlers: {
            // TODO: add and register toolbar items depending on element properties
            "foo": (value) => { this._quill.format('foo', value) }
          }
        }
      }
    });

    const runDispatch = () => {
      const event = new Event('change')
      this.dispatchEvent(event)
    }

    this._quill.on('text-change', runDispatch);
    this._quill.setContents(this._value);
  }

  get value() {
    if (this._quill) {
      return {
        text: this._quill.getText(),
        document: this._quill.getContents()
      };
    }
  }

  set value(value) {
    this._value = value;
  }

  get quill() {
    return this._quill;
  }
}

window.customElements.define('nri-editor', NriEditor)
