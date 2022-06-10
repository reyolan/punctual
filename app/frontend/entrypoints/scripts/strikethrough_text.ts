function strikeThroughTextWhenChecked(): void {
  const checkBoxElements = document.querySelectorAll(
    "input[type=checkbox]"
  ) as NodeListOf<HTMLInputElement>;
  const checkedTasks = document.querySelectorAll(
    "[data-task-name]"
  ) as NodeListOf<HTMLElement>;

  if (!checkBoxElements.length) return;

  checkedTasks.forEach(checkedTask => {
    checkedTask.style.textDecoration = "line-through";
  });
}

document.addEventListener("turbolinks:load", strikeThroughTextWhenChecked);
