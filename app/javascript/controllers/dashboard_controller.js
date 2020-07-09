import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['note', 'gridView', 'rowView'];

  displayGrid() {
    this.gridViewTarget.classList.add('dashboard__view--active');
    this.rowViewTarget.classList.remove('dashboard__view--active');

    this.noteTargets.forEach(target => {
      const { fullBody, truncatedBody } = this.setBodyOptions(target);

      target.classList.add(
        'col-lg-3', 'col-md-6', 'offset-lg-0', 'offset-md-0'
      );

      this.updateBody(target, truncatedBody, fullBody);
    })
  }

  displayRow() {
    this.gridViewTarget.classList.remove('dashboard__view--active');
    this.rowViewTarget.classList.add('dashboard__view--active');

    this.noteTargets.forEach(target => {
      const { fullBody, truncatedBody } = this.setBodyOptions(target);

      target.classList.remove(
        'col-lg-3', 'col-md-6', 'offset-lg-0', 'offset-md-0'
      );

      this.updateBody(target, fullBody, truncatedBody);
    })
  }

  updateBody(target, bodyToShow, bodyToHide) {
    if (target.contains(bodyToShow)) {
      bodyToShow.classList.remove('d-none');
      bodyToHide.classList.add('d-none');
    }
  }

  setBodyOptions(target) {
    const fullBody = target.querySelector('[data-body="full"]');
    const truncatedBody = target.querySelector('[data-body="truncated"]');

    return { fullBody, truncatedBody };
  }
}
