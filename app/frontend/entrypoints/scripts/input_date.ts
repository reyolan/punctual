function disableDateBeforeToday(): void {
  const dateInput: HTMLInputElement | null =
    document.querySelector("#task_deadline");

  if (!dateInput) return;

  // ISO Format with timezone offset
  const date: string = new Date()
    .toLocaleString("sv", { timeZoneName: "short" })
    .split(" ")[0];

  dateInput.setAttribute("min", date);
}

document.addEventListener("turbolinks:load", disableDateBeforeToday);
