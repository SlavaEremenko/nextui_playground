import * as React from 'react';
import { Container, Text, Spacer, Link, Table } from '@nextui-org/react';

export const PublicationsTable = (props) => (
	<>
		<Table
			bordered
			color="secondary"
			aria-label="Example pagination  table"
			css={{
				height: "auto",
				minWidth: "100%",
				td: {
					userSelect: "auto",
				}
			}}
		>
			<Table.Header>
				<Table.Column>NAME</Table.Column>
				<Table.Column>TYPE</Table.Column>
			</Table.Header>
			<Table.Body>
				{props.items.map((publication, i) => {
					return (
						<Table.Row key={i}>
							<Table.Cell>{publication.name}</Table.Cell>
							<Table.Cell>{publication.publication_type}</Table.Cell>
						</Table.Row>
					)
				})}
			</Table.Body>
		</Table>
	</>
);