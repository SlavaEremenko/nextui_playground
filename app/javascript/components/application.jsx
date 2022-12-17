import * as React from "react";
import * as ReactDOM from "react-dom/client";

class App extends React.Component {
	render() {
		return <h1>Hello, World!</h1>;
	}
}

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.createRoot(document.getElementById("root")).render(
  	<App />
  );
});