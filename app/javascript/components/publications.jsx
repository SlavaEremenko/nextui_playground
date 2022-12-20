import React, { useState, useEffect } from 'react';
import { Badge, Text, Spacer, Link, Input, Container, Row, Col, Pagination, Dropdown } from '@nextui-org/react';
import { PublicationsTable } from './publications_table'

export class Publications extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			publication_types: [],
			publication_type_counts: {},
			publications: [{ id: 0, name: "", publication_type_display: "" }],
			publication_type: "",
			search: "",
			total_pages: 1,
			page: 1,
		};
		this.setPage = this.setPage.bind(this);
		this.setSearch = this.setSearch.bind(this);
		this.setPublicationType = this.setPublicationType.bind(this);
	}
	fetchPublications(page, search, publication_type) {
		return fetch(`/api/publications?fields=id,name,publication_type_display&publication_type_counts=true&page=${page}&publication_type=${publication_type}&search=${search.replaceAll(' ', '+')}`)
			.then(result => result.json())
			.then(result => this.setState(result));
	}
	fetchPublicationTypes() {
		return fetch(`/api/publication_types?fields=id,name,display,digital`)
			.then(result => result.json())
			.then(result => {
				const publication_types = result.publication_types.filter(pub_type => !pub_type.digital || pub_type.name == "newsletter");
				this.setState({ publication_types });
			});
	}
	componentDidMount() {
		this.fetchPublications(this.state.page, this.state.search, this.state.publication_type);
		this.fetchPublicationTypes();
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
	findPubType(name) {
		return this.state.publication_types.find(
			pub_type => pub_type.name === this.state.publication_type
		);
	}
	render() {
		return (
			<>
				<Row align="center">
					<Col span={6}>
						<Row>
							<Text h2 css={{display: "inline-block"}}>
								Publications
							</Text>
							<span
								style={{
									alignSelf: "center",
									position: "relative",
									left: 17,
									top: -2,
								}}
							>
								<Badge variant="flat">{this.state.total}</Badge>
							</span>
						</Row>
						<Text size="$lg">
							A list of publications from &nbsp;
							<Link
								href="https://wcm.n2pub.com/publications"
								css={{display: "inline"}}
								color="secondary"
							>
								N2 Web Content Manager
							</Link>.
						</Text>
					</Col>

					<Col span={2} align="right" css={{ pr: 14 }}>
						<Dropdown>
							<Dropdown.Button
								css={{ tt: "capitalize" }}
								color="secondary"
								ripple={false}
								flat
							>
								{ this.findPubType(this.state.publication_type)?.display || "All Types" }
							</Dropdown.Button>
							<Dropdown.Menu
								aria-label="Single selection actions"
								color="secondary"
								disallowEmptySelection
								selectionMode="single"
								selectedKeys={this.state.publication_type}
								onSelectionChange={this.setPublicationType}
								items={[
									{
										name: "",
										display: "All Types",
										publications_count: this.state.total,
									},
									...this.state.publication_types
								]}
							>
								{pub_type => (
									<Dropdown.Item
										key={pub_type.name}
										command={
												// Publications count
												pub_type.name === "" ?
													Object.values(this.state.publication_type_counts).reduce((acc, val) => acc + val, 0)
													:
													this.state.publication_type_counts[pub_type.name] || "0"
											}
									>
										{pub_type.display}
									</Dropdown.Item>
								)}
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
				
				<Spacer y={1.5} />

				<PublicationsTable items={this.state.publications} />

				<Spacer y={1.5} />
				
				<Row>
					<Col css={{textAlign: "center"}}>
						<Pagination shadow color="secondary" total={this.state.total_pages} page={this.state.page} onChange={this.setPage} />
					</Col>
				</Row>

			</>
		);
	}
}