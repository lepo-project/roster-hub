Rails.application.routes.draw do
  use_doorkeeper
  root 'orgs#index'
  get 'api-docs', to: 'api_docs#index'
  scope 'ims' do
    scope 'oneroster' do
      namespace 'v1p1' do
        root 'orgs#index'
        resources 'academicSessions', param: :sourcedId, controller: 'academic_sessions', only: [:index, :show, :create, :update, :destroy]
        resources 'classes', param: :sourcedId, controller: 'rclasses', only: [:index, :show, :create, :update, :destroy]
        resources 'courses', param: :sourcedId, only: [:index, :show, :create, :update, :destroy]
        resources 'enrollments', param: :sourcedId, only: [:index, :show, :create, :update, :destroy]
        resources 'orgs', param: :sourcedId, only: [:index, :show, :create, :update, :destroy]
        resources 'users', param: :sourcedId, only: [:index, :show]
        get 'classes/:classSourcedId/students', to: 'users#students_for_class'
        get 'classes/:classSourcedId/teachers', to: 'users#teachers_for_class'
        get 'courses/:courseSourcedId/classes', to: 'rclasses#course'
        get 'schools(/:sourcedId)', to: 'orgs#schools'
        get 'schools/:schoolSourcedId/classes', to: 'rclasses#school'
        get 'schools/:schoolSourcedId/classes/:classSourcedId/enrollments', to: 'enrollments#class_in_school'
        get 'schools/:schoolSourcedId/classes/:classSourcedId/students', to: 'users#students_for_class_in_school'
        get 'schools/:schoolSourcedId/classes/:classSourcedId/teachers', to: 'users#teachers_for_class_in_school'
        get 'schools/:schoolSourcedId/courses', to: 'courses#school'
        get 'schools/:schoolSourcedId/enrollments', to: 'enrollments#school'
        get 'schools/:schoolSourcedId/students', to: 'users#students_for_school'
        get 'schools/:schoolSourcedId/teachers', to: 'users#teachers_for_school'
        get 'schools/:schoolSourcedId/terms', to: 'academic_sessions#school'
        get 'students(/:sourcedId)', to: 'users#students'
        get 'students/:userSourcedId/classes', to: 'rclasses#student'
        get 'teachers(/:sourcedId)', to: 'users#teachers'
        get 'teachers/:userSourcedId/classes', to: 'rclasses#teacher'
        get 'terms(/:sourcedId)', to: 'academic_sessions#term'
        get 'terms/:termSourcedId/classes', to: 'rclasses#term'
        get 'users/:userSourcedId/classes', to: 'rclasses#user'
      end
    end
  end
end
