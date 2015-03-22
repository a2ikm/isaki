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

    var pathId   = "post_entries_attributes_"  + index + "_path";
    var pathName = "post[entries_attributes][" + index + "][path]";

    var contentId   = "post_entries_attributes_"  + index + "_content";
    var contentName = "post[entries_attributes][" + index + "][content]";

    return (
      <div className="entry">
        <div className="form-group">
          <label className="control-label" htmlFor={pathId}>Path</label>
          <input ref="path" className="form-control" type="text" name={pathName} id={pathId} value={this.state.path} onChange={this.changePath} />
        </div>
        <div className="form-group">
          <label className="control-label" htmlFor={contentId}>Content</label>
          <textarea path="content" className="form-control" name={contentName} id={contentId} value={this.state.content} onChange={this.changeContent} />
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
