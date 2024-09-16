import { useEffect, useState } from "react";

const Header = ({
  account, 
  CONNECT_WALLET, 
  setAccount, 
  setLoader,
  setOwnerModel,
  shortenAddress,
  detail,
  currency,
  ownerModel
}) => {
  const [isMetaMaskInstalled, setIsMetaMaskInstalled] = useState(false);

  useEffect(() => {
    if (typeof window.ethereum !== "undefined") {
      setIsMetaMaskInstalled(true);

      window.ethereum.on("accountsChanged", handleAccountChanged);
    }

    return () => {
      if(typeof window.ethereum !== "undefined") {
        window.ethereum.removeListener("accountsChanged", handleAccountChanged);
      }
    }
  }, []);

  const handleAccountChanged = (accounts) => {
    setAccount(accounts[0]);
  };

  const connectMetaMask = async () => {
    if(typeof window.ethereum !== "undefined") {
      try {
        const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
        setAccount(accounts[0]);
      } catch (error) {
        console.log(error)
      }
    } else {
      console.log("MetaMask is not installed");
    }

  }

  return <div className="site-header header--transparent ico-header">Header</div>;
};

export default Header;
