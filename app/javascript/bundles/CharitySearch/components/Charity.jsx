import React from 'react'

const Charity = props => {
  return (<a href={props.charity.location}>{props.charity.organization_name}</a>)
}

export default Charity
