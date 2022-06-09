function disableDateBeforeToday() {
  const dateInput = document.querySelector(
    "#task_deadline"
  ) as HTMLInputElement;

  if (!dateInput) return;

  const date = new Date().toISOString().split("T")[0];
  dateInput.setAttribute("min", date);
}

document.addEventListener("turbolinks:load", disableDateBeforeToday);
