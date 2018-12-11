# Ginge Theme -- made with real gingers
#             -- red never looked so good
#             -- red and white, not so blue
# Best with a white on black console

setopt prompt_subst

# Generates the prompt string
prompt () {
	local pre_top=╭─
	local pre_mid=├─
	local pre_bot=╰─➤

	local gng_usr_clr="%B$FG[166]%n%b%f"	# User color
	local gng_hst_clr="%B$FG[166]%M%b%f"	# Hostname color
	local gng_rtu_clr="%B$FG[081]%n%b%f"	# Root hostname color
	local gng_rth_clr="%B$FG[081]%n%b%f"	# Root hostname color
	local gng_pwd_clr="%B$FG[208]%~%b%f"	# PWD color
	local gng_git_clr="$FG[172]"	# Git branch color
	local gng_mod_clr="${pre_mid}$FG[009]$(sed 's/:/, /g' <<< ${LOADEDMODULES})%b%f"	# Module color
	local gng_rtn_clr="%B%F{red}%b%f"	# Return code color
	local nrml_clr='%b%f'			# Revert back to normal color

	# Set up variables
	local gng_uh gng_pwd gng_git gng_mod gng_rtn

	# Set up username@hostname text
	if [[ $UID -ne 0 ]]; then
		gng_uh="[${gng_usr_clr}@${gng_hst_clr}]"
	else
		gng_uh="[${gng_rtu_clr}@${gng_rth_clr}]"
	fi

	# Set up PWD text
	gng_pwd="[${gng_pwd_clr}]"

	# Set up git branch text
	ZSH_THEME_GIT_PROMPT_PREFIX="<$FG[172]"
	ZSH_THEME_GIT_PROMPT_SUFFIX="%b%f>"
	gng_git="$(git_prompt_info)"

	# Set up module text
	if ! [ -z "${LOADEDMODULES}" ]; then
		gng_mod="
${gng_mod_clr}"
	fi

	# Set up return code text
	gng_rtn="%(?..%F{red}%?↵${nrml_clr}%f)"

	PROMPT="${pre_top}${gng_uh}${gng_pwd} ${gng_git}${gng_mod}
${pre_bot} "
	RPROMPT="${gng_rtn}"
}

precmd_functions+=(prompt)
