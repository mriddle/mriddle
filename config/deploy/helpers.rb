Capistrano::Configuration.instance(:must_exist).load do
  def dirs_changed? *dirs
    return true unless remote_file_exists? "#{current_path}/REVISION"
    from = source.next_revision(current_revision)
    capture("cd #{latest_release} && #{source.local.log(from)} #{dirs.join(' ')} | wc -l").to_i > 0
  end
end