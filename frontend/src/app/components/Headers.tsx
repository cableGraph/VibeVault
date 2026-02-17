"use client"

import { ConnectButton } from "@rainbow-me/rainbowkit"
import { FaGithub } from "react-icons/fa"
import Image from "next/image"
import { useEffect, useState } from "react"

export function Header() {
    const [mounted, setMounted] = useState(false)

    useEffect(() => {
        setMounted(true)
    }, [])

    return (
        <header className="w-full border-b border-gray-200 bg-white">
            <div className="container mx-auto px-4">
                <div className="flex h-16 items-center justify-between">
                    {/* Left section – Title and tagline */}
                    <div className="flex flex-col">
                        <h1 className="text-xl font-bold text-gray-900">
                            TSender
                        </h1>
                        <p className="text-sm text-gray-600">
                            The most gas efficient airdrop contract on earth, built in huff 🐾
                        </p>
                    </div>

                    {/* Right section – Connect Button (only after mount) */}
                    <div className="flex items-center gap-4">
                        {mounted && <ConnectButton />}
                    </div>
                </div>
            </div>
        </header>
    )
}