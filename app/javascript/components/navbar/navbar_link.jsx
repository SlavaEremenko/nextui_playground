import React from 'react';
import { Navbar } from '@nextui-org/react';
import { useNavigate, useLocation } from "react-router-dom";

export const NavbarLink = ({ href, children }) => {
	const navigate = useNavigate();
	const location = useLocation();

	return <Navbar.Link
				isActive={location.pathname === href}
				onClick={() => navigate(href)}
			>
				{children}
			</Navbar.Link>;
}