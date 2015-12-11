require 'rake'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false

  install_oh_my_zsh
  install_pathegon
  install_vundle

  Dir['*'].each do |file|
    next if %w[Rakefile README LICENSE id_dsa.pub oh-my-zsh].include? file
    
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end

  # Handle ssh pubkey on its own
  puts "Linking public ssh key"
  system %Q{rm "$HOME/.ssh/id_dsa.pub"}
  system %Q{ln -s "$PWD/id_dsa.pub" "$HOME/.ssh/id_dsa.pub"}

  # Need to do this to make vim use RVM's ruby version
  puts "Moving zshenv to zshrc"
  system %Q{sudo mv /etc/zshenv /etc/zshrc}

  system %Q{mkdir ~/.tmp}
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def install_oh_my_zsh
  unless File.exist? File.join(ENV['HOME'], '.oh-my-zsh')
    puts "installing oh-my-zsh"
    system %Q{$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)}
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
