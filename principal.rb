require_relative 'lib/trabajo_final_nivel_pc'

vista = Vista.new
empresa = Empresa_Datatest.new("21391239817")
controlador = Controlador.new(vista,empresa)
condicion="S"
while condicion=="S"
	datos = vista.ingreso_datos
	controlador.registra(datos[0],datos[1], datos[2], datos[3], datos[4], datos[5],datos[6],datos[7],datos[8],datos[9])
	print "¿ Desea seguir registrando los candidatos ? S/N:"
	condicion = gets.chomp.upcase
end

puts "¿ Deseas buscar un candidato ? S/N:"
if gets.chomp.upcase=="S"
	datos = vista.ingreso_busqueda_dni
	controlador.buscar_candidato(datos[0])
end
puts "¿ Deseas listar todos los candidatos ? S/N:"

if gets.chomp.upcase=="S"
	controlador.mostrar_listacandidatos
end

puts "¿ Deseas buscar el candidato con el mayor puntaje de su categoria ? S/N:"
if gets.chomp.upcase=="S"
	datos = vista.ingreso_busqueda_tipo_candidato
	controlador.mostrar_candidato_con_mas_alto_puntaje_en_su_cat(datos[0])
end
