import React, { Component } from 'react'
import axios from 'axios'
import Charity from './Charity'
import Categories from './Categories'

export default class CharitySearch extends Component {
  state = {
          category: '',
          query: '',
          charities: [],
          page: 1,
          categories: []
          }

  componentDidMount() {
    this.fetchCharities()
    this.fetchCategories()
  }

  handleCategorySelect = (category) => {
    this.setState({category: category})
    this.fetchCharities()
  }

  fetchCategories = () => {
    let data = axios.get(`/categories.json`).then(res => {
      this.setState({categories: res.data.categories})
    })
  }

  fetchCharities = () => {
    let { category, query } = this.state
    let data = axios.get(`/charities.json?term=${query}&category=${category}`).then(res => {
      this.setState({charities: res.data.charities})
    })

  }

  handleSubmit = (event) => {
    event.preventDefault();
    this.fetchCharities()
  }

  handleChange = (event) => {
    this.setState({query: event.target.value})
  }

  render(){
    let { category, query, charities, page, categories } = this.state
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
      </div>
    )
  }
}
