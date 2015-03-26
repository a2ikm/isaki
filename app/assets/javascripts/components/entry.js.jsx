var Entry = React.createClass({
  getInitialState: function() {
    return {
      path:     this.props.entry.path,
      content:  this.props.entry.content,
    }
  },

  changePath: function(e) {
    this.setState({
      path: this.refs.path.getDOMNode().value
    });
  },

  changeContent: function(e) {
    this.setState({
      content: this.refs.content.getDOMNode().value
    });
  },

  render: function() {
    var index = this.props.index;

    var pathId   = "post_form_entries_attributes_"  + index + "_path";
    var pathName = "post_form[entries_attributes][" + index + "][path]";

    var contentId   = "post_form_entries_attributes_"  + index + "_content";
    var contentName = "post_form[entries_attributes][" + index + "][content]";

    return (
      <div className="entry-form panel panel-default">
        <div className="panel-heading">
          <div className="panel-title">
            <input ref="path" className="form-control input-sm" type="text" name={pathName} id={pathId} value={this.state.path} onChange={this.changePath} placeholder="filename" />
          </div>
        </div>
        <div className="panel-body">
          <textarea ref="content" className="form-control" name={contentName} id={contentId} value={this.state.content} onChange={this.changeContent} rows="10" />
        </div>
      </div>
    );
  }
});

Entry.createBlank = function() {
  return {
    path: "",
    content: "",
  };
};
