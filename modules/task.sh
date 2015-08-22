_BANG_TASK_DIRS=(./tasks "$_BANG_PATH/tasks")

## Adds a new task. It is possible to add a description which is used when
## describing it.
## @param name - the name of the task
## @param description - a brief description for the task
function b.task.add () {
  local task="$1" description="$2"

  if b.task.exists? "$task"; then
    b.set "bang.tasks.$task" "$description"
  else
    b.raise TaskNotFound "Task '$task' was not found"
  fi
}

## Run a given task name. It raises an exception if the task was not added
## @param task - the name of the task to run
function b.task.run () {
  local task="$1"
  shift

  if b.task.exists? "$task"; then
    if ! b.is_set? "Bang.Tasks.PreloadedFlag"; then
        local task_path="$(b.task.resolve_path $task)"
        source "$task_path"
    fi
    "btask.${task}.run" "$@"
  else
    b.raise TaskNotKnown "Task '$task' is unknown"
  fi
}

## Checks whether a task is loaded
## @param task - the name of the task
function b.task.exists? () {
    if b.is_set? "Bang.Tasks.PreloadedFlag"; then
        declare -f "btask.${1}.run" &> /dev/null
    else
        b.task.resolve_path "$1" &> /dev/null
    fi
}

## Resolves a given task name to its filename
## @param task - the name of the task
function b.task.resolve_path () {
  b.resolve_path $1 "${_BANG_TASK_DIRS[@]}"
}
