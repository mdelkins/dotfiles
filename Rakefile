require 'rake'

FILES_TO_EXCLUDE = %w[Rakefile README LICENSE id_dsa.pub oh-my-zsh]

desc "install the dot files into user's home directory"
task :install do
  @replace_all = false
  files = Dir['*'].select { |file| !FILES_TO_EXCLUDE.include? file }

  install_public_keys
  install_oh_my_zsh
  install_pathegon
  install_vundle

  act_on_these files do |action, file|

    if action == 'a'
      replace_all
      replace file
      next
    end

    if action == 'y'
      replace file
      next
    end

    puts "skipping ~/.#{file}"
  end
end

def act_on_these(files)
  files.each do |file|
    unless File.exists? File.join(ENV['HOME'], ".#{file}")
      link_this file
      next
    end

    if replace?
      replace file
      next
    end

    print "overwrite ~/.#{file}? [ynaq] "
    action = $stdin.gets.chomp

    exit if action == 'q'
    yield(action, file) if block_given?
  end
end

def link_this(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def replace(file)
  system %Q{rm "$HOME/.#{file}"}
  link_this file
end

def replace_all(value=nil)
  value ||= true
  @replace_all = value
end

def replace?
  @replace_all
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def install_oh_my_zsh
  unless File.exist? File.join(ENV['HOME'], '.oh-my-zsh')
    puts "installing oh-my-zsh"
    system %Q{$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)}
  end

  puts "installing oh-my-zsh plugins"
  system %Q{yes | cp -rf $PWD/oh-my-zsh/custom/* $HOME/.oh-my-zsh/custom}
end

def install_pathegon
  unless File.exist? File.join(ENV['HOME'], '.vim', 'autoload', 'pathogen.vim')
    puts "installing pathegon"
    system %Q{mkdir -p "$HOME/.vim/autoload"}
    system %Q{curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim}
  end
end

def install_vundle
  unless File.exist? File.join(ENV['HOME'], '.vim', 'bundle', 'Vundle.vim')
    puts "installing vundle"
    system %Q{mkdir -p "$HOME/.vim/bundle"}
    system %Q{git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim}
  end
end

def install_public_keys
  puts "Linking public ssh key"
  system %Q{rm "$HOME/.ssh/id_dsa.pub"}
  system %Q{ln -s "$PWD/id_dsa.pub" "$HOME/.ssh/id_dsa.pub"}
end
