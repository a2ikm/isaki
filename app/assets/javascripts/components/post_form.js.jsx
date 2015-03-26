var PostForm = React.createClass({
  getInitialState: function() {
    return JSON.parse(this.props.post_form)
  },

  addEntry: function(e) {
    var entries = this.state.entries;
    entries.push(Entry.createBlank());

    this.setState({
      entries: entries
    });
  },

  getSubmitLabel: function() {
    if (this.state.new_record) {
      return "Create";
    } else {
      return "Update";
    }
  },

  render: function() {
    return (
      <div>
        <Post description={this.state.description} />
        <EntryList entries={this.state.entries} />
        <div className="pull-left">
          <input type="button" value="Add file" onClick={this.addEntry} className="btn btn-default" />
        </div>
        <div className="pull-right">
          <input type="submit" value={this.getSubmitLabel()} className="btn btn-primary" />
        </div>
      </div>
    );
  }
});
