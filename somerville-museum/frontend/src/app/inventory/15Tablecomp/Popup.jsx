/**************************************************************
 *
 *                     Popup.jsx
 *
 *        Authors: Dan Glorioso & Hannah Jiang & Zack White
 *           Date: 02/16/2025
 *
 *     Summary: The sidebar popup for a selected item in the inventory page.
 * 
 **************************************************************/

"use client";
import "./Popup.css";
import StylishButton from "../../components/StylishButton";
import "./InventoryUnit.css";
import Link from "next/link";
import Image from "next/image";
import { useEffect, useState } from "react";
import ReturnButton from "../../components/ReturnButton";

export default function Popup( { onClose, onOptionSelect, unitList, unitIndex } ) {
    const [isClosing, setIsClosing] = useState(false);
    const [selectedImage, setSelectedImage] = useState(0);
    const [unit, setUnit] = useState(unitList[unitIndex]);
    const [currIndex, setCurrIndex] = useState(unitIndex);
    const [currBorrower, setCurrBorrower] = useState(null);
    const [borrowerHistory, setBorrowerHistory] = useState([]);
    

    // Extract the unit details
    const { id, name, status, age_group, gender, color, season, garment_type, size, time_period, condition, cost, location, date_added, current_borrower, borrow_history, notes, image_keys} = unit; 

    // Close container if anywhere but the container is clicked
    const handleContainerClick = (e) => {
        if (e.target.classList.contains("expandedContainer")) {
            closePopup();
        }
    }

    const closePopup = () => {
        setIsClosing(true);
        setTimeout(() => {
            onClose();
        }, 200);
    }

    const fetchBorrowers = async () => {
        try {
            const response = await fetch(`/api/db`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    text: 'SELECT current_borrower FROM dummy_data WHERE id = $1',
                    params: [id]
                })
            });

            if (response.ok) {
                const data = await response.json();

                const currBorrower = data[0].current_borrower;
                if (currBorrower !== null) {
                    fetchCurrBorrower(currBorrower);
                } else {
                    setCurrBorrower(null);
                }
                fetchBorrowHistory();
            } else {
                console.error("Failed to fetch borrower data");
            }
        } catch (error) {
            console.error(error);
        }
    };

    const fetchBorrowHistory = async () => {
        // Fetching from borrows table
        try {
            const response = await fetch(`/api/db`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    text: 'SELECT b.date_borrowed, b.date_returned, b.notes, br.name FROM borrows b JOIN borrowers br ON b.borrower_id = br.id WHERE b.item_id = $1',
                    params: [id]
                })
            });

            if (response.ok) {
                const data = await response.json();

                const borrowData = data.map((borrow) => {
                    return {
                        dateBorrowed: borrow.date_borrowed,
                        dateReturned: borrow.date_returned,
                        notes: borrow.notes,
                        name: borrow.name,
                    };
                });

                setBorrowerHistory(borrowData);
                
            } else {
                console.error("Failed to fetch borrower data");
            }
        } catch (error) {
            console.error(error);
        }
    };
    
    const fetchCurrBorrower = async (currBorrower) => {
        // Fetching from borrower table
        let borrowData = null;
        try {
            const response = await fetch(`/api/db`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    text: 'SELECT * FROM borrowers WHERE id = $1',
                    params: [currBorrower]
                })
            });

            if (response.ok) {
                const data = await response.json();

                borrowData = {
                    name: data[0].name,
                    email: data[0].email,
                    phone_number: data[0].phone_number,
                };
                
            } else {
                console.error("Failed to fetch borrower data");
            }
        } catch (error) {
            console.error(error);
        }

        // Fetching from borrows table
        try {
            const response = await fetch(`/api/db`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    text: 'SELECT date_borrowed, return_date, approver, notes FROM borrows WHERE borrower_id = $1 AND item_id = $2',
                    params: [currBorrower, id]
                })
            });

            if (response.ok) {
                const data = await response.json();

                borrowData = {
                    ...borrowData,
                    date_borrowed: data[0].date_borrowed,
                    return_date: data[0].return_date,
                    approved_by: data[0].approver,
                    notes: data[0].notes,
                };

                setCurrBorrower(borrowData);
                
            } else {
                console.error("Failed to fetch borrower data");
            }
        } catch (error) {
            console.error(error);
        }
    };

    const handleLeftArrow = () => {
        if (currIndex > 0) {
            setCurrIndex(currIndex - 1);
            setUnit(unitList[currIndex - 1]);
            fetchBorrowers();

        }
    }

    const handleRightArrow = () => {
        if (currIndex < unitList.length - 1) {
            setCurrIndex(currIndex + 1);
            setUnit(unitList[currIndex + 1]);
            fetchBorrowers();
        }
    }

    // Add event listener for Escape key
    useEffect(() => {
        const handleKeyDown = (e) => {
            if (e.key === "Escape") {
                closePopup();
            }
        };

        document.addEventListener("keydown", handleKeyDown);

        // Cleanup event listener on component unmount
        return () => {
            document.removeEventListener("keydown", handleKeyDown);
        };
    }, []);

    // Fetch borrower information
    useEffect(() => {
        fetchBorrowers();
    }, [id]);

    // Set the status missing/found status statement based on the status
    const statusStatement = 
        status === "Missing" ? 
            (currBorrower === null ? (
                <button 
                    className="status-toggle"
                    onClick={() => onOptionSelect("Available")}
                >
                    <p className="status-toggle">Mark Item as <span>Found</span></p>
                </button>
            ) : null)
        : (
            <button 
                className="status-toggle"
                onClick={() => onOptionSelect("Missing")}
            >
                <p style={{fontSize: "1.1em"}}>Mark Item as <span>Missing</span></p>
            </button>
        );

    useEffect(() => {
        if (!unit) return;
    }, [unit]);

    
    if (!unit) {
        return null;
    }
      
    return (
        <div className={`expandedContainer ${isClosing ? 'fade-out' : 'fade-in'}`} onClick={handleContainerClick}>
            <div className={`expandedContent ${isClosing ? 'slide-out' : 'slide-in'}`}>
                <div className="headerEC">

                    {/* Title and arrow buttons */}
                    <div className="titleButton">
                        <h2>{name}</h2>
                            <div className="buttonsP">
                                {/* Left arrow button */}
                                <StylishButton
                                    styleType={"style7"}
                                    onClick={handleLeftArrow}
                                >
                                        <img src="/icons/arrow-left.svg" className="arrowIcon" alt="Next" />
                                </StylishButton>
                                
                                {/* Right arrow button */}
                                <StylishButton
                                    styleType={"style7"}
                                    onClick={handleRightArrow}
                                >
                                    <img src="/icons/arrow-right.svg" className="arrowIcon" alt="Next" />
                                </StylishButton>
                            </div>
                    </div>

                    {/* Close button */}
                    <div className="exit">
                        <StylishButton
                            styleType={"style7"}
                            onClick={closePopup}
                        >
                            <img src="/icons/close.svg" className="closeIcon" alt="Close" />
                        </StylishButton>
                    </div>
                </div>
                
                {/* Image Viewer */}
                <div className="imageContainer">
                    {image_keys && image_keys.length > 0 && (
                        // Note: adding the styling here is the only way I could get the image to fill the container
                        <div className="borrow-image" style={{ width: "100%", height: "100%" }}>
                        <Image
                            src={`https://upload-r2-assets.somerville-museum1.workers.dev/${image_keys[selectedImage]}`}
                            fill
                            alt="No image found"
                            style={{ objectFit: "contain" }}  // Ensures the image fits the container
                        />
                        </div>
                    )}
                </div>

                <div className="imageSelection">
                    {image_keys && image_keys.length > 1 && (
                        <StylishButton
                        styleType={"style4"}
                        onClick={() => setSelectedImage((selectedImage - 1 + image_keys.length) % image_keys.length)}
                        >
                        <img src="/icons/arrow-left.svg" className="arrowIcon" alt="Next" />
                        </StylishButton>
                    )}
                    {image_keys &&
                        image_keys.map((key, index) => (
                        <StylishButton
                            key={index}
                            styleType={selectedImage === index ? 'style5' : 'style4'}
                            onClick={() => setSelectedImage(index)}
                            label={`${index + 1}`}
                        />
                        ))}

                    {image_keys && image_keys.length > 1 && (
                        <StylishButton
                        styleType={"style4"}
                        onClick={() => setSelectedImage((selectedImage + 1) % image_keys.length)}
                        >
                        <img src="/icons/arrow-right.svg" className="arrowIcon" alt="Next" />
                        </StylishButton>
                    )}
                </div>
                {/* Info Title and Edit Button */}
                <div className="infoHeader">
                    <h3>Item Information</h3>
                    <Link href={`/edit?id=${id}`}>
                        <StylishButton
                            styleType={"style1"}
                            label={"Edit"}>
                        </StylishButton>
                    </Link>
                </div>

                {/* Item Information Table */}
                <table id="itemInformation">
                    <tbody>
                        <tr>
                            <td><strong>Name: </strong>{name}</td>
                            <td><strong>Size: </strong>{size}</td>
                        </tr>
                        <tr>
                            <td><strong>ID: </strong>{id}</td>
                            <td><strong>Age Group: </strong>{age_group}</td>
                        </tr>
                        <tr>
                            <td><strong>Cost: </strong>{cost !== null ? `$${cost}` : "N/A"}</td>
                            <td><strong>Sex: </strong>{gender}</td>
                        </tr>
                        <tr>
                            <td><strong>Date Added: </strong>{date_added}</td>
                            <td><strong>Season: </strong>
                                <span style={{ display: "inline-flex", gap: "8px", flexWrap: "wrap" }}>
                                    {Array.isArray(season) ? season.join(", ") : season}
                                </span>
                            </td>
                        </tr>
                        <tr>
                        <td style={{verticalAlign: "top", paddingTop: "5px"}}>
                            <strong>Condition: </strong>
                            <span style={{ display: "inline-flex", gap: "10px", flexWrap: "wrap"}}>
                                {(Array.isArray(condition) ? condition : [condition]).map((cond, i) => (
                                <span key={i} style={{ display: "inline-flex", alignItems: "center", gap: "6px" }}>
                                    <div className={`circle2 ${cond}`}></div>
                                    <span>{cond}</span>
                                </span>
                                ))}
                            </span>
                            </td>
                            <td style={{verticalAlign: "top", paddingTop: "5px"}}>
                                <strong>Time Period: </strong>
                                <span style={{ display: "inline-flex", gap: "8px", flexWrap: "wrap", verticalAlign: "top" }}>
                                    {Array.isArray(time_period) ? time_period.join(", ") : time_period}
                                </span>
                            </td>
                            
                        </tr>
                        <tr>
                            <td>
                                <strong>Status: </strong>
                                <span style={{ display: "inline-flex", alignItems: "center", gap: "8px" }}>
                                    <div className={`circle1 ${status}`}></div>
                                    {status}
                                </span>
                            </td>
                            <td>
                                <strong>Garment Type: </strong>
                                <span style={{ display: "inline-flex", gap: "8px", flexWrap: "wrap" }}>
                                    {Array.isArray(garment_type) ? garment_type.join(", ") : garment_type}
                                </span>
                                
                            </td>
                        </tr>

                        <tr>
                            <td>{statusStatement}</td>
                            <td>
                                <strong>Color: </strong>
                                <span style={{ display: "inline-flex", gap: "8px", flexWrap: "wrap" }}>
                                    {Array.isArray(color) ? color.join(", ") : color}
                                </span>
                                                                
                                </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><strong>Location: </strong>{location}</td>
                        </tr>
                    </tbody>
                </table>

                {/* Big Notes Box */}
                <div className="noteSection"> 
                    <p><strong>Notes</strong></p>
                    <textarea readOnly className="noteBox" value={notes || ""} />
                </div>


                {/* Horizontal diver */}
                <div id = "divider"></div>
               
                   {/* Borrower Info */}
                   {status !== "Available" && (
                        <>
                        <div className="borrowerTitle">
                        <h3>Borrower Information</h3>
                    </div>

                    <div id="currentBorrowerContainer">
                        <table id="currentBorrower">
                            <thead>
                                <tr>
                                <th><strong>Current Borrower</strong></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                <td><strong>Name: </strong>{currBorrower !== null ? currBorrower.name : "N/A"}</td>
                                <td><strong>Date Borrowed: </strong>{currBorrower !== null ? currBorrower.date_borrowed : "N/A"}</td>
                                </tr>
                                <tr>
                                <td><strong>Email: </strong>{currBorrower !== null ? currBorrower.email : "N/A"}</td>
                                <td><strong>Return Date: </strong>{currBorrower !== null ? currBorrower.return_date : "N/A"}</td>
                                </tr>
                                <tr>
                                <td><strong>Cell: </strong>{currBorrower !== null ? currBorrower.phone_number : "N/A"}</td>
                                <td><strong>Approved By: </strong>{currBorrower !== null ? currBorrower.approved_by : "N/A"}</td>
                                </tr>
                            </tbody>
                            </table>
    
                        {/* Borrow's Notes */}
                        <div className="noteSection"> 
                            <p><strong>Notes</strong></p>
                            <textarea readOnly className="noteBox" value={currBorrower !== null ? currBorrower.notes : ""} />
                        </div>
    
                    </div>

                    </>
                )}
             
                {/* Borrow History Table */}
                <div id="borrowerHistoryContainer">
                    <p id="borrowerHistorytitle">Borrower History</p> 
                    <table id="borrowerHistory">
                        <tbody>
                            {borrowerHistory && borrowerHistory.length > 0 ? (
                                borrowerHistory.map((borrower, index) => (
                                    <tr key={index + 1}>
                                        <td>{borrower.dateBorrowed || "N/A"} - {borrower.dateReturned || "N/A"}</td>
                                        <td>{borrower.name || "N/A"}</td>
                                        <td>{borrower.notes || "N/A"}</td>
                                    </tr>
                                ))
                            ) : (
                                <tr>
                                    <td>N/A</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div> 
        </div>
    );
}