"use client";
import "./PrePopup.css";
import { useState, useEffect, useRef, forwardRef} from "react";
import StylishButton from "../../components/StylishButton";
import Link from "next/link";


export default function PrePopup({ unit, onClose, onOptionSelect, position, status}) {
    const popupRef = useRef(null);

    const handleExpandClick = () => {
        onOptionSelect("expand"); 
    };

    const handleFoundClick = async() => {
        onOptionSelect("Available"); 

        try {
            // 1. Send Emails first
            const emailResponse = await fetch('/api/borrowManagement?action=groupReturnsByBorrower', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ returnedItems: [unit.id] }),
            });
        
            if (!emailResponse.ok) {
                throw new Error(`Group API error: ${emailResponse.status} - ${emailResponse.statusText}`);
            }
        
            const emailResult = await emailResponse.json();
        
            // 2. THEN update DB
            const returnResponse = await fetch('/api/borrowManagement?action=return', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    selectedItems: [unit.id],
                    notes_id: [],
                    notes_content: [],
                }),
            });
        
            if (!returnResponse.ok) {
                throw new Error(`Fetch error: ${returnResponse.status} - ${returnResponse.statusText}`);
            }
        
            const returnResult = await returnResponse.json();
            
            // Show success popup instead of alert
            setIsSuccessPopupVisible(true);
            
            // Don't immediately reload - this will happen when user confirms in popup
        
        }    catch (error) {
                if (error.message.includes("404") || error.message.includes("No borrower")) {
                    console.info("No borrower to notify — skipping email step.");
                } else {
                    console.error("Unexpected error:", error);
                }
            }
    };

    const handleMissingClick = () => {
        onOptionSelect("Missing");
    }

    useEffect(() => {
        function handleClickOutside(event) {
            if (popupRef.current && !popupRef.current.contains(event.target)) {
                onClose(); // Close the popup if clicked outside
            }
        }

        document.addEventListener("click", handleClickOutside);
        return () => {
            document.removeEventListener("click", handleClickOutside);
        };
    }, [onClose]);

    return (
        <div className="Popup" 
             style={{ top: position.top, right: `calc(${position.right} + 9px)` }}
             ref={popupRef}>
            <div className="Buttons">
                <div className="editBtn">
                     <svg xmlns="http://www.w3.org/2000/svg" width="20" height="21" viewBox="0 0 20 21" fill="none">
                    <path d="M10.4232 3.28369C10.6276 3.28392 10.8241 3.36217 10.9727 3.50246C11.1213 3.64275 11.2107 3.83449 11.2227 4.03849C11.2347 4.2425 11.1683 4.44339 11.0372 4.6001C10.906 4.75681 10.7199 4.85753 10.517 4.88166L10.4232 4.88728H4.00886V16.1124H15.234V9.69803C15.2342 9.49367 15.3124 9.29711 15.4527 9.14851C15.593 8.99991 15.7847 8.91048 15.9888 8.89851C16.1928 8.88653 16.3936 8.9529 16.5504 9.08407C16.7071 9.21523 16.8078 9.40129 16.8319 9.60422L16.8375 9.69803V16.1124C16.8377 16.5169 16.6849 16.9066 16.4098 17.2032C16.1347 17.4999 15.7576 17.6816 15.3542 17.7119L15.234 17.716H4.00886C3.60429 17.7161 3.21463 17.5633 2.91798 17.2882C2.62133 17.0131 2.43962 16.6361 2.40928 16.2326L2.40527 16.1124V4.88728C2.40515 4.48271 2.55794 4.09305 2.83303 3.7964C3.10811 3.49975 3.48516 3.31804 3.88859 3.2877L4.00886 3.28369H10.4232ZM15.4288 3.55871C15.5731 3.41491 15.7667 3.33142 15.9703 3.3252C16.1739 3.31898 16.3723 3.3905 16.5251 3.52523C16.6779 3.65996 16.7736 3.84779 16.793 4.05059C16.8123 4.25338 16.7537 4.45592 16.6291 4.61707L16.5625 4.69324L8.62478 12.6302C8.48049 12.774 8.28687 12.8575 8.08326 12.8637C7.87964 12.8699 7.6813 12.7984 7.5285 12.6637C7.37571 12.5289 7.27993 12.3411 7.26061 12.1383C7.24129 11.9355 7.29989 11.733 7.42449 11.5718L7.49104 11.4965L15.4288 3.55871Z" fill="white"/>
                    </svg>
                    <Link className="popupBtn" href={`/edit?id=${unit.id}`}>
                            Edit Item
                    </Link>
                </div>
                <div className="expandBtn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">
                    <path d="M9.6212 12.7693C10.9497 12.7693 12.0266 11.6923 12.0266 10.3639C12.0266 9.03542 10.9497 7.9585 9.6212 7.9585C8.29274 7.9585 7.21582 9.03542 7.21582 10.3639C7.21582 11.6923 8.29274 12.7693 9.6212 12.7693Z" stroke="white" strokeWidth="1.60358"/>
                    <path d="M16.1866 9.50927C16.4977 9.88771 16.6533 10.0761 16.6533 10.364C16.6533 10.6518 16.4977 10.8402 16.1866 11.2187C15.0481 12.601 12.5369 15.1747 9.62156 15.1747C6.70625 15.1747 4.19503 12.601 3.05649 11.2187C2.74539 10.8402 2.58984 10.6518 2.58984 10.364C2.58984 10.0761 2.74539 9.88771 3.05649 9.50927C4.19503 8.12698 6.70625 5.55322 9.62156 5.55322C12.5369 5.55322 15.0481 8.12698 16.1866 9.50927Z" stroke="white" strokeWidth="1.60358"/>
                    </svg>
                    <button className="popupBtn" onClick={handleExpandClick}> 
                        View Expanded </button>
                </div>
                { status !== "Missing" && (
                    <div className="missingBtn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="21" viewBox="0 0 20 21" fill="none">
                            <path fillRule="evenodd" clipRule="evenodd" d="M8.01787 2.48193C11.5547 2.48193 14.4322 5.35948 14.4322 8.89629C14.4322 10.3761 13.9235 11.7366 13.0785 12.8231L17.638 17.3826L16.5042 18.5164L11.9447 13.9569C10.8582 14.8019 9.49766 15.3106 8.01787 15.3106C4.48106 15.3106 1.60352 12.4331 1.60352 8.89629C1.60352 5.35948 4.48106 2.48193 8.01787 2.48193ZM8.01787 4.08553C5.36504 4.08553 3.20711 6.24345 3.20711 8.89629C3.20711 11.5491 5.36504 13.707 8.01787 13.707C10.6707 13.707 12.8286 11.5491 12.8286 8.89629C12.8286 6.24345 10.6707 4.08553 8.01787 4.08553ZM8.01787 10.099C8.68209 10.099 9.22056 10.6374 9.22056 11.3017C9.22056 11.9659 8.68209 12.5044 8.01787 12.5044C7.35364 12.5044 6.81518 11.9659 6.81518 11.3017C6.81518 10.6374 7.35364 10.099 8.01787 10.099ZM8.81965 4.88731V8.89629H7.21605V4.88731H8.81965Z" fill="white"/>
                        </svg>
                        <button className="popupBtn" onClick={handleMissingClick}> 
                            Mark as Missing </button>
                    </div>
                )}

                { status === "Missing" && (
                    <div className="missingBtn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="21" viewBox="0 0 20 21" fill="none">
                            <path d="M5 9.1581L6.49707 7.964L7.75195 9.38542L10.7441 7L12 8.42141L7.51172 12L5 9.1581Z" fill="white"/>
                            <path fillRule="evenodd" clipRule="evenodd" d="M12.9944 4.80168C14.0996 5.90661 14.7634 7.37704 14.8612 8.93681C14.9589 10.4966 14.4838 12.0384 13.5252 13.2726C13.5375 13.2833 13.5495 13.2945 13.5612 13.3063L16.9632 16.7083C17.1093 16.8595 17.1901 17.0621 17.1883 17.2723C17.1865 17.4825 17.1021 17.6836 16.9535 17.8323C16.8048 17.9809 16.6037 18.0653 16.3935 18.0671C16.1833 18.0689 15.9807 17.9881 15.8295 17.842L12.4275 14.44L12.3938 14.4039C11.1048 15.4038 9.48335 15.875 7.85927 15.7217C6.23518 15.5684 4.73048 14.8022 3.65129 13.5789C2.5721 12.3556 1.99949 10.767 2.04995 9.13652C2.1004 7.506 2.77014 5.95594 3.9229 4.80168C4.51853 4.20602 5.22565 3.73352 6.0039 3.41115C6.78214 3.08877 7.61626 2.92285 8.45864 2.92285C9.30101 2.92285 10.1351 3.08877 10.9134 3.41115C11.6916 3.73352 12.3987 4.20602 12.9944 4.80168ZM11.8606 12.7394C12.3133 12.2941 12.6734 11.7634 12.92 11.1782C13.1666 10.593 13.2949 9.96476 13.2975 9.32971C13.3 8.69466 13.1769 8.06539 12.935 7.47818C12.6932 6.89097 12.3375 6.35746 11.8885 5.90841C11.4394 5.45935 10.9059 5.10366 10.3187 4.86183C9.73148 4.62 9.1022 4.49682 8.46715 4.49941C7.8321 4.50199 7.20385 4.63029 6.61863 4.87689C6.03341 5.1235 5.50281 5.48353 5.05743 5.93622C4.16738 6.84089 3.67086 8.06062 3.67602 9.32971C3.68119 10.5988 4.18763 11.8144 5.08502 12.7118C5.98241 13.6092 7.19806 14.1157 8.46715 14.1208C9.73624 14.126 10.956 13.6295 11.8606 12.7394Z" fill="white"/>
                        </svg>
                        <button className="popupBtn" onClick={handleFoundClick}> 
                            Mark as Found </button>
                    </div>
                )}
            </div>
            
        </div>
    );
}
