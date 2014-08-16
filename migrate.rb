require 'rubygems'
require 'bundler/setup'
require 'octokit'
require 'logan'
require 'dotenv'
Dotenv.load

Octokit.configure do |c|
  c.login = ENV['GITHUB_LOGIN']
  c.password = ENV['GITHUB_PASSWORD']
end

REPO = ENV['GITHUB_REPO']

basecamp = Logan::Client.new(ENV['BASECAMP_ID'], {:username => ENV['BASECAMP_USERNAME'], :password => ENV['BASECAMP_PASSWORD']}, "Migration")
basecamp_project = basecamp.projects.find { |p| puts p.inspect; p.id == ENV['BASECAMP_PROJECT_ID'].to_i }

basecamp_project.todolists.each do |list|

  list_name = list.name
  list.remaining_todos.each do |todo|
    basecamp_url = "https://basecamp.com/#{ENV['BASECAMP_ID']}/projects/#{ENV['BASECAMP_PROJECT_ID']}/todos/#{todo.id}"
    issue = Octokit.create_issue(REPO, todo.content, "Imported from Basecamp: #{basecamp_url}", :labels => "#{list_name},todo")

    todo.comments.each do |comment|
      Octokit.add_comment(REPO, issue.number, comment.content)
    end
  end

end
