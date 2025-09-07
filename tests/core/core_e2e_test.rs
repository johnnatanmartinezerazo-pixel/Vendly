#[cfg(test)]
mod tests {
    use super::*;
    use uuid::Uuid;

    #[test]
    fn create_user_with_email() {
        let user_id = Uuid::new_v4();
        let email = Email::new("test@example.com").unwrap();
        let user = User::new(user_id, email);

        assert_eq!(user.email_verified, false);
        assert_eq!(user.phone.is_none(), true);
    }
}
