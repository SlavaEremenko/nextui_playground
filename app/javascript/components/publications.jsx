import React, { useState, useEffect } from 'react';
import { Text, Spacer, Link, Input, Container, Row, Col, Pagination, Dropdown } from '@nextui-org/react';
import { PublicationsTable } from './publications_table'

export class Publications extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			publications: [],
			page: 1,
			total_pages: 1,
			search: "",
			publication_type: null
		};
		this.setPage = this.setPage.bind(this);
		this.setSearch = this.setSearch.bind(this);
		this.setPublicationType = this.setPublicationType.bind(this);
	}
	fetchPublications(page, search, publication_type) {
		return fetch(`/api/publications?fields=name,publication_type&page=${page}&publication_type=${publication_type}&search=${search.replaceAll(' ', '+')}`)
			.then(result => result.json())
			.then(result => {
				this.setState(result);
			});
	}
	componentDidMount() {
		this.fetchPublications(this.state.page, this.state.search);
	}
	setPage(page) {
		this.fetchPublications(page, this.state.search, this.state.publication_type).then(() => {
			this.setState({ page });
		});
	}
	setSearch(e) {
		const search = e.target.value;
		this.fetchPublications(this.state.page, search, this.state.publication_type).then(() => {
			this.setState({ search });
		});
	}
	setPublicationType(e) {
		const publication_type = e.currentKey;
		this.fetchPublications(this.state.page, this.state.search, publication_type).then(() => {
			this.setState({ publication_type });
		});
	}
	render() {
		return (
			<>
				<Container gap={0}>
					<Row align="center">
						<Col span={6}>
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

						<Col span={2} align="right" css={{ pr: 14 }}>
							<Dropdown>
								<Dropdown.Button flat color="secondary" css={{ tt: "capitalize" }}>
									{this.state.publication_type || "Any"}
								</Dropdown.Button>
								<Dropdown.Menu
									aria-label="Single selection actions"
									color="secondary"
									disallowEmptySelection
									selectionMode="single"
									selectedKeys={this.state.publication_type}
									onSelectionChange={this.setPublicationType}
								>
									<Dropdown.Item key="">Any</Dropdown.Item>
									<Dropdown.Item key="number">Number</Dropdown.Item>
									<Dropdown.Item key="date">Date</Dropdown.Item>
									<Dropdown.Item key="single_date">Single Date</Dropdown.Item>
									<Dropdown.Item key="iteration">Iteration</Dropdown.Item>
								</Dropdown.Menu>
							</Dropdown>
						</Col>

						<Col span={4}>
							<Input 
								css={{float: "right", width: "100%"}}
								size="lg"
								labelPlaceholder="Search by name/type"
								clearable
								onChange={this.setSearch}
							/>
						</Col>
					</Row>
				</Container>
				
				<Spacer y={1.5} />

				<PublicationsTable items={this.state.publications} />

				<Spacer y={1.5} />
				
				<Container css={{textAlign: "center"}}>
					<Pagination shadow color="secondary" total={this.state.total_pages} page={this.state.page} onChange={this.setPage} />
				</Container>
			</>
		);
	}
}