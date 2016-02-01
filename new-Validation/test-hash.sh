

declare -A sentence

sentence[Begin]='Be liberal in what'
sentence[Middle]='you accept, and conservative'
sentence[End]='in what you send'


a='End'

echo ${sentence[$a]} should be in what you send  
