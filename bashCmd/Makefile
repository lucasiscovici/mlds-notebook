custom ?= custom
work ?= work

latest ?= :latest
image ?= luluisco/mlds-notebook
cmd ?= mlds.sh

getP=
home ?= /home/mlds/
home_custom ?= .custom
home_work ?= work
 
portNb ?= 8888
portTensorBoard ?= 6006
portH2o ?= 54321
portSpark ?= 4004

portNbMin ?= 8888
portTensorBoardMin ?= 6006
portH2oMin ?= 54321
portSparkMin ?= 4004

portNbNb ?= 10
portTensorBoardNb ?= 10
portH2oNb ?= 10
portSparkNb ?= 10

portNbMax ?= $$((${portNbMin} + ${portNbNb}))
portTensorBoardMax ?= $$((${portTensorBoardMin} + ${portTensorBoardNb}))
portH2oMax ?= $$((${portH2oMin} + ${portH2oNb}))
portSparkMax ?= $$((${portSparkMin} + ${portSparkNb}))

debug ?= -d
run_rm ?= --rm
printCommand ?= "yes"

quiet="no"
k := $(strip $(PWD))
a = $$(${getP} ${portNbMin} ${portNbMax}  2> /dev/null)
b = $$(${getP} ${portTensorBoardMin} ${portTensorBoardMax} 2> /dev/null)
c = $$(${getP} ${portH2oMin} ${portH2oMax} 2> /dev/null)
d = $$(${getP} ${portSparkMin} ${portSparkMax} 2> /dev/null)
help:
	@echo "make mlds"
	@echo "custom=custom work=work latest=:latest image=luluisco/mlds-notebook cmd=mlds.sh portNb=8888 portTensorBoard=6006 portH2o=54321 portSpark=4004 portNbMin=8888 portTensorBoardMin=6006 portH2oMin=54321 portSparkMin=4004 portNbNb=10 portTensorBoardNb=10 portH2oNb=10 portSparkNb=10 portNbMax=XMin+XNb portTensorBoardMax=XMin+XNb portH2oMax=XMin+XNb portSparkMax=XMin+XNb home=/home/mlds/ home_custom=.custom home_work=home_work debug=-d run_rm=--rm printCommand=yes getP='./getP' quiet=no" | tr ' ' '\n' | sed -En "s/^(.*)$//\ \ \ \1/p" 
	@echo 'docker run  $$debug $$run_rm  -v $$custom:$$home$$home_custom  -v $$k/$$work:$$home$$home_work -p $$d:$$portSpark  -p $$a:$$portNb  -p $$b:$$portTensorBoard  -p $$c:$$portH2o  $$image$$latest  $$cmd'

mlds:
	@test -z ${getP}  && echo "Error ------ getP"  || (\
	((test ${printCommand} = "yes" && test ${quiet} = "no" ) && echo 'docker run  "${debug}" "${run_rm}"  -v "${custom}:${home}${home_custom}"  -v "$(k)/$(work):${home}${home_work}" -p "'$$( echo $(d))':${portSpark}"  -p "'$$( echo $(a))':${portNb}" -p "'$$( echo $(b))':${portTensorBoard}" -p "'$$( echo $(c))':${portH2o}"  "${image}${latest}" ${cmd}' || true ) && \
	docker run  "${debug}" "${run_rm}"  -v "${custom}:${home}${home_custom}"  -v "$(k)/$(work):${home}${home_work}" -p "$(d):${portSpark}"  -p "$(a):${portNb}" -p "$(b):${portTensorBoard}" -p "$(c):${portH2o}"  "${image}${latest}"  ${cmd}  || ( echo "Error ---- Help: " && make help ) )