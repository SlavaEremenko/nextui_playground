import React from "react";
import { Routes, Route, Link as RouterLink, useNavigate } from "react-router-dom";
import { Button, Navbar, Link, Text, Container, Dropdown, Avatar, Spacer } from '@nextui-org/react';
import { Layout } from './layout';
import { Home } from './home';
import { Publications } from './publications';
import { MenuBar } from './navbar/menu_bar';

export class App extends React.Component {
	render() {
		return (
			<Layout>
				<MenuBar />

				<Layout
					css={{
						px: "$12",
						mt: "$8",
						"@xsMax": {px: "$10"},
						boxSizing: "border-box",
					}}
				>
					<Spacer y={1.5} />
					<Routes>
						<Route path="/" element={<Home />} />
						<Route path="/publications" element={<Publications />} />
					</Routes>
				</Layout>
			</Layout>
		);
	}
}