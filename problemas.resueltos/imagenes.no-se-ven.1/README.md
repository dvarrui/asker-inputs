
# Problema

No se ven las imágenes 1

# 1. Descripción

He realizado un nuevo input [Archivo](files/trigonometría.haml)
Me ha generado 153 preguntas, hay unas que las ha generado mal, no se si por la imagen incluida o algo del texto.

Fichero generado [ Archivo](files/trigonometría-moodle.xml)

Son unas preguntas de elegir 4, que sale código en la respuesta
lo que he añadido en este caso es alguna expresión matemática sencilla

# 2. Consejos

Problema y su solución
1. Hemos recibido los ficheros de la carpeta "problema"
2. Se han resuelto los problemas y se explica en esste documento.
3. Se crea un haml corregido en inputs
4. Se vuelve a generar la salida en outputs

# 3. Solución al problema

Nombres de los ficheros:
1. La extensión debe ser HAML y no html.
2. Nada de tildes , ñ o carácteres que no sean internacionales.
3. Sin espacios (usa - o _ para separar palablas)

Formato del contenido:
* Usa "asker check trigonometria.html" para comprobar la validez del contenido. Esto es al proncipio porque estamos aprendiendo. Luego no te hará falta.

```
❯ asker check inputs/trigonometria.html
Only check HAML files!
```

Hay un problema ¿lo ves?

Más consejos:
1. Las imágenes si las tienes en google drive.... para que funcione debo tener acceso... ser públicas.
2. En las imágenes deberías quitar los textos para NO dar "pistas al enemigo". :-)
3. En las definiones de imágenes no hay que dejar un espacio entre def y la llave "%def{..."
4. En las definiones de imágenes hay que dejar un espacio después de la }. Lo siento!
5. Los nombres de los conceptos... deben ser una palabra... o dos. Si es una frase larga es un problema para los alumnos.

He simplificado la sistáxis ":version => '1'" por "version: '1'". Valen las dos, pero creo que ahora es más legible, :-)
He creado el concepto trigonometría y dentro unas tablas con la información de las relaciones trigonométricas. Me parece que tiene más sentido.

Probamos

```
❯ asker check inputs/trigonometria-v2.haml
Syntax OK
```

Sigo... _135 preguntas.... ¡no está mal!_. Te lo envío.

