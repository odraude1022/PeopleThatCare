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
    this.fetchCharities('', category, 1)
  }

  fetchCategories = () => {
    let data = axios.get(`/categories.json`).then(res => {
      this.setState({categories: res.data.categories})
    })
  }

  fetchCharities = (query = '', category = '', page = 1) => {
    let data = axios.get(`/charities.json?term=${query}&category=${category}&page=${page}`).then(res => {
      this.setState({charities: res.data.charities, page: res.data.page, totalPages: res.data.totalPages, category: category, query: query})
    })
  }

  handleSubmit = (event) => {
    event.preventDefault();
    this.fetchCharities(this.state.query, this.state.category, 1)
  }

  handleChange = (event) => {
    this.setState({query: event.target.value})
  }

  changePage = page => {
    this.fetchCharities(this.state.query, this.state.category, page)
  }

  render(){
    let { category, query, charities, page, totalPages, categories } = this.state
    return(
      <div>
        <div className= "search-wrap">
          <form onSubmit={this.handleSubmit}>
            <input
                autoComplete="off"
                type="text"
                placeholder="Search"
                value={this.state.query}
                onChange={this.handleChange}
                className="form-control search-bar"
            />
          </form>
        </div>
        <Categories
          handleCategorySelect={this.handleCategorySelect}
          categories={this.state.categories}
        />
        <div className = "img-search-wrap">
          <ul className = "ul-charity">
            { this.state.charities && this.state.charities.map(charity => {
              return <li key={charity.id} className = "charity-name" ><Charity charity={charity}/></li>
            })
            }
          </ul>
          <img className= "img-search" src="/volunteers.jpg"  alt="volunteers"/>
        </div>
        <div className = "search-pagination">
          <Pagination
          page={page}
          totalPages={totalPages}
          changePage={this.changePage}/>
        </div>
      </div>
    )
  }
}
