t = Time.now
puts t.strftime("Está ingresando datos a las: %H:%M:%S")

class Candidato
	attr_accessor :dni, :nombre, :grado_instruccion	, :plancha_electoral, :prom_cal_trayectoria, :prom_cal_simpatia, :prom_cal_honestidad
	def initialize(dni, nombre, grado_instruccion, plancha_electoral, prom_cal_trayectoria, prom_cal_simpatia, prom_cal_honestidad)
		@dni = dni
		@nombre = nombre
		@grado_instruccion  = grado_instruccion
		@plancha_electoral  = plancha_electoral
		@prom_cal_trayectoria = prom_cal_trayectoria	
		@prom_cal_simpatia = prom_cal_simpatia
		@prom_cal_honestidad = prom_cal_honestidad
	end

	def calcular_puntaje_final_encuesta
		puntaje_final=0
		puntaje_final= (prom_cal_trayectoria*0.2)+(prom_cal_simpatia*0.6)+(prom_cal_honestidad*0.2)
		return puntaje_final.round(2)
	end

	def validar_datos
		raise  "El dni no se ha ingresado" if (dni==nil)
		raise  "El promedio de trayectoria no se ha ingresado" if (prom_cal_trayectoria==nil)
		raise  "El promedio de simpatia no se ha ingresado" if (prom_cal_simpatia==nil)
		raise  "El promedio de honestidad no se ha ingresado" if (prom_cal_honestidad==nil)
		raise  "El numero de dni es invalido por la cantidad de digitos : #{dni}" if (dni.length>8 ||dni.length<8)
		raise  "El promedio de trayectoria es invalido: #{prom_cal_trayectoria}" if (prom_cal_trayectoria<1 || prom_cal_trayectoria>10)
		raise  "El promedio de simpatia es invalido: #{prom_cal_simpatia}" if (prom_cal_simpatia<1 ||  prom_cal_simpatia>10)
		raise  "El promedio de honestidad es invalido: #{prom_cal_honestidad}" if (prom_cal_honestidad<1 || prom_cal_honestidad>10)
		return true
	end

end

class Presidente < Candidato
	attr_accessor
	def initialize(dni, nombre, grado_instruccion, plancha_electoral, prom_cal_trayectoria, prom_cal_simpatia, prom_cal_honestidad)
	super(dni, nombre, grado_instruccion, plancha_electoral, prom_cal_trayectoria, prom_cal_simpatia, prom_cal_honestidad)
	end
	def calcular_puntaje_final_encuesta
		super
	end
end

class Vicepresidente < Candidato
	attr_accessor
	def initialize(dni, nombre, grado_instruccion, plancha_electoral, prom_cal_trayectoria, prom_cal_simpatia, prom_cal_honestidad)
	super(dni, nombre, grado_instruccion, plancha_electoral, prom_cal_trayectoria, prom_cal_simpatia, prom_cal_honestidad)
	end
	def calcular_puntaje_final_encuesta
		super
	end
end
class DirectorRegional < Candidato
	attr_accessor :region_postulante, :calificacion_reconocimiento_local
	def initialize(dni, nombre, grado_instruccion, plancha_electoral, prom_cal_trayectoria, prom_cal_simpatia, prom_cal_honestidad, region_postulante, calificacion_reconocimiento_local)

	super(dni, nombre, grado_instruccion, plancha_electoral, prom_cal_trayectoria, prom_cal_simpatia, prom_cal_honestidad)
		@region_postulante=region_postulante
		@calificacion_reconocimiento_local=calificacion_reconocimiento_local
	end
	def calcular_puntaje_final_encuesta
		super / calificacion_reconocimiento_local
	end
end

class Empresa_Datatest
	attr_accessor :ruc, :arreglo_candidato
	def initialize(ruc)
		@ruc = ruc
		@arreglo_candidato = []
	end

	def registrar(candidato)
		begin
			candidato.validar_datos
			arreglo_candidato.push(candidato)	
		rescue Exception => e
        	raise e.message  
		end
		

	end
  
  def obtener_candidato_con_mas_alto_puntaje_en_su_cat(categoria)
    mayor=0
		datos = nil
		for p in arreglo_candidato
      if(p.class.to_s==categoria.to_s)
        if p.calcular_puntaje_final_encuesta > mayor
          mayor=p.calcular_puntaje_final_encuesta
          datos = p
        end
      end
		end
    return datos

  end

	def consultar_candidato(dni)

		datos = nil
		for p in arreglo_candidato
			if p.dni == dni
				datos = p
			end
		end
		return datos
	end

  end


class Factory
	def self.dame_objeto(tipo, *arg)
		raise "el tipo de candidato no es valido" if tipo<1 || tipo>3
		case tipo
			when 1
				Presidente.new(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6])
			when 2
				Vicepresidente.new(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6])
			when 3
				DirectorRegional.new(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8])
		end
	end
end

class Vista
	def candidato_listado(arreglo)
		puts "\a"
		puts "######################################################################################################################################"
		puts "Lista de candidatos"
		puts "______________________________________________________________________________________________________________________________________"
		puts "\tDNI \t\tNombre \t\t\tGrado de Instrucción \t\t\tPlancha Electoral \t\tPuntaje Final "
		puts "--------------------------------------------------------------------------------------------------------------------------------------"
		for p in arreglo
			puts "\t#{p.dni}\t#{p.nombre}\t\t#{p.grado_instruccion}   \t\t\t#{p.plancha_electoral}    \t\t\t#{p.calcular_puntaje_final_encuesta} "
		end
		puts "\a"
		puts "######################################################################################################################################"
	end
	def imprimir(candidato)
		puts "\a"
		puts "######################################################################################################################################"
		puts "Buscando candidato por DNI..."
		puts "______________________________________________________________________________________________________________________________________"
		puts "\a\tDNI \t\tNombre \t\t\tGrado de Instrucción \t\tPuntaje Final "
		puts "--------------------------------------------------------------------------------------------------------------------------------------"
		if candidato!=nil
			puts "\a\t#{candidato.dni}\t#{candidato.nombre} \t\t#{candidato.grado_instruccion}   \t\t#{candidato.calcular_puntaje_final_encuesta} "
		else
			puts "El dni ingresado no se encuentra registrado, por favor verificar..!"
		end
		puts "\a"
		puts "######################################################################################################################################"
	end
	def imprimir_candidato_con_mayor_puntaje_en_su_cat(candidato)
		puts "\a"
		puts "######################################################################################################################################"
		puts "Buscando candidato con mayor puntaje en su categoría..."
		puts "______________________________________________________________________________________________________________________________________"
		puts "\a\tDNI \t\tNombre \t\t\tGrado de Instrucción \t\tPuntaje Final "
		puts "--------------------------------------------------------------------------------------------------------------------------------------"
		if candidato!=nil
			puts "\a\t#{candidato.dni}\t#{candidato.nombre} \t\t#{candidato.grado_instruccion}   \t\t#{candidato.calcular_puntaje_final_encuesta} "
		else
			puts "La categoria que ha ingresado no existe, por favor verificar...!"
		end
		puts "\a"
		puts "######################################################################################################################################"
	end
	def muestra_mensaje_exepcion(msg)
		puts "######################################################################################################################################"
		puts "----  #{msg} ------"
		puts "######################################################################################################################################"
	end
	def ingreso_datos
      datos =[]
      puts "(1:PRESIDENTE)  (2:VICEPRESIDENTE) (3:DIRECTOR REGIONAL)"
      print "Ingrese el tipo de candidato:"
      tipo = gets.chomp.to_i
      datos.push(tipo)
      print "DNI: "
      dni = gets.chomp
      datos.push(dni)
      print "Nombre: "
      nombre = gets.chomp
      datos.push(nombre)
      print "Grado de Instrucción: "
      grado_instruccion = gets.chomp
      datos.push(grado_instruccion)
	  print "Plancha Electoral: "
      plancha_electoral = gets.chomp
      datos.push(plancha_electoral)
      print "Promedio Calificación Trayectoria: "
      prom_cal_trayectoria = gets.chomp.to_i
      datos.push(prom_cal_trayectoria)
      print "Promedio Calificiación Simpatía: "
      prom_cal_simpatia = gets.chomp.to_i
      datos.push(prom_cal_simpatia)
      print "Promedio Calificiación Honestidad: "
      prom_cal_honestidad = gets.chomp.to_i
      datos.push(prom_cal_honestidad)
      if tipo == 3    
	      print "Region donde postula: "
	      region=gets.chomp
	      datos.push(region)
	      print "Promedio Calificiación Reconocimiento Local: "
	      prom_local=gets.chomp.to_i
	      datos.push(prom_local)
	    else
	    	datos.push("")
	    	datos.push("")
  	 end
 
      return datos
   end

   def ingreso_busqueda_dni
   	datos = []
   	print "Ingrese el dni:"
   	dni = gets.chomp
   	datos.push(dni)

   end

   def ingreso_busqueda_tipo_candidato
   	datos = []
   	puts "(1:PRESIDENTE)  (2:VICEPRESIDENTE) (3:DIRECTOR REGIONAL)"
    print "Ingrese el tipo de candidato:"
	tipo = ""
    case gets.chomp.to_i
    when 1
    	tipo ="Presidente"
	when 2
		tipo = "Vicepresidente"
	when 3
		tipo = "DirectorRegional"		
    end
   	datos.push(tipo)

   end



end

class Controlador
	attr_accessor :vista, :empresa
	def initialize(vista, empresa)
		@vista=vista
		@empresa=empresa
	end
	def registra(tipo, *arg)
		begin
		candidato = Factory.dame_objeto(tipo, *arg)
		empresa.registrar(candidato)	
		rescue Exception => e
			vista.muestra_mensaje_exepcion(e.message)
		end
		
	end
 	def mostrar_listacandidatos
 	   arreglo = empresa.arreglo_candidato
       vista.candidato_listado(arreglo)
	end
  def mostrar_candidato_con_mas_alto_puntaje_en_su_cat(categoria)
 	   candidato2 = empresa.obtener_candidato_con_mas_alto_puntaje_en_su_cat(categoria)
       vista.imprimir_candidato_con_mayor_puntaje_en_su_cat(candidato2)
	end
  
  def buscar_candidato(dni)
		candidato = empresa.consultar_candidato(dni)
		vista.imprimir(candidato)
	end
end

=begin
vista = Vista.new
empresa = Empresa_Datatest.new("21391239817")
controlador = Controlador.new(vista,empresa)
controlador.registra(1 ,"70000099", "Juan", "Doctor", "Plancha 01", 10,8,8)
controlador.registra(2 ,"50000244", "Javier", "Titulado", "Plancha 02", 8, 8, 9)
controlador.registra(3 ,"90000486", "Carlos", "Magister", "Plancha 03", 8, 8, 5, "Oyon", 10)
controlador.registra(1 ,"47558916", "Jose", "Doctor", "Plancha 04", 9, 10, 10)


controlador.mostrar_listacandidatos
controlador.buscar_candidato("90000486")
controlador.mostrar_candidato_con_mas_alto_puntaje_en_su_cat("Presidente")
=end
