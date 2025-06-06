'use client';
import React from 'react';

const Filter = ({ onClick }) => {
    return (
        <div onClick={onClick} style={{ cursor: 'pointer' }}>
            <svg id="filter" fill="white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path d="M4.22657 2C2.50087 2 1.58526 4.03892 2.73175 5.32873L8.99972 12.3802V19C8.99972 19.3788 9.21373 19.725 9.55251 19.8944L13.5525 21.8944C13.8625 22.0494 14.2306 22.0329 14.5255 21.8507C14.8203 21.6684 14.9997 21.3466 14.9997 21V12.3802L21.2677 5.32873C22.4142 4.03893 21.4986 2 19.7729 2H4.22657Z" fill="white"/>
            </svg>
        </div>
    );
}

export default Filter;