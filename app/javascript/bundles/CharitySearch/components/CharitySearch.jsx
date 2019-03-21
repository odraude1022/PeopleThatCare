import React, { Component } from 'react'
import axios from 'axios'
import Charity from './Charity'
import Categories from './Categories'
import Pagination from './Pagination'

export default class CharitySearch extends Component {
  state = {
          category: '',
          query: '',
          charities: [],
          page: 1,
          totalPages: 1,
          categories: []
          }

  componentDidMount() {
    this.fetchCharities()
    this.fetchCategories()
  }

  handleCategorySelect = (category) => {
    this.setState({category: category})
    this.fetchCharities('', category, 1)
  }

  fetchCategories = () => {
    let data = axios.get(`/categories.json`).then(res => {
      this.setState({categories: res.data.categories})
    })
  }

  fetchCharities = (query, category, page) => {
    let data = axios.get(`/charities.json?term=${query}&category=${category}&page=${page}`).then(res => {
      this.setState({charities: res.data.charities, page: res.data.page, totalPages: res.data.totalPages, category: category, query: query})
    })

  }

  handleSubmit = (event) => {
    event.preventDefault();
    this.fetchCharities(this.state.query, '', 1)
  }

  handleChange = (event) => {
    this.setState({query: event.target.value})
    console.log(this.state.page)
    console.log(this.state.totalPages)
  }

  changePage = page => {
    this.fetchCharities(this.state.query, this.state.category, page)
  }

  render(){
    let { category, query, charities, page, totalPages, categories } = this.state
    return(
      <div>
        <form onSubmit={this.handleSubmit}>
          <input
            autoComplete="off"
            type="text"
            placeholder="Search"
            value={this.state.query}
            onChange={this.handleChange}
          />
        </form>
        <Categories
          handleCategorySelect={this.handleCategorySelect}
          categories={this.state.categories}
        />
        <ul>
          { this.state.charities && this.state.charities.map(charity => {
            return <li key={charity.id} ><Charity charity={charity}/></li>
          })
          }
        </ul>
        <Pagination
        page={page}
        totalPages={totalPages}
        changePage={this.changePage}/>
      </div>
    )
  }
}
