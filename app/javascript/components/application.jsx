import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { NextUIProvider } from '@nextui-org/react';
import { Button } from '@nextui-org/react';


class App extends React.Component {
	render() {
		return (
			<div>
				<h1>Hello, World!</h1>
				<Button>Click</Button>
			</div>
		);
	}
}

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.createRoot(document.getElementById("root")).render(
	<NextUIProvider>
  		<App />
	</NextUIProvider>
  );
});