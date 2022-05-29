<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Sway</title>
	<meta name="description" content="">
	<meta name="keywords" content="">

	<!-- Font Awesome if you need it
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
	-->

	<script src="https://cdn.tailwindcss.com"></script>
	<!--Replace with your tailwind.css once created-->

	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="{{ URL::asset('css/css.css'); }} ">

</head>


<body class="leading-normal tracking-normal text-gray-900" style="font-family: 'Source Sans Pro', sans-serif;">



	<div class="h-screen pb-14 bg-right bg-cover bg-black" style="background-image:url('https://mir-s3-cdn-cf.behance.net/project_modules/fs/f1d0d572816947.5c2bcd89d519b.gif');">
		<!--Nav-->
		<div class="w-full container mx-auto p-6">

			<div class="w-full flex items-center justify-between">
				<a class="flex items-center text-teal-500 no-underline hover:no-underline font-bold text-2xl lg:text-4xl"
					href="#">
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

		<!--Main-->
		<div class="container pt-24 md:pt-48 px-6 mx-auto flex flex-wrap flex-col md:flex-row items-center">

			<!--Left Col-->
			<div class="flex flex-col w-full xl:w-2/5 justify-center lg:items-start overflow-y-hidden">
				<h1
					class="my-4 text-3xl md:text-5xl text-purple-800 font-bold leading-tight text-center md:text-left slide-in-bottom-h1">
					Sway no que te devuelvan de menos.</h1>
				<p class="font-bold text-yellow-400 md:font-normal leading-normal text-base md:text-black md:text-2xl mb-8 text-center md:text-left slide-in-bottom-subtitle">
					Una aplicación para registrar préstamos entre personas, con el objetivo de que te devuelvan menos y así evitando problemas.</p>

				<p class="text-blue-400 font-bold pb-8 lg:pb-6 text-center md:text-left fade-in">Descarga nuestra aplicación:</p>
				<div class="flex w-full justify-center md:justify-start pb-24 lg:pb-0 fade-in">
					<img src="{{ URL::asset('img/svg/App Store.svg'); }}" class="h-12 pr-4 bounce-top-icons">
					<img src="{{ URL::asset('img/svg/Play Store.svg'); }}" class="h-12 bounce-top-icons">
				</div>

			</div>

			<!--Right Col-->
			<div class="w-full xl:w-3/5 py-6 overflow-y-hidden">
				<img class="w-5/6 mx-auto lg:mr-0 slide-in-bottom" src="{{ URL::asset('img/svg/devices.svg'); }}">
			</div>

			<!--Footer-->
			<div class="w-full pt-16 md:pt-28 pb-6 text-sm text-center md:text-left fade-in">
				<a class="text-gray-500 no-underline hover:no-underline text-black md:text-white" href="#" id="year"></a>
			</div>

		</div>


	</div>
	<script>
		$(document).ready(()=>{
			console.log('Ready');
			$('#year').text('©️ '+new Date().getFullYear()+' Sway app, by Moahmed Boughima');
		})
	</script>
</body>

</html>