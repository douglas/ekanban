class IssueStatusKanbanStatesController < ApplicationController
	def update
		puts params
                states = KanbanState.where(:tracker_id => params[:tracker_id]).all
		old_maps = {}
		states.map do |state|
			old_maps[state.id.to_s] = state.issue_status_kanban_state.map {|m| m.issue_status_id.to_s} if state.issue_status_kanban_state
		end
		new_maps = params[:maps]
		# diff = new_maps.diff(old_maps)
                # Hash diff was deprecated in rails 4.0.2
                ## File activesupport/lib/active_support/core_ext/hash/diff.rb, line 8
                #  def diff(other)
                #    ActiveSupport::Deprecation.warn "Hash#diff is no longer used inside of Rails, and is being deprecated with no replacement. If you're using it to compare hashes for the purpose of testing, please use MiniTest's assert_equal instead."
                #    dup.
                #      delete_if { |k, v| other[k] == v }.
                #      merge!(other.dup.delete_if { |k, v| has_key?(k) })
                #  end
                diff = new_maps.dup.delete_if { |k, v| old_maps[k] == v }.merge!(old_maps.dup.delete_if { |k, v| new_maps.has_key?(k) })
		diff.each do |k,v|
			removeds = (old_maps[k] || []) - (new_maps[k] || [])
			addeds = (new_maps[k] || [])- (old_maps[k] || [])
			puts removeds
			puts addeds

			removeds.each do |r|
				rec = IssueStatusKanbanState.find_by_issue_status_id_and_kanban_state_id(r,k)
				rec.delete if rec
			end

			addeds.each do |a|
				rec = IssueStatusKanbanState.new
				rec.kanban_state_id = k.to_i
				rec.issue_status_id = a.to_i
				rec.save
			end
 	  	end
	  	redirect_to :controller => "kanban_states", :action => "setup", :tab => 'Maps'
	end
end