@REQ_MARVEL-001 @HU001 @marvel_characters_api @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: MARVEL-001 Pruebas de la API de personajes de Marvel (microservicio para gestión de personajes)

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/damontes/api/characters'
    * header Content-Type = 'application/json'

  @id:1 @obtenerPersonajes @lista200
  Scenario: T-API-MARVEL-001-CA01-Obtener todos los personajes 200 - karate
    When method get
    Then status 200
    * def schema = { id: '#number', name: '#string', alterego: '#string', description: '#string', powers: '#[] #string' }
    And match each response == schema

  @id:2 @obtenerPersonaje @exitoso200
  Scenario: T-API-MARVEL-001-CA02-Obtener personaje por ID exitoso 200 - karate
    Given path '2'
    When method get
    Then status 200
    * def schema = { id: '#number', name: '#string', alterego: '#string', description: '#string', powers: '#[] #string' }
    And match response == schema

  @id:3 @obtenerPersonaje @noExiste404
  Scenario: T-API-MARVEL-001-CA03-Obtener personaje por ID no existe 404 - karate
    Given path '999'
    When method get
    Then status 404
    And match response.error == 'Character not found'
    # And match response == { error: 'Character not found' }

  @id:4 @crearPersonaje @exitoso201
  Scenario: T-API-MARVEL-001-CA04-Crear personaje exitoso 201 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/crear_personaje_exitoso.json')
    * def random = java.lang.Math.floor(1 + Math.random() * 1000)
    * jsonData.name = jsonData.name + '-' + random
    And request jsonData
    When method post
    Then status 201
    And match response.id != null
    And match response.name == jsonData.name

  @id:5 @crearPersonaje @nombreDuplicado400
  Scenario: T-API-MARVEL-001-CA05-Crear personaje nombre duplicado 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/crear_personaje_duplicado.json')
    And request jsonData
    When method post
    Then status 400
    And match response == { error: 'Character name already exists' }

  @id:6 @crearPersonaje @faltanCampos400
  Scenario: T-API-MARVEL-001-CA06-Crear personaje faltan campos requeridos 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/crear_personaje_faltan_campos.json')
    And request jsonData
    When method post
    Then status 400
    And match response.name == 'Name is required'
    And match response.powers == 'Powers are required'

  @id:7 @actualizarPersonaje @exitoso200
  Scenario: T-API-MARVEL-001-CA07-Actualizar personaje exitoso 200 - karate
    # Se actualiza un personaje fijo (ID 2: Iron Man) para evitar dependencia de creación
    Given path '2'
    * def jsonData = read('classpath:data/marvel_characters_api/actualizar_personaje_exitoso.json')
    And request jsonData
    When method put
    Then status 200
    And match response.description == 'Updated description'
    And match response.id == 2

  @id:8 @actualizarPersonaje @noExiste404
  Scenario: T-API-MARVEL-001-CA08-Actualizar personaje no existe 404 - karate
    Given path '999'
    * def jsonData = read('classpath:data/marvel_characters_api/actualizar_personaje_no_existe.json')
    And request jsonData
    When method put
    Then status 404
    And match response == { error: 'Character not found' }

  @id:9 @eliminarPersonaje @exitoso204
  Scenario: T-API-MARVEL-001-CA09-Eliminar personaje exitoso 204 - karate
    # Se crea un personaje único para este test, se elimina y se valida la respuesta
    * def jsonData = read('classpath:data/marvel_characters_api/eliminar_personaje_unico.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/damontes/api/characters'
    And request jsonData
    When method post
    Then status 201
    * def id = response.id
    Given path id
    When method delete
    Then status 204

  @id:10 @eliminarPersonaje @noExiste404
  Scenario: T-API-MARVEL-001-CA10-Eliminar personaje no existe 404 - karate
    Given path '999'
    When method delete
    Then status 404
    And match response == { error: 'Character not found' }
