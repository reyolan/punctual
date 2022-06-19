module ApplicationHelper
  def full_title(title = '')
    base_title = 'Punctual'
    title.empty? ? base_title : "#{title} | #{base_title}"
  end

  def get_email_username(email)
    email.split('@')[0]
  end

  def format_auxiliary_verb(count)
    count == 1 ? 'is' : 'are'
  end

  def rephrase_deadline(date)
    if date == Date.current
      'Today'
    elsif date == Date.tomorrow
      'Tomorrow'
    elsif date.is_a?(Date)
      date
    else
      '---'
    end
  end

  def turn_to_red(date, completed)
    return 'bg-slate-300' if date.blank?

    date < Date.current && !completed ? 'bg-red-400' : 'bg-slate-300'
  end

  def conditional_destroy_completed_path(category)
    category ? destroy_all_completed_category_tasks_path(category) : destroy_all_completed_tasks_path
  end
end
