class Login < Thor

	include Thor::Actions

	desc "change_extn", "Renames files in current folder from one extension to another"
	def type
	  find_type = ask("Enter the original file type extension:")
	  say(find_type, :green)

	  replace_type = ask("Enter the new file type:")
	  say(replace_type, :green)
	end
end
