function createReview(reviewer_id, reviewee_id, success, error) {
  $.ajax({dataType: "json",
          success: success,
          error: error,
          method: "POST",
          url: ("/reviews?reviewer_id=" + reviewer_id + "&" + "reviewee_id=" + reviewee_id)})
}

function destroyReview(reviewer_id, reviewee_id, success, error) {
  $.ajax({dataType: "json",
          success: success,
          error: error,
          method: "DELETE",
          url: ("/reviews?reviewer_id=" + reviewer_id + "&" + "reviewee_id=" + reviewee_id)})
}
