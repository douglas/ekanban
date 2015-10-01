# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do
	resources :projects do
		resources  :kanbans do
			resources :kanban_panes
			resources :kanban_workflow
		end
	end
	resource :kanban_card

	resources :trackers do
		resources :kanban_states
	end

	resources :kanban_stages

        get 'kanban_apis/kanban_card_journals', :controller => 'kanban_apis', :action => 'kanban_card_journals'
        get 'kanban_apis/kanban_state_issue_status', :controller => 'kanban_apis', :action => 'kanban_state_issue_status'
        get 'kanban_apis/kanban_workflow', :controller => 'kanban_apis', :action => 'kanban_workflow'
        get 'kanban_apis/kanban_states', :controller => 'kanban_apis', :action => 'kanban_states'
        put 'kanban_apis/close_issues', :controller => 'kanban_apis', :action => 'close_issues'
        get 'project/:project_id/kanbans', :controller => 'kanbans', :action => 'index'
        get 'kanban_apis/user_wip_and_limit', :controller => 'kanban_apis', :action => 'user_wip_and_limit'
        get 'kanbans/setup', :controller => 'kanbans', :action => 'setup'
        get 'kanban_states/setup', :controller=>'kanban_states', :action => 'setup'
        put 'issue_status_kanban_states/update', :controller => 'issue_status_kanban_states', :action => "update"
        put 'kanbans/copy', :controller => 'kanbans', :action => "copy"
        get 'kanban_reports/index', :controller => 'kanban_reports', :action => "index"
        get 'kanban_apis/issue_card_detail', :controller => 'kanban_apis', :action => 'issue_card_detail'
end
