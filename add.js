import { useWriteContract, useWaitForTransactionReceipt } from 'wagmi';
import { parseEther } from 'viem';

// Componente de Compra
export function MintButton() {
  const { writeContractAsync } = useWriteContract();

  const handlePurchase = async () => {
    try {
      // 1. Approve: Autoriza o contrato NFT a gastar seus tokens
      const approveHash = await writeContractAsync({
        address: TOKEN_ERC20_ADDRESS,
        abi: ERC20_ABI,
        functionName: 'approve',
        args: [NFT_CONTRACT_ADDRESS, parseEther('10')], // Exemplo: Preço de 10 UTK
      });
      
      console.log("Aguardando aprovação...", approveHash);

      // 2. Mint: Após aprovação, executa a compra
      const mintHash = await writeContractAsync({
        address: NFT_CONTRACT_ADDRESS,
        abi: NFT_ABI,
        functionName: 'mintNFT',
        args: ["https://ipfs.io/ipfs/seu-metadata-hash"],
      });

      alert("NFT adquirido com sucesso!");
    } catch (e) {
      console.error("Erro na transação", e);
    }
  };

  return <button onClick={handlePurchase}>Comprar NFT</button>;
}
