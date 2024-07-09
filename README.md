# BlueSpy
This is a bash shell version of blue spy script to bypass auth progress of bluetooth device.
This project is created based on the project [TarlogicSecurity/BlueSpy](https://github.com/TarlogicSecurity/BlueSpy)

## Update
* Fix some parameters of btmgmt command.
* Convert script from Python 3.11 to Bash shell.

## Principle
When a attacker's device is creating bluetooth connection to a victim's device, the attacker could force the capacity of pair to NoInputNoOutput, this kind of configuration maybe bypass authentication of target device.

BTW, we found this kind of attacking is just working for BR/EDR protocol.