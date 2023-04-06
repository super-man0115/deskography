import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  static targets = ['comment', 'editBox', 'errorMessage'];

  switchToLabel() {
    this.editBoxTarget.style.display = 'none';
    this.commentTarget.style.display = 'block';
  }

  switchToEdit(event) {
    event.preventDefault();
    this.commentTarget.style.display = 'none';
    this.editBoxTarget.style.display = 'block';
  }

  showErrorMessages(messages) {
    const errorElement = document.createElement('p');
    errorElement.classList.add('error_messages', 'text-danger');
    errorElement.innerHTML = messages.join('<br>');
    this.errorMessageTarget.insertAdjacentElement('beforebegin', errorElement);
  }

  clearErrorMessages() {
    this.errorMessageTargets.forEach((element) => element.remove());
  }

  submitComment(event) {
    event.preventDefault();
    this.clearErrorMessages();

    const body = this.editBoxTarget.querySelector('textarea').value;
    const commentId = this.data.get('id');

    fetch(`/comments/${commentId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify({
        comment: { body },
      }),
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        } else {
          throw response;
        }
      })
      .then((result) => {
        this.commentTarget.innerHTML = result.comment.body.replace(
          /\r?\n/g,
          '<br>'
        );
        this.switchToLabel();
      })
      .catch(async (response) => {
        const result = await response.json();
        const messages = result.errors.messages;
        this.showErrorMessages(messages);
      });
  }
}
