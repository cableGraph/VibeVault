"use client";

import InputFields from "./InputFields";
import { useState } from "react";

export default function AirdropForm() {
    const [tokenAddress, setTokenAddress] = useState("")
    const [receipients, setReceipients] = useState("")
    const [Amounts, setAmounts] = useState("")

    async function handleSubmit() {
        console.log(tokenAddress)
        console.log(receipients)
        console.log(Amounts)
    }

    return (
        <div>
            <InputFields
                label="Token address"
                placeholder="0x"
                value={tokenAddress}
                onChange={e => setTokenAddress(e.target.value)}
            />
            <InputFields
                label="Receipients"
                placeholder="0x333fa32, 0X0f3324"
                value={receipients}
                onChange={e => setReceipients(e.target.value)}
                large={true}
            />
            <InputFields
                label="Amount"
                placeholder="100, 200"
                value={Amounts}
                onChange={e => setAmounts(e.target.value)}
                large={true}
            />
            <button onClick={handleSubmit}>
                Send Tokens
            </button>
        </div>
    );
}
