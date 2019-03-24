import React from 'react'
import Category from './Category'

const Categories = props => {
  return (
    <ul className = "button-wrap-wrap" >
      <div className = "button-wrap">
        <li className = "category-button" >
          <button onClick={() => props.handleCategorySelect('')}>
            All
          </button>
        </li>
        {
        props.categories.map( category => {
          return <Category key={category.id} category={category} handleCategorySelect={props.handleCategorySelect}/>
          })
        }
      </div>
    </ul>
    )
}

export default Categories
