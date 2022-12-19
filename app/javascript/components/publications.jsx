import React, { useState, useEffect } from 'react';
import { Text, Spacer, Link, Input, Container, Row, Col } from '@nextui-org/react';
import { PublicationsTable } from './publications_table'

export class Publications extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			publications: []
		};
	}
	componentDidMount() {
		fetch("/api/publications")
			.then(res => res.json())
			.then(result => {
				this.setState({
					publications: result.items
				});
			});
	}
	render() {
		return (
			<>
				<Container gap={0}>
					<Row align="center">
						<Col span={8}>
							<Text h2>Publications</Text>		
							<Text size="$lg">
								A list of publications from &nbsp;
								<Link
									href="https://wcm.n2pub.com/publications"
									css={{display: "inline"}}
									color="secondary"
									block
								>
									N2 Web Content Manager
								</Link>.
							</Text>
						</Col>

						<Col span={4}>
							<Input 
								clearable
								labelPlaceholder="Search by name/type"
								size="lg"
								onChange
								css={{float: "right", width: "100%"}}
							/>
						</Col>
					</Row>
				</Container>
				
				<Spacer y={1.5} />

				<PublicationsTable items={this.state.publications} />
			</>
		);
	}
}