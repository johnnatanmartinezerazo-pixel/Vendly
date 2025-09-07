use uuid::Uuid;

use crate::user::domain::{
    Email,
    Phone,
    Username,
    ExternalId,
    UserStatus,
};

/// Entity que representa un Usuario dentro del dominio.
/// Está compuesta por Value Objects que garantizan consistencia.
#[allow(dead_code)]
#[derive(Debug, Clone)]
pub struct User {
    pub user_id: Uuid,
    pub external_id: Option<ExternalId>,
    pub username: Option<Username>,
    pub email: Email,
    pub email_verified: bool,
    pub phone: Option<Phone>,
    pub phone_verified: bool,
    pub status: UserStatus,
}

#[allow(dead_code)]
impl User {
    /// Crea un nuevo usuario con estado inicial `Pending` y verificaciones en `false`.
    pub fn new(user_id: Uuid, email: Email) -> Self {
        Self {
            user_id,
            external_id: None,
            username: None,
            email,
            email_verified: false,
            phone: None,
            phone_verified: false,
            status: UserStatus::Pending,
        }
    }

    /// Actualiza los datos del usuario. Solo los `Some(..)` se aplican.
    pub fn update(
        &mut self,
        external_id: Option<ExternalId>,
        username: Option<Username>,
        email: Option<Email>,
        phone: Option<Phone>,
        status: Option<UserStatus>,
    ) {
        if let Some(ext) = external_id {
            self.external_id = Some(ext);
        }

        if let Some(uname) = username {
            self.username = Some(uname);
        }

        if let Some(new_email) = email {
            if self.email != new_email {
                self.email = new_email;
                self.email_verified = false; // necesita nueva verificación
            }
        }

        if let Some(new_phone) = phone {
            if self.phone.as_ref() != Some(&new_phone) {
                self.phone = Some(new_phone);
                self.phone_verified = false; // necesita nueva verificación
            }
        }

        if let Some(st) = status {
            self.status = st;
        }
    }

    /// Marca el email como verificado.
    pub fn verify_email(&mut self) {
        self.email_verified = true;
    }

    /// Marca el teléfono como verificado.
    pub fn verify_phone(&mut self) {
        if self.phone.is_some() {
            self.phone_verified = true;
        }
    }

    /// Cambia el estado del usuario.
    pub fn set_status(&mut self, status: UserStatus) {
        self.status = status;
    }

    /// Asigna un username si no existe.
    pub fn set_username(&mut self, username: Username) {
        self.username = Some(username);
    }

    /// Asigna un phone si no existe.
    pub fn set_phone(&mut self, phone: Phone) {
        self.phone = Some(phone);
        self.phone_verified = false; // requiere nueva verificación
    }

    /// Asigna un external_id (ej: Google, Microsoft).
    pub fn set_external_id(&mut self, external_id: ExternalId) {
        self.external_id = Some(external_id);
    }
}
