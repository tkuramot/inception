import React, { useState } from "react";
import "./App.css";

interface Task {
  id: number;
  text: string;
}

const App: React.FC = () => {
  const [task, setTask] = useState<string>("");
  const [tasks, setTasks] = useState<Task[]>([]);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setTask(e.target.value);
  };

  const handleAddTask = () => {
    if (task.trim() === "") return;
    const newTask: Task = { id: tasks.length + 1, text: task };
    setTasks([...tasks, newTask]);
    setTask("");
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Task Manager</h1>
        <div>
          <input
            type="text"
            value={task}
            onChange={handleInputChange}
            placeholder="Enter a task"
          />
          <button onClick={handleAddTask}>Add Task</button>
        </div>
        <ul>
          {tasks.map((task) => (
            <li key={task.id}>{task.text}</li>
          ))}
        </ul>
      </header>
    </div>
  );
};

export default App;
