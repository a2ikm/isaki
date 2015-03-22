var EntryList = React.createClass({
  getInitialState: function() {
    return {
      entries: this.props.entries,
    };
  },

  render: function() {
    var len = this.state.entries.length;
    var nodes = [];
    for (var i = 0; i < len; i++) {
      var entry = this.state.entries[i];
      nodes.push(
        <Entry entry={entry} index={i} key={i} />
      );
    }

    return (
      <div className="entryList">
        {nodes}
      </div>
    );
  }
});
