--Musicas mais escutadas- RO

SELECT
    m.titulo AS musica_nome,
    COUNT(h.id_musica) AS vezes_tocadas
FROM
    historico h
JOIN
    musicas m ON h.id_musica = m.id
GROUP BY
    m.id
ORDER BY
    vezes_tocadas DESC;

--Usuário que mais usou o app_RO
SELECT
    u.nome AS usuario_nome,
    COUNT(h.id_usuario) AS vezes_ouvida
FROM
    historico h
JOIN
    usuarios u ON h.id_usuario = u.id
GROUP BY
    u.id
ORDER BY
    vezes_ouvida DESC
	LIMIT 1;

--Playlists de um usuário específico (por nome ou ID)-RE

SELECT p.nome AS playlist
FROM playlists p
JOIN usuarios u ON p.id_usuario = u.id
WHERE u.nome = 'Joshua Merritt';

--Média de duração das músicas por artista-RE
SELECT
    ar.nome AS artista,

    round(AVG(m.duracao_segundos),2) AS media_duracao

FROM musicas m
JOIN albuns a ON m.id_album = a.id
JOIN artistas ar ON a.id_artista = ar.id
GROUP BY ar.id
ORDER BY media_duracao DESC;

-- CRIAR TABELA DOS ARTISTAS MAIS OUVIDOS-PA

CREATE VIEW artistas_mais_ouvidos AS
SELECT
    ar.nome AS nome_artista,
    COUNT(h.id_musica) AS total_reproducoes
FROM
    artistas AS ar
JOIN
    albuns AS a ON ar.id = a.id_artista
JOIN
    musicas AS m ON a.id = m.id_album
LEFT JOIN
    historico AS h ON m.id = h.id_musica
GROUP BY
    ar.id, ar.nome
ORDER BY
    total_reproducoes DESC, ar.nome ASC;

--POPULARIDADE DOS GENEROS MUSICAIS-PA

CREATE VIEW generos_musicais_populares AS
SELECT
    ar.genero AS nome_genero,
    COUNT(DISTINCT ar.id) AS total_artistas_no_genero,
    COUNT(h.id_musica) AS total_reproducoes_do_genero
FROM
    artistas AS ar
JOIN
    albuns AS a ON ar.id = a.id_artista
JOIN
    musicas AS m ON a.id = m.id_album
LEFT JOIN
    historico AS h ON m.id = h.id_musica
GROUP BY
    ar.genero
ORDER BY
    total_reproducoes_do_genero DESC, total_artistas_no_genero DESC, ar.genero ASC;

--GêNEROS COM MAIORES MÚSICAS-PA

CREATE VIEW generos_por_duracao_media_musica AS
SELECT
    ar.genero AS nome_genero,
    COUNT(m.id) AS total_musicas_no_genero,
    SUM(m.duracao_segundos) AS duracao_total_segundos_genero,
    ROUND(AVG(m.duracao_segundos), 2) AS duracao_media_segundos_por_musica
FROM
    artistas AS ar
JOIN
    albuns AS a ON ar.id = a.id_artista
JOIN
    musicas AS m ON a.id = m.id_album
GROUP BY
    ar.genero
ORDER BY
    duracao_media_segundos_por_musica DESC, nome_genero ASC;
    
    
-- Mostrar apenas álbuns com mais de 3 músicas
SELECT
    a.titulo AS nome_album,
    m.id_album,
    COUNT(*) AS qtd_musicas
FROM musicas m
JOIN albuns a ON m.id_album = a.id
GROUP BY m.id_album, a.titulo
HAVING COUNT(*) > 3
ORDER BY qtd_musicas DESC;

-- Atualizar o gênero musical de um artista-RE
UPDATE artistas
SET genero = 'Rock'
WHERE nome = 'Deborah Moore';

-- Remover um usuário específico-RE 
DELETE FROM usuarios
WHERE email = 'user1@example.com';

--Artistas com mais albuns lançados-PA
SELECT
  A.nome AS NomeArtista,
  COUNT(AL.id) AS TotalAlbuns
FROM
  artistas AS A
JOIN
  albuns AS AL
ON
  A.id = AL.id_artista
GROUP BY
  A.nome
HAVING
  COUNT(AL.id) > 1;