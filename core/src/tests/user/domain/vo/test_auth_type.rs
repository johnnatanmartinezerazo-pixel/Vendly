#[cfg(test)]
mod tests {

    //use std::convert::TryFrom;

    #[test]
    fn create_valid_auth_types() {
        // Casos válidos
        let cases = vec![
            ("password", AuthType::Password),
            ("oauth", AuthType::OAuth),
            ("saml", AuthType::SAML),
            ("oidc", AuthType::OIDC),
            ("mfa", AuthType::MFA),
        ];

        for (input, expected) in cases {
            let auth_type = AuthType::new(input).unwrap();
            assert_eq!(auth_type, expected);
            assert_eq!(auth_type.as_str(), input);
        }
    }

    #[test]
    fn create_invalid_auth_type_should_fail() {
        let invalid_inputs = vec!["", "google", "ldap", "auth", "pass-word"];
        for input in invalid_inputs {
            let result = AuthType::new(input);
            assert!(result.is_err(), "Expected error for input '{}'", input);
            assert_eq!(result.err().unwrap(), ValidationError::InvalidAuthType);
        }
    }

    #[test]
    fn display_returns_correct_string() {
        let auth_type = AuthType::OAuth;
        assert_eq!(auth_type.to_string(), "oauth");
    }

    #[test]
    fn try_from_str_works_like_new() {
        assert_eq!(AuthType::try_from("password").unwrap(), AuthType::Password);
        assert_eq!(AuthType::try_from("mfa").unwrap(), AuthType::MFA);
        assert!(AuthType::try_from("invalid").is_err());
    }
}
