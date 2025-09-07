use std::fmt;
use std::convert::TryFrom;

use super::ValidationError;

/// Tipos de autenticación soportados.
/// Esto puede crecer según las necesidades del dominio.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum AuthType {
    Password,
    OAuth,
    SAML,
    OIDC,
    MFA,
}

impl AuthType {
    /// Crea un `AuthType` a partir de un &str validando el valor.
    pub fn new(value: &str) -> Result<Self, ValidationError> {
        match value.to_lowercase().as_str() {
            "password" => Ok(AuthType::Password),
            "oauth" => Ok(AuthType::OAuth),
            "saml" => Ok(AuthType::SAML),
            "oidc" => Ok(AuthType::OIDC),
            "mfa" => Ok(AuthType::MFA),
            _ => Err(ValidationError::InvalidAuthType),
        }
    }

    /// Devuelve el `AuthType` como `&str` para persistencia o serialización.
    pub fn as_str(&self) -> &str {
        match self {
            AuthType::Password => "password",
            AuthType::OAuth => "oauth",
            AuthType::SAML => "saml",
            AuthType::OIDC => "oidc",
            AuthType::MFA => "mfa",
        }
    }
}

impl fmt::Display for AuthType {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.as_str())
    }
}

impl TryFrom<&str> for AuthType {
    type Error = ValidationError;

    fn try_from(value: &str) -> Result<Self, Self::Error> {
        AuthType::new(value)
    }
}
