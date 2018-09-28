require_relative 'lib/trabajo_final_nivel_pc'

require "test/unit"


 
class TestCandidato < Test::Unit::TestCase


   	def test_puntaje_presidente

         candidato_presidente1=Presidente.new("70000099", "Juan", "Doctor", "Plancha 01", 10,8,8)
         candidato_presidente2=Presidente.new("58555299", "Antonio", "Magíster", "Plancha 02", 5,4,10)

         candidato_vicepresidente1=Vicepresidente.new("50000244", "Javier", "Titulado", "Plancha 01", 7, 8, 9)
         candidato_vicepresidente2=Vicepresidente.new("58555244", "Jose", "Titulado", "Plancha 02", 6, 5, 10)

         candidato_director_regional1=DirectorRegional.new("90000486", "Carlos", "Magister", "Plancha 03", 9, 5, 8, "Oyon", 2)
         candidato_director_regional2=DirectorRegional.new("89885778", "Andres", "Titulado", "Plancha 04", 6, 5, 9, "Oyon", 5)

         empresa=Empresa_Datatest.new("21391239817")
         empresa.registrar(candidato_presidente1)
         empresa.registrar(candidato_presidente2)
         empresa.registrar(candidato_vicepresidente1)
         empresa.registrar(candidato_vicepresidente2)
         empresa.registrar(candidato_director_regional1)
         empresa.registrar(candidato_director_regional2)

         
	      assert_equal(8.4, candidato_presidente1.calcular_puntaje_final_encuesta)
	   	assert_equal(5.4, candidato_presidente2.calcular_puntaje_final_encuesta) 

         assert_equal(8, candidato_vicepresidente1.calcular_puntaje_final_encuesta)
         assert_equal(6.2, candidato_vicepresidente2.calcular_puntaje_final_encuesta)	

         assert_equal(3.2, candidato_director_regional1.calcular_puntaje_final_encuesta)
         assert_equal(1.2, candidato_director_regional2.calcular_puntaje_final_encuesta)

         assert_not_same("50000244",empresa.consultar_candidato("50000244").dni)

   	end

end
