/**
 * @fileoverview Contains layout and logic for the login page with a custom clerk flow.
 * 
 * @file login/page.jsx
 * @date 16 February, 2025
 * @authors Ari Goshtasby & Shayne Sidman
 *  
 */

"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { useSignIn, useAuth } from "@clerk/nextjs";
import { useClerk } from "@clerk/nextjs";
import Eyecon from "../assets/Eyecon";
import EyeconOff from "../assets/EyeconOff";
import Checkbox from "../components/Checkbox";
import Image from "next/image";
import "../app.css";

export default function Signin() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [type, setType] = useState("password");
  const [eyeColor, setEyeColor] = useState("#9B525F");
  const [error, setError] = useState("");
  const [errorBG, setErrorBG] = useState("#FFFFFF");
  const [errorBorder, setErrorBorder] = useState("#9B525F");
  const [loginAttempts, setLoginAttempts] = useState(0);
  const [rememberMe, setRememberMe] = useState(false);

  const { isLoaded, signIn, setActive } = useSignIn();
  const { isSignedIn } = useAuth();
  const { signOut } = useClerk();
  const router = useRouter();

  useEffect(() => {
    const savedEmail = localStorage.getItem("rememberedEmail");
    const savedPassword = localStorage.getItem("rememberedPassword");

    if (savedEmail && savedPassword) {
      setEmail(savedEmail);
      setPassword(savedPassword);
      setRememberMe(true);
    }
  }, []);

  useEffect(() => {
    if (isSignedIn) {
      router.push('/dashboard');
    }
  }, [isSignedIn, router]);

  const handlePassToggle = () => {
    setType((prev) => (prev === "password" ? "text" : "password"));
  };

  const resetFields = () => {
    setEmail("");
    setPassword("");
  };

  const handleLoginError = () => {
    setErrorBG("rgba(255, 44, 44, 0.2)");
    setErrorBorder("red");
    setEyeColor(eyeColor === "#9B525F" ? "red" : "#9B525F");
  };

  const typeEmail = (e) => {
    setEmail(e.target.value);
    setErrorBG("#FFFFFF");
    setErrorBorder("#9B525F");
    setError("");
    setEyeColor("#9B525F");
  };

  const typePassword = (e) => {
    setPassword(e.target.value);
    setErrorBG("#FFFFFF");
    setErrorBorder("#9B525F");
    setError("");
    setEyeColor("#9B525F");
  };

  const onButtonClick = () => {
    setLoginAttempts(loginAttempts + 1);
    setError("");

    if (loginAttempts >= 5) {
      router.push("/");
    }

    if (!email) {
      setError("Please enter your email.");
      handleLoginError();
      resetFields();
      return false;
    }

    if (!/^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)) {
      setError("Please enter a valid email.");
      handleLoginError();
      resetFields();
      return false;
    }

    if (!password) {
      setError("Please enter a password.");
      handleLoginError();
      resetFields();
      return false;
    }

    return true;
  };

  const signInWithEmail = async () => {
    if (!onButtonClick()) return;
  
    try {
      const result = await signIn.create({
        identifier: email,
        password,
      });
      
      if (result.status === "complete") {
        //LOGIC FOR SIGNING IN APPROVAL CHECK HERE
        if (rememberMe) {
          localStorage.setItem("rememberedEmail", email);
          localStorage.setItem("rememberedPassword", password);
        } else {
          localStorage.removeItem("rememberedEmail");
          localStorage.removeItem("rememberedPassword");
        }
      
        await setActive({ session: result.createdSessionId });

        // Add a delay to check the session is set before redirecting
        await new Promise((resolve) => setTimeout(resolve, 100));

        router.push("/login_confirmed");
      } else {
      }
    } catch (err) {
      console.error("Sign-in error:", err);
      
      // If Clerk returned an API error
      if (err.errors && err.errors.length > 0) {
        setError(err.errors[0].message || "Something went wrong.");
      } else {
        setError("Something went wrong. Please try again.");
      }
    
      handleLoginError();
      resetFields();
    }
  };
  

  return (
    <div className="login-bg">
      <div className="mainContainer">
        <div className="titleContainer">
          <div className="SMLogo sm-logo-large">
            <Image src="/SM_LOGO.svg" alt="No image found" fill />
          </div>
          <div className="clothing-database">CLOTHING DATABASE</div>
        </div>
        <div className="inputContainer">
          <label
            suppressHydrationWarning
            className="errorLabel"
            style={{
              backgroundColor: error ? "rgba(255, 44, 44, 0.2)" : "#FFFFFF",
              minHeight: "24px",
              color: error ? "red" : "#FFFFFF",
              padding: "4px 8px",
              display: "block",
              transition: "all 0.2s ease",
            }}
          >
            {error || ""}
          </label>

          <input
            value={email}
            name="email"
            placeholder="Email"
            onChange={typeEmail}
            className="inputBox"
            style={{ borderColor: errorBorder, padding: "0 0 0 4%" }}
          />
        </div>
        <div className="inputContainer password">
          <input
            value={password}
            name="password"
            type={type}
            placeholder="Password"
            onChange={typePassword}
            className="inputBox"
            style={{ borderColor: errorBorder, padding: "0 0 0 4%" }}
            autoComplete="current-password"
          />
          <span className={"eyecon"} onClick={handlePassToggle}>
            {type === "password" ? (
              <EyeconOff color={eyeColor} />
            ) : (
              <Eyecon color={eyeColor} />
            )}
          </span>
        </div>
        <div className="remember-pwd">
          <Checkbox
            className="check"
            label="Remember me"
            checked={rememberMe}
            onChange={() => setRememberMe((prev) => !prev)}
          />
          <button
            className="textButton"
            onClick={() => router.push("/reset_password")}
          >
            <strong className="tiny">Forgot password?</strong>
          </button>
        </div>
        <div className="inputContainer login-button">
          <input
            className="inputButton"
            type="button"
            onClick={signInWithEmail}
            value="Login"
          />
        </div>
        <div className="create-account">
          <div>Don&apos;t have an account?</div>
          <button
            className="textButton"
            onClick={() => router.push("/signup")}
          >
            <strong>Create an account</strong>
          </button>
        </div>
      </div>
    </div>
  );
}
