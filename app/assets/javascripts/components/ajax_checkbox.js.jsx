var AjaxCheckbox = React.createClass({
  getInitialState: function() {
    return {state: "default", checked: this.props.checked}
  },

  success: function() {
    this.setState({state: "default", checked: !this.state.checked});
  },

  error: function(data) {
    console.error("ERROR DURING AJAX: " + data.responseText);
    this.setState({state: "error"});
  },

  handleClick: function() {
    if($(ReactDOM.findDOMNode(this.refs.checkbox)).is(":checked")) {
      createReview(this.props.reviewer_id, this.props.reviewee_id,this.success, this.error);
    } else {
      let answer = confirm("This will destroy " + this.props.label + "'s review (if any), continue?");

      if (answer === true) {
        destroyReview(this.props.reviewer_id, this.props.reviewee_id, this.success, this.error);
      } else {
        return true;
      }
    }
    this.setState({state: "loading"});
  },

  render: function() {
    if(this.state.state == "error") {
      return ( <span>!</span> );
    }

    if(this.state.state == "loading") {
      return ( <img src="/small_spinner.gif" /> );
    }

    return (
      <div className="label-combo">
        <input type="checkbox" ref="checkbox" onChange={this.handleClick} checked={this.state.checked}></input>
        <label>{this.props.label}</label>
      </div>
    )
  }
});
