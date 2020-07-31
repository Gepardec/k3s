**************
Travis-CI
**************

.. Environments
.. #############


.. environments to test
.. centos8
.. centos7
.. debian

.. How add a new test script to Travis
.. ####################################

.. How we integrate new tests in travis-CI
.. add a new subfolder called .ci to your folder
.. create a new run.sh file in that folder
.. chmod +x run.sh
.. add run.sh to .travis.yml
.. pass environment variable ${MOLECULE_SCENARIO} to run.sh

.. Example run.sh
.. ########################

.. Environement variables
.. #######################

.. MOLECULE_SCENARIO
.. centos 8
.. centos 7
.. debian

.. notifications to slack channel
.. success: changed
.. failed: always

.. Caching
.. ###########

.. pip cache

.. Current travis.yml
.. ##################

.. .. literalinclude:: ../../../.travis.yml
..    :linenos:
