use crate::abis::{
    call_request::CallRequest, private_call_stack_item::PrivateCallStackItem,
    membership_witness::{ContractLeafMembershipWitness, FunctionLeafMembershipWitness, ReadRequestMembershipWitness}
};
use crate::address::{SaltedInitializationHash, PublicKeysHash, EthAddress};
use crate::contract_class::{ContractClassId};
use crate::mocked::{Proof, VerificationKey};
use crate::constants::{
    MAX_PRIVATE_CALL_STACK_LENGTH_PER_CALL, MAX_PUBLIC_CALL_STACK_LENGTH_PER_CALL,
    MAX_READ_REQUESTS_PER_CALL
};

struct PrivateCallData {
    call_stack_item: PrivateCallStackItem,

    private_call_stack: [CallRequest; MAX_PRIVATE_CALL_STACK_LENGTH_PER_CALL],
    public_call_stack: [CallRequest; MAX_PUBLIC_CALL_STACK_LENGTH_PER_CALL],

    proof: Proof,
    vk: VerificationKey,

    salted_initialization_hash: SaltedInitializationHash,
    public_keys_hash: PublicKeysHash,
    contract_class_artifact_hash: Field,
    contract_class_public_bytecode_commitment: Field,
    function_leaf_membership_witness: FunctionLeafMembershipWitness,
    
    read_request_membership_witnesses: [ReadRequestMembershipWitness; MAX_READ_REQUESTS_PER_CALL],

    portal_contract_address: EthAddress,
    acir_hash: Field,
}
