import React from 'react'

const Category = props => {
  return (
    <li
      onClick={() => props.handleCategorySelect(props.category.category_name)}>
      {props.category.category_name}
    </li>
  )
}

export default Category
