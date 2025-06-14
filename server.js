const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(express.json());

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'biblioteca_db',
  password: 'password',
  port: 5432,
});

app.post('/livros', async (req, res) => {
  const { titulo, ano_publicacao, isbn, autor_id, editora_id } = req.body;
  try {
    const query = `
      INSERT INTO livros (titulo, ano_publicacao, isbn, autor_id, editora_id)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *`;
    const values = [titulo, ano_publicacao, isbn, autor_id, editora_id];
    const novoLivro = await pool.query(query, values);
    res.status(201).json(novoLivro.rows[0]);
  } catch (err) {
    console.error("Erro ao criar livro:", err.message);
    res.status(500).json({ error: 'Erro no servidor' });
  }
});

app.get('/livros', async (req, res) => {
  try {
    const query = `
        SELECT
            l.id, l.titulo, l.ano_publicacao, l.isbn,
            a.nome AS autor,
            e.nome AS editora
        FROM livros l
        JOIN autores a ON l.autor_id = a.id
        JOIN editoras e ON l.editora_id = e.id
        ORDER BY l.id ASC`;
    const todosLivros = await pool.query(query);
    res.json(todosLivros.rows);
  } catch (err) {
    console.error("Erro ao listar livros:", err.message);
    res.status(500).json({ error: 'Erro no servidor' });
  }
});

app.put('/livros/:id', async (req, res) => {
    const { id } = req.params;
    const { titulo, ano_publicacao, isbn } = req.body;
    try {
        const query = `
            UPDATE livros
            SET titulo = $1, ano_publicacao = $2, isbn = $3
            WHERE id = $4
            RETURNING *`;
        const values = [titulo, ano_publicacao, isbn, id];
        const livroAtualizado = await pool.query(query, values);
        if (livroAtualizado.rows.length === 0) {
            return res.status(404).json({ error: 'Livro não encontrado.' });
        }
        res.json(livroAtualizado.rows[0]);
    } catch (err) {
        console.error("Erro ao atualizar livro:", err.message);
        res.status(500).json({ error: 'Erro no servidor' });
    }
});

app.delete('/livros/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const deletarLivro = await pool.query("DELETE FROM livros WHERE id = $1 RETURNING *", [id]);
        if (deletarLivro.rows.length === 0) {
            return res.status(404).json({ error: "Livro não encontrado." });
        }
        res.json({ message: "Livro deletado com sucesso!", livro: deletarLivro.rows[0] });
    } catch (err) {
        console.error("Erro ao deletar livro:", err.message);
        res.status(500).json({ error: 'Erro no servidor' });
    }
});

const PORTA = 3000;
app.listen(PORTA, () => {
  console.log(`Servidor rodando na porta ${PORTA}.`);
});
