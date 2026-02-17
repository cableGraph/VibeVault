import React from "react";

type InputFieldProps = {
    label: string;
    placeholder?: string;
    value: string;
    type?: React.HTMLInputTypeAttribute;
    large?: boolean;
    onChange: (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => void;
};

const InputField: React.FC<InputFieldProps> = ({
    label,
    placeholder,
    value,
    type = "text",
    large = false,
    onChange,
}) => {
    return (
        <div className="flex flex-col gap-2 w-full">
            <label className="text-sm font-semibold text-gray-700">
                {label}
            </label>

            {large ? (
                <textarea
                    placeholder={placeholder}
                    value={value}
                    onChange={onChange}
                    rows={5}
                    className="
            w-full rounded-xl border border-gray-300
            px-4 py-3 text-sm
            focus:outline-none focus:ring-2 focus:ring-blue-500
            resize-none
          "
                />
            ) : (
                <input
                    type={type}
                    placeholder={placeholder}
                    value={value}
                    onChange={onChange}
                    className="
            w-full rounded-xl border border-gray-300
            px-4 py-3 text-sm
            focus:outline-none focus:ring-2 focus:ring-blue-500
          "
                />
            )}
        </div>
    );
};

export default InputField;
