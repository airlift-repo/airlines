#!/bin/bash

# What services need to be started before Jupyter?

if [ -f /sandbox/config/jupyter_notebook_config.py ]; then
    echo "start-airtime.sh: "
    echo "  jupyter_notebook_config.py found."
    # echo "  Will copy it into ${HOME}/.jupyter  "
    echo "  Will copy it into ${HOME}/.jupyter  "
    cp /sandbox/config/jupyter_notebook_config.py ${HOME}/.jupyter
fi

if [ -f ${SDKROOT}/workspace/Setup_My_Workspace.ipynb ]; then
	# OK
	:
else
	if [[ -f ${SDKROOT}/release/airtime/Setup_My_Workspace.ipynb ]] && [[ -d ${SDKROOT}/workspace ]]; then
		echo "Install the Setup_My_Workspace notebook"
		cp ${SDKROOT}/release/airtime/Setup_My_Workspace.ipynb ${SDKROOT}/workspace
	fi
fi

# start Jupyter notebook
start-notebook.sh

# What servcies need to be started after?
