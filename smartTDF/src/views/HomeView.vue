<script setup lang="ts">
</script>

<template>
  <main>
  <ul>
    <li>  1. The seller deploys the Seller Contract and lists the property for sale.</li>
    <li>2. The buyer deploys the Buyer Contract and submits an offer for the listed property.</li>
    <li> 3. The Main Contract is deployed, and the seller and buyer contracts are associated with it.</li>
    <li> 4. The surveyor is assigned by the Main Contract, and the Surveyor Contract is deployed.</li>
    <li> 5. The surveyor maps the land, determines the acreage, and provides necessary details through theSurveyor Contract.
    </li>
    <li> 6. The government authority is assigned by the Main Contract, and the Government Contract isdeployed.</li>
    <li>7. The government authority verifies the details provided by the surveyor and seller through theGovernment Contract.</li>
    <li>8. If the verification is successful, the government authority issues the title deed through theGovernment Contract.</li>
    <li> 9. The Main Contract freezes the existing Seller Contract and creates a new contract with the updatedownership details.</li>
    <li>10. The funds (if applicable) are transferred from the Main Contract to the seller's account.</li>
    <li>11. The title deed and transaction details are made available for tracking through the Main Contract.</li>
  </ul>











  </main>
</template>
