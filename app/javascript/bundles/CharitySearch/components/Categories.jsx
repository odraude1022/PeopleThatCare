import React from 'react'
import Category from './Category'

const Categories = props => {
  return (
    <ul>
      <li onClick={() => props.handleCategorySelect('')}>All</li>
      {
      props.categories.map( category => {
        return <Category key={category.id} category={category} handleCategorySelect={props.handleCategorySelect}/>
            })
      }

    </ul>
    )
}

export default Categories
