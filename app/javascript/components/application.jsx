import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { NextUIProvider } from '@nextui-org/react';
import { BrowserRouter } from 'react-router-dom';
import { App } from './app';

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.createRoot(document.getElementById("root")).render(
  	<BrowserRouter>
			<NextUIProvider>
		  	<App />
			</NextUIProvider>
		</BrowserRouter>
  );
});