import React from 'react';
import { useNavigate, useLocation } from "react-router-dom";
import { Button, Navbar, Link, Text, Container, Dropdown, Avatar } from '@nextui-org/react';
import { UnabridgedLogo } from './unabridged_logo';
import { NavbarLink } from './navbar_link';

export const MenuBar = () => {
	return (
		<Navbar variant="sticky">
			<Navbar.Brand>
				<UnabridgedLogo />
			</Navbar.Brand>
			<Navbar.Content
				variant="highlight-solid-rounded"
				activeColor="secondary"
			>
				<NavbarLink href="/">Home</NavbarLink>
				<NavbarLink href="/publications">Publications</NavbarLink>
			</Navbar.Content>
			
			<Navbar.Content
				css={{
					"@xs": {
						w: "12%",
						jc: "flex-end",
					},
				}}
			>
				<Dropdown placement="bottom-right">
					<Navbar.Item>
						<Dropdown.Button color="secondary" light>
							<Avatar
								bordered
								color="secondary"
								size="md"
								src="https://i.pravatar.cc/150?u=a042581f4e29026704d"
							/>
						</Dropdown.Button>
					</Navbar.Item>
					<Dropdown.Menu
						aria-label="User menu actions"
						color="secondary"
					>
						<Dropdown.Item key="profile" css={{ height: "$18" }}>
							<Text b color="inherit" css={{ d: "flex" }}>
								Signed in as
							</Text>
							<Text b color="inherit" css={{ d: "flex" }}>
								zoey@example.com
							</Text>
						</Dropdown.Item>
						<Dropdown.Item key="settings" withDivider>
							My Settings
						</Dropdown.Item>
						<Dropdown.Item key="team_settings">Team Settings</Dropdown.Item>
						<Dropdown.Item key="analytics" withDivider>
							Analytics
						</Dropdown.Item>
						<Dropdown.Item key="system">System</Dropdown.Item>
						<Dropdown.Item key="configurations">Configurations</Dropdown.Item>
						<Dropdown.Item key="help_and_feedback" withDivider>
							Help & Feedback
						</Dropdown.Item>
						<Dropdown.Item key="logout" withDivider color="error">
							Log Out
						</Dropdown.Item>
					</Dropdown.Menu>
				</Dropdown>
			</Navbar.Content>
		</Navbar>
	)
}