# zsh-lazy-init

A zshell plugin that allows you to declare an intialization function and entrypoints before which the initialization functionn will be executed.
It supports lazy loading multiple tools like nvm, rbenv or sdk.

You can use the function in following way:
```
add_lazy nvm_init nvm npm node gulp yarn
add_lazy sdk_init sdk gradle java
```
First argument is the name of the initialization function followed by list of entrypoitns.
