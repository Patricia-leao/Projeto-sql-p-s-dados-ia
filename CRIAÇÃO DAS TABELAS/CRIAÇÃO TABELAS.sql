-- Usuários
CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    data_nascimento DATE
);

-- Artistas
CREATE TABLE artistas (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    genero TEXT
);

-- Álbuns
CREATE TABLE albuns (
    id INTEGER PRIMARY KEY,
    titulo TEXT NOT NULL,
    id_artista INTEGER,
    ano_lancamento INTEGER,
    FOREIGN KEY (id_artista) REFERENCES artistas(id)
);

-- Músicas
CREATE TABLE musicas (
    id INTEGER PRIMARY KEY,
    titulo TEXT NOT NULL,
    duracao_segundos INTEGER CHECK (duracao_segundos > 0),
    id_album INTEGER,
    FOREIGN KEY (id_album) REFERENCES albuns(id)
);

-- Playlists
CREATE TABLE playlists (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    id_usuario INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Playlist_Musicas (relacionamento N:N)
CREATE TABLE playlist_musicas (
    id_playlist INTEGER,
    id_musica INTEGER,
    PRIMARY KEY (id_playlist, id_musica),
    FOREIGN KEY (id_playlist) REFERENCES playlists(id),
    FOREIGN KEY (id_musica) REFERENCES musicas(id)
);

-- Histórico de reproduções
CREATE TABLE historico (
    id_usuario INTEGER,
    id_musica INTEGER,
    data_execucao DATETIME,
    PRIMARY KEY (id_usuario, id_musica, data_execucao),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_musica) REFERENCES musicas(id)