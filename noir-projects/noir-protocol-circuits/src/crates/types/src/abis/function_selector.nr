use crate::utils::field::field_from_bytes;
use dep::std::cmp::Eq;
use crate::traits::{Serialize, Deserialize};

global SELECTOR_SIZE = 4;

struct FunctionSelector {
    // 1st 4-bytes of abi-encoding of function.
    inner: u32,
}

impl Eq for FunctionSelector {
    fn eq(self, function_selector: FunctionSelector) -> bool {
        function_selector.inner == self.inner
    }
}

impl Serialize<1> for FunctionSelector {
    fn serialize(self: Self) -> [Field; 1] {
        [self.inner as Field]
    }
}

impl Deserialize<1> for FunctionSelector {
    fn deserialize(fields: [Field; 1]) -> Self {
        Self {
            inner: fields[0] as u32
        }
    }
}

impl FunctionSelector {
    fn to_field(self) -> Field {
        self.inner as Field
    }

    pub fn from_u32(value: u32) -> Self {
        Self { inner: value }
    }

    pub fn from_field(value: Field) -> Self {
        Self { inner: value as u32 }
    }

    pub fn from_signature<N>(signature: str<N>) -> Self {
        let bytes = signature.as_bytes();
        let hash = dep::std::hash::keccak256(bytes, bytes.len() as u32);

        let mut selector_be_bytes = [0; SELECTOR_SIZE];
        for i in 0..SELECTOR_SIZE {
            selector_be_bytes[i] = hash[i];
        }

        FunctionSelector::from_field(field_from_bytes(selector_be_bytes, true))
    }

    pub fn zero() -> Self {
        Self { inner: 0 }
    }
}
