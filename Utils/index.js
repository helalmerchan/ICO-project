export const convertTime = () => {
    const date = new Date(time);
    const formatedDate = `${date.toLocaleDateString()} ${date.toLocaleTimeString()}`
    return formatedDate;
};

export const shortenAddress = (address) => {
    `${address?.slice(0, 5)}...${address?.slice(address.length - 5)}`;
}

