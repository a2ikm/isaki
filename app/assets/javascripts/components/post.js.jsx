var Post = React.createClass({
  getInitialState: function() {
    return {
      description: this.props.post.description,
    };
  },

  changeDescription: function(e) {
    this.setState({
      description: this.refs.description.getDOMNode().value
    });
  },

  render: function() {
    var id   = "post_description";
    var name = "post[description]";

    return (
      <div className="form-group">
        <label className="control-label" htmlFor={id}>Description</label>
        <textarea ref="description" className="form-control" name={name} id={id} value={this.state.description} onChange={this.changeDescription} />
      </div>
    );
  }
});
