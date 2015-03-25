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
    if($(this.refs.checkbox.getDOMNode()).is(":checked")) {
      createReview(this.props.reviewer_id, this.props.reviewee_id,this.success, this.error);
    } else {
      destroyReview(this.props.reviewer_id, this.props.reviewee_id, this.success, this.error);
    }
    this.setState({state: "loading"});
  },

  render: function() {
    if(this.state.state == "error") {
      return ( <span>!</span> );
    }

    if(this.state.state == "loading") {
      return ( <img src="/assets/small_spinner.gif" /> );
    }

    return (
      <div className="label-combo">
        <input type="checkbox" ref="checkbox" onChange={this.handleClick} checked={this.state.checked}></input>
        <label>{this.props.label}</label>
      </div>
    )
  }
});
