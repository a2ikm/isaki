var Post = React.createClass({
  getInitialState: function() {
    return {
      description: this.props.description,
    };
  },

  changeDescription: function(e) {
    this.setState({
      description: this.refs.description.getDOMNode().value
    });
  },

  render: function() {
    var id   = "post_form_description";
    var name = "post_form[description]";

    return (
      <div className="form-group">
        <textarea ref="description" className="post-form-description form-control" name={name} id={id} value={this.state.description} onChange={this.changeDescription} placeholder="description" />
      </div>
    );
  }
});
