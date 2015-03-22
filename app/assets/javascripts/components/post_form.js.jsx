var PostForm = React.createClass({
  getInitialState: function() {
    return {
      post:    JSON.parse(this.props.post),
      entries: JSON.parse(this.props.entries),
    }
  },

  addEntry: function(e) {
    var entries = this.state.entries;
    entries.push(Entry.createBlank());

    this.setState({
      entries: entries
    });
  },

  render: function() {
    return (
      <div>
        <Post post={this.state.post} />
        <EntryList entries={this.state.entries} />
        <div className="pull-left">
          <input type="button" value="Add file" onClick={this.addEntry} className="btn btn-default" />
        </div>
        <div className="pull-right">
          <input type="submit" value="Submit" className="btn btn-primary" />
        </div>
      </div>
    );
  }
});
