CREATE TABLE autores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE editoras (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cidade VARCHAR(100)
);

CREATE TABLE livros (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    ano_publicacao INT,
    isbn VARCHAR(20) UNIQUE,
    autor_id INT NOT NULL,
    editora_id INT NOT NULL,
    CONSTRAINT fk_autor
        FOREIGN KEY(autor_id) 
        REFERENCES autores(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_editora
        FOREIGN KEY(editora_id) 
        REFERENCES editoras(id)
        ON DELETE CASCADE
);

INSERT INTO autores (nome) VALUES 
('J.R.R. Tolkien'),
('George Orwell'),
('Ramez Elmasri'),
('Shamkant B. Navathe'),
('Machado de Assis'),
('Stephen King'),
('J.K. Rowling'),
('Isaac Asimov'),
('Agatha Christie'),
('Sun Tzu'),
('Niccolò Machiavelli'),
('Frank Herbert'),
('Douglas Adams'),
('Andrew S. Tanenbaum'),
('Gabriel García Márquez'),
('Welliton Cunha');

INSERT INTO editoras (nome, cidade) VALUES 
('HarperCollins', 'Nova Iorque'),
('Companhia das Letras', 'São Paulo'),
('Pearson', 'Londres'),
('Rocco', 'Rio de Janeiro'),
('Aleph', 'São Paulo'),
('Suma de Letras', 'São Paulo'),
('L&PM', 'Porto Alegre'),
('Martin Claret', 'São Paulo'),
('Sextante', 'Rio de Janeiro'),
('Facimp', 'Imperatriz');

INSERT INTO livros (titulo, ano_publicacao, isbn, autor_id, editora_id) VALUES
('O Hobbit', 1937, '978-8535902773', 1, 2),
('Sistemas de Banco de Dados', 2019, '978-8543025004', 3, 3),
('Dom Casmurro', 1899, '978-8535911720', 5, 2),
('O Iluminado', 1977, '978-8560280998', 6, 6),
('Harry Potter e a Pedra Filosofal', 1997, '978-8532511010', 7, 4),
('Eu, Robô', 1950, '978-8576572008', 8, 5),
('E Não Sobrou Nenhum', 1939, '978-8525414541', 9, 7),
('A Arte da Guerra', 2007, '978-8572327025', 10, 8),
('O Príncipe', 2017, '978-8544001156', 11, 8),
('Duna', 1965, '978-8576574842', 12, 5),
('O Guia do Mochileiro das Galáxias', 1979, '978-8575422464', 13, 9),
('Redes de Computadores', 2011, '978-8576059240', 14, 3),
('It: A Coisa', 1986, '978-8560280943', 6, 6),
('Harry Potter e a Câmara Secreta', 1998, '978-8532512062', 7, 4),
('O Fim da Eternidade', 1955, '978-8576570394', 8, 5),
('Cem Anos de Solidão', 1967, '978-8535902780', 15, 2),
('Banco de Dados', 2025, '978-8590343215', 16, 10);