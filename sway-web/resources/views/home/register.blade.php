<!DOCTYPE html>
<html lang="en">

<head>
    <link rel="icon" href="{{ URL::asset('favicon.ico'); }}">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Sway App: Register</title>
	<meta name="description" content="">
	<meta name="keywords" content="">

	<!-- Font Awesome if you need it
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
	-->

	<script src="https://cdn.tailwindcss.com"></script>
	<!--Replace with your tailwind.css once created-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>

    <link rel="stylesheet" href="{{ URL::asset('css/css.css'); }} ">

</head>


<body class="leading-normal tracking-normal text-gray-900" style="font-family: 'Source Sans Pro', sans-serif;">



	<div class="min-h-screen pb-14 bg-right bg-cover bg-black" style="background-image:url('https://mir-s3-cdn-cf.behance.net/project_modules/fs/f1d0d572816947.5c2bcd89d519b.gif');">
		<!--Nav-->
		<div class="w-full container mx-auto p-6">

			<div class="w-full flex items-center justify-between">
				<a class="flex items-center text-teal-500 no-underline hover:no-underline font-bold text-2xl lg:text-4xl"
					href="{{ route('home')}}">
					<img class="w-1/5" src="{{ URL::asset('img/web/logo/Logo.png'); }}" alt=""> Sway
				</a>

				<div class="flex w-1/2 justify-end content-center">
					<a class="inline-block text-blue-300 no-underline hover:text-indigo-800 hover:text-underline text-center h-10 p-2 md:h-auto md:p-4"
						data-tippy-content="@twitter_handle" href="https://github.com/MohaMBS/Sway">
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
							<path
								d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
						</svg>
					</a>
				</div>

			</div>

		</div>

		<div class="z-40 flex items-center justify-center ">
            <div class="px-8 py-6 mx-4 mt-4 text-left shadow-lg md:w-1/3 lg:w-1/3 sm:w-1/3 bg-white">
                <div id="banner-g" class="hidden bg-green-400 text-xl text-center p-5"> Te has registrado. Seras redireccionado en 5 segundos.</div>
                <div id="banner-e" class="hidden bg-red-400 text-xl text-center p-5 text-white"> Algun campo ha fallado</div>
                <div class="flex justify-center">
					<img class=" h-20 text-blue-600" src="{{ URL::asset('img/web/logo/Logo.png'); }}" alt="">
                </div>
                <h3 class="text-2xl font-bold text-center">Unete a nostros</h3>
                <form id='form' method="POST" action="{{ route('passport.register')}}">
                    @csrf
                    <div class="mt-4">
                        <div>
                            <label class="block" for="name">Nombre de usuario 
                                @if($errors->any())
                                    <h4>{{$errors->first()}}</h4>
                                @endif<label>
                                    <input type="text" name="name" placeholder="Nombre de usuario"
                                        class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                        </div>
                        <span id="e-name" class="text-xs text-red-400 hidden">Nombre ya en uso intentelo con uno nuevo.</span>
                        <div class="mt-4">
                            <label class="block" for="email">Email<label>
                                    <input type="email" name="email" placeholder="Email"
                                        class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600" required>
                        </div>
                        <span id="e-email" class="text-xs text-red-400 hidden">Email ya en uso.</span>
                        <div class="mt-4">
                            <label class="block">Contraseña<label>
                                    <input type="password" name="password" placeholder="password"
                                        class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                        </div>
                        <span id="e-password" class="text-xs text-red-400 hidden">Contraseña deben de ser iguales.</span>
                        <div class="mt-4">
                            <label class="block">Confirma la Contraseña<label>
                                    <input type="password" name="confirm_password" placeholder="Password"
                                        class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                        </div>
                        <span id="e-cpassword" class="text-xs text-red-400 hidden">Contraseña deben de ser iguales.</span>
                        <div id="datos-empresa" class="hidden">
                            <div>
                                <label class="block" for="cif">Cif<label>
                                        <input type="text" name="cif" placeholder="Nombre de usuario"
                                            class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                            </div>
                            <span class="text-xs text-red-400 hidden">El cif no esta disponible.</span>
                            <div class="mt-4">
                                <label class="block" for="email">Numero fijo<label>
                                        <input type="text" name="fix_number" placeholder="Email"
                                            class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                            </div>
                            <span class="text-xs text-red-400 hidden">Escriba un numero fijo.</span>
                            <div class="mt-4">
                                <label class="block">Dirección<label>
                                        <input type="text" name="addres" placeholder="C/ Plaça Catalinya"
                                            class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                            </div>
                            <span class="text-xs text-red-400 hidden">Escriba una dirección.</span>
                            <div class="mt-4">
                                <label class="block">Pais<label>
                                        <input type="text" name="country" placeholder="España"
                                            class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                            </div>
                            <span class="text-xs text-red-400 hidden">Escriba un pais</span>
                            <div class="mt-4">
                                <label class="block">Ciudad<label>
                                        <input type="text" name="city" placeholder="Barcelona"
                                            class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                            </div>
                            <span class="text-xs text-red-400 hidden">Escriba la ciudad.</span>
                            <div class="mt-4">
                                <label class="block">Codigo Postal<label>
                                        <input type="text" name="pc" placeholder="00000"
                                            class="w-full px-4 py-2 mt-2 border rounded-md focus:outline-none focus:ring-1 focus:ring-blue-600">
                            </div>
                            <span class="text-xs text-red-400 hidden">Escriba su codigo postal.</span>
                        </div>

                        <div class="form-check">
                            <input id="soy-empresa" class="form-check-input appearance-none h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer" type="checkbox" value="" id="flexCheckChecked" 
                            >
                            <label id="empresa-button" class="form-check-label inline-block text-gray-800" for="flexCheckChecked">
                              Soy empresa
                            </label>
                          </div></form>
                        <div class="flex">
                            <button id="register" class="w-full px-6 py-2 mt-4 text-white bg-blue-600 rounded-lg hover:bg-blue-900">Crear cuenta</button>
                        </div>
                    </div>
                
            </div>
        </div>
        <!--Footer-->
        <div class="z-0 w-full pt-16 md:pt-28 pb-6 text-sm text-center md:text-left fade-in">
            <a class="text-gray-500 no-underline hover:no-underline text-white " href="#" id="year"></a>
        </div>

	</div>
	<script>
		$(document).ready(()=>{
			let company = false;
            $("#form").validate();  
            
            console.log('Ready');
			$('#year').text('©️ '+new Date().getFullYear()+' Sway app, by Moahmed Boughima');
		
            $('#soy-empresa').click(()=>{
                company = !company;
                console.log(company)
                $('#datos-empresa').toggleClass('hidden');
                setTimeout(() => {
                    window.location.replace("{{route('home')}}");
                }, 5500);
            })

                $('#register').click((e)=>{
                    if($("#form").valid()){
                        e.preventDefault();
                        console.log($('#form').serialize());
                        $.post( "{{route ('passport.register')}}", $('#form').serialize())
                        .done(function( data ) {
                            $('#banner-g').removeClass('hidden')
                            $('#banner-e').toggleClass('hidden')
                        }).fail(function(data) {
                            $('#banner-e').removeClass('hidden')
                            console.log(data.responseText);
                            res = JSON.parse(data.responseText);
                            console.log(res)
                            if(res.message.name){
                                $('#e-name').text(res.message.name);
                                $("#e-name").removeClass('hidden')
                            }else{
                                $("#e-name").addClass('hidden')
                            };
                            if(res.message.email){
                                $('#e-email').text(res.message.email)
                                $("#e-email").removeClass('hidden')
                            }else{
                                $("#e-email").addClass('hidden')
                            };
                            if(res.message.password){
                                $('#e-password').text(res.message.password)
                                $("#e-password").removeClass('hidden')
                            }else{
                                $("#e-password").addClass('hidden')
                            };
                            if(res.message.confirm_password){
                                $('#e-cpassword').text(res.message.confirm_password)
                                $("#e-cpassword").removeClass('hidden')
                            }else{
                                $("#e-cpassword").addClass('hidden')
                            };
                        });
                    };
            })
        })
	</script>
</body>

</html>