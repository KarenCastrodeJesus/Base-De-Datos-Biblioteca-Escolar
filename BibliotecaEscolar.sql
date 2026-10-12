-- Tabla: Autores
CREATE TABLE Autores (
    AutorID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Nacionalidad VARCHAR(40),
    FechaNacimiento DATE
);

-- Tabla: Categorias
CREATE TABLE Categorias (
    CategoriaID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(200)
);

-- Tabla: Libros
CREATE TABLE Libros (
    LibroID SERIAL PRIMARY KEY,
    Titulo VARCHAR(150) NOT NULL,
    AutorID INT NOT NULL,      
    CategoriaID INT NOT NULL,
    AnioPublicacion INT,
    Editorial VARCHAR(80),
    Precio DECIMAL(10,2) NOT NULL,
    Existencias INT NOT NULL
);

-- Tabla: Socios
CREATE TABLE Socios (
    SocioID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Carrera VARCHAR(60),
    Correo VARCHAR(100),
    Telefono VARCHAR(10),
    FechaInscripcion DATE NOT NULL
);

-- Tabla: Prestamos
CREATE TABLE Prestamos (
    PrestamoID SERIAL PRIMARY KEY,
    LibroID INT NOT NULL,        
    SocioID INT NOT NULL,        
    FechaPrestamo TIMESTAMP NOT NULL,
    FechaDevolucionEsperada DATE NOT NULL,
    FechaDevolucionReal DATE,   
    Estado VARCHAR(20) NOT NULL  
);

ALTER TABLE Autores ADD COLUMN Correo VARCHAR(100);

ALTER TABLE Socios ALTER COLUMN Telefono TYPE VARCHAR(20);

ALTER TABLE Libros DROP COLUMN Editorial;

ALTER TABLE Libros ADD COLUMN Disponible BOOLEAN;

ALTER TABLE Autores RENAME COLUMN Nacionalidad TO Pais;

ALTER TABLE Socios 
ADD CONSTRAINT UQ_Socios_Correo UNIQUE (Correo);

ALTER TABLE Libros 
ADD CONSTRAINT CK_Libros_Existencias CHECK (Existencias >= 0);

ALTER TABLE Libros 
ADD CONSTRAINT CK_Libros_Precio CHECK (Precio > 0);

ALTER TABLE Prestamos 
ADD CONSTRAINT CK_Prestamos_Estado CHECK (Estado IN ('Activo', 'Devuelto', 'Vencido'));

ALTER TABLE Prestamos 
ALTER COLUMN Estado SET DEFAULT 'Activo';

ALTER TABLE Prestamos 
ALTER COLUMN FechaPrestamo SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Libros 
ADD CONSTRAINT FK_Libros_Autores FOREIGN KEY (AutorID) REFERENCES Autores(AutorID);

ALTER TABLE Libros 
ADD CONSTRAINT FK_Libros_Categorias FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID);

ALTER TABLE Prestamos 
ADD CONSTRAINT FK_Prestamos_Libros FOREIGN KEY (LibroID) REFERENCES Libros(LibroID) ON DELETE RESTRICT;

ALTER TABLE Prestamos 
ADD CONSTRAINT FK_Prestamos_Socios FOREIGN KEY (SocioID) REFERENCES Socios(SocioID) ON DELETE RESTRICT;
