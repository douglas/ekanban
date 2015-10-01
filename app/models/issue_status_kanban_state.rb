class IssueStatusKanbanState < ActiveRecord::Base
  unloadable

belongs_to :kanban_state
belongs_to :issue_status

  def self.state_id(issue_status_id,tracker_id)
    #rec = IssueStatusKanbanState.joins(:"#{IssueStatusKanbanState.table_name}",:"#{KanbanState.table_name}").where("#{KanbanState.table_name}.tracker_id=? and issue_status_id = ?", tracker_id, issue_status_id)
    rec = IssueStatusKanbanState.where("#{KanbanState.table_name}.tracker_id=? and issue_status_id = ?", tracker_id, issue_status_id).includes(:kanban_state).references(:kanban_state)
    return rec.first.kanban_state_id if !rec.first.nil?
  end

  def self.status_id(kanban_state_id)
  	rec = IssueStatusKanbanState.where('kanban_state_id=?', kanban_state_id)
  	return rec.first.issue_status_id if !rec.first.nil?
  end
end
