import React from 'react'

const Category = props => {
  return (
    <li>
      <button onClick={() => props.handleCategorySelect(props.category.category_name)}>
        {props.category.category_name}
      </button>
    </li>
  )
}

export default Category
