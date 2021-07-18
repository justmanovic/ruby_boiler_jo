def check_if_user_gave_input
    abort("Un petit nom pour ton app, quand même !") if ARGV.empty?
end

def get_repo_github
    return ARGV[1]
end

def get_project_name
    return ARGV[0]
end

def create_project_folder
    project_name = get_project_name
    Dir.mkdir(project_name)
end

def github
    system('git init')
    system('git add .')
    system('git commit -m "début du projet"')
    system('git branch -M main')
    if get_repo_github
        system('git remote add origin git@github.com:justmanovic/'+get_project_name+'.git')
        system('git push -u origin main')
    end
end

def create_structure
    project_name = get_project_name
    app_name = project_name + ".rb"
    spec_name = project_name + "_spec.rb"
    Dir.chdir project_name
    Dir.mkdir("lib")
    Dir.mkdir("spec")
    Dir.chdir("lib")
    app_file = File.open(app_name,"w")
    app_file.puts("require 'rubocop'\nrequire 'rspec'\nrequire 'pry'\nrequire 'open-uri'")
    app_file.close
    Dir.chdir("..")
    Dir.chdir("spec")
    spec_file = File.open(spec_name,"w")
    spec_file.puts("structure des tests...")
    spec_file.close
    Dir.chdir("..")
    gemfile_file = File.open("Gemfile","w")
    gemfile_file.puts("source 'https://rubygems.org'\nruby '2.7.1'\ngem 'rubocop'\ngem 'rspec'\ngem 'pry'\ngem 'open-uri'")
    gemfile_file.close
    env_file = File.open(".env","w")
    env_file.close
    gitignore_file = File.open(".gitignore","w")
    gitignore_file.puts(".env")
    system("bundle install")
    readme = File.open("README.md","w")
    readme.puts("Bienvenue sur le projet "+project_name+" !")
end

def perform
    check_if_user_gave_input
    create_project_folder
    create_structure
    github
end

perform